################################################################################
############################### Custom Functions ###############################
################################################################################

###################################
########    COLOR VARS    #########
###################################
LIGHT_BLUE='\033[1;34m'
LB='\033[1;34m'
GREEN='\033[0;32m'
G='\033[0;32m'
YELLOW='\033[1;33m'
Y='\033[1;33m'
RED='\033[0;31m'
R='\033[0;31m'
NC='\033[0m'

#### 

function check_aws_org() {
  local acct=${1}
  aws organizations list-accounts --profile 'Audit-ViewOnly' \
    | jq '.Accounts[] | select(.Id | contains("${acct}"))'
}

function start-tmux() {
  ~/tmux-start.sh
}

function ad-get-users-groups() {
  local user=${1:?"No Username Provided/"}
  dscl '/Active Directory/2TOR/All Domains' read "/Users/${user}" dsAttrTypeNative:memberOf \
    | (read -r; printf "%s\n" "$REPLY"; sort -f)
}

function ad-get-group-members() {
  local group=${1:?"No Group Provided/"}
  dscl '/Active Directory/2TOR/All Domains' read "/Groups/${group}" GroupMembership \
    | (read -r; printf "%s\n" "$REPLY"; sort -f)
}


function vpn_wrap() {
  local command="${1:-status}";
  local mfa="${2}";
  local -r _vpn_bin='/opt/cisco/anyconnect/bin/vpn';
  
  case "$command" in
    s | status)
      echo -e 'Checking current VPN status...\n';
      eval "${_vpn_bin} -s state"
    ;;
    c | connect)
      $(/opt/cisco/anyconnect/bin/vpn state | grep "Connected" > /dev/null 2>&1)
      if [[ $? == 0 ]]; then
        echo "[I] Already Connected!\n"
      else
        echo -e 'Connecting to VPN...\n';
        ~/login_scripts/_vpn_autoconnect ${mfa}
      fi
    ;;
    d | disconnect)
      echo -e 'Disconnecting from VPN...\n';
      eval "${_vpn_bin} -s disconnect"
    ;;
    *)
      echo "Invalid option '${command}' ([s]tatus|[c]onnect|[d]isconnect)";
      return 1
    ;;
  esac
}

function login() {
  local command="${1:-all}"
  local mfa="${2:-1}"

  local _vpn_login='vpn_wrap c ${mfa}'
  local _2u_login='~/login_scripts/_2u-login ${mfa}'
  local _sso_login="aws sso login --sso-session 2u-sso"
  local _ol_login='open https://2u.onelogin.com'

  case "${command}" in
    v | vpn)
      eval "${_vpn_login}"
    ;;
    t | twou)
      eval "${_2u_login}"
    ;;
    s | sso)
      eval "${_sso_login}"
    ;;
    o | ol)
      eval "${_ol_login}"
    ;;
    vts )
      eval "${_vpn_login}"
      eval "${_2u_login}"
      eval "${_sso_login}"
    ;;
    vt )
      eval "${_vpn_login}"
      eval "${_2u_login}"
    ;;
    h | -h | --help )
      echo "Available Options: v|vpn, t|twou, s|sso, o|ol, vt"
      echo "v|vpn - Just VPN"
      echo "t|twou - Just 2u-login"
      echo "s|sso - Just AWS SSO"
      echo "o|ol - Open Webpage to OneLogin"
      echo "vt - VPN and 2u-login"
    ;;
    *) 
      eval "${_vpn_login}"
      eval "${_2u_login}"
      eval "${_sso_login}"
      eval "${_ol_login}"
    ;;
  esac
}

###################################
########       ASDF       #########
###################################

function asdfm() {
    local ACTION=${1:-list}
    local PKG=${2}
    local VER=${3:-latest}

    case "${ACTION}" in
        'list')
            asdf list ${PKG}
            ;;
        'install')
            echo -e "\n${LIGHT_BLUE}[I] Installing ${VER} of ${PKG}\n${NC}"
            asdf plugin add ${PKG}
            asdf install ${PKG} ${VER}
            asdf global ${PKG} ${VER}
            asdf shell ${PKG} ${VER}
            asdf local ${PKG} ${VER}
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}[√] Success: installed ${VER} of ${PKG}\n${NC}";
            else
                echo -e "${RED}[X] Error: Install of ${PKG} Failed\n${NC}"
            fi
            ;;
        *)
            echo -e "${RED}[X] Invalid Option: ${PKG}\nValid Options: list, install\n${NC}"
            ;;
    esac
}

###################################
##### Miscellaneous Functions #####
###################################
#

function json_to_yaml() {
  local FILENAME=${1}

  MASSAGED_FILENAME="$(echo ${FILENAME} | sed -e 's/.json//g')"

  echo "---" > ${MASSAGED_FILENAME}.yml
  $(which python3) -c 'import sys, yaml, json; print(yaml.dump(json.loads(sys.stdin.read())))' < ${MASSAGED_FILENAME}.json >> ${MASSAGED_FILENAME}.yml
  truncate -s -1 ${MASSAGED_FILENAME}.yml

}

function motivate() {
    local COUNT=${1:-1}

    for ((i=1; i<=COUNT; i++)); do
        open "$(http -j get https://inspirobot.me/api\?generate=true --body)";
    done
}

function weather() {
  local LOCALITY=${1:-Sandy_Hook,CT}
  curl "wttr.in/${LOCALITY}"
}

###############################
##### Terraform Functions #####
###############################

function tfm(){
    local INPUT=${1}
    TFENV=$(which tfenv)
    
    $TFENV install ${INPUT:=min-required} && $TFENV use ${INPUT:=min-required}
}

############################
##### Git Functions #####
############################
#

# ghorg clone group
function gl_group_clone() {
    local GROUP=$1
    ghorg clone ${GROUP} \
        --protocol=ssh \
        --base-url=https://gitlab.s.fpint.net \
        --scm=gitlab \
        --token=${GHORG_GITLAB_TOKEN} \
        --path=${HOME}/work/repos \
        --skip-archived \
        --skip-forks \
        --quiet
}

# Open Current Repo (MAC ONLY) (LOCAL GITLAB B/C FLASHPOINT)
function open_repo() {
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    local url
    url=$(git config --get remote.origin.url \
      | sed -e "s/git@/https:\/\//g" \
      | sed -e "s/net:/net\//g"
    )
    open "$url"
  else
    echo 'Not inside git repository' 1>&2
    return 1
  fi
}

#Open Branch
function open_br() {
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    local url
    local branch
    branch=$(git branch --show-current)
    url=$(git config --get remote.origin.url \
      | sed -e "s/git@/https:\/\//g" \
      | sed -e "s/net:/net\//g" \
      | sed -e "s/\.git//g"
    )
    open "${url}/-/tree/${branch}"
  else
    echo 'Not inside git repository' 1>&2
    return 1
  fi
}

function gpt() {
    local INPUT=${1}
    git tag -d ${INPUT}
    git push origin ":refs/tags/${INPUT}"
}

##############################
##### GCP CLI Functions ######
##############################

which gcloud > /dev/null 2>&1
GCP_CLI_RET=$?
if [[ ${GCP_CLI_RET} -eq 0 ]]; then

  function gcp_switch() {
    local INPUT=${1:-list}
    case "${INPUT}" in
    'list')
      CURRENT_PROJECT=$(gcloud config get project)
      echo "GCP Project IDs"
      echo "Active Project: ${GREEN}${CURRENT_PROJECT}${NC}"
      echo "========================="
      while read project_name
      do
        if [[ ${project_name} == ${CURRENT_PROJECT} ]] ; then
          printf "${GREEN}${project_name}${NC}\n"
        else
          printf "${project_name}\n"
        fi
      done < <(gcloud projects list | egrep '^flp|^fp' | awk '{ print $1 }')
      ;;
    *)
      gcloud config set project "${INPUT}"
      echo "${GREEN}[✓]${NC} Project ${LIGHT_BLUE}"${INPUT}"${NC} Active!"
      ;;
    esac
  }

fi


##############################
##### AWS CLI Functions ######
##############################

which aws > /dev/null 2>&1
AWS_CLI_RET=$?
if [[ ${AWS_CLI_RET} -eq 0 ]]; then
  # Search ECR for repositories!
  function aws-ecr-search()
  {
    local search_string=${1};
    if [[ -z "$search_string" ]]; then
      aws ecr describe-repositories | jq '.repositories|sort_by(.repositoryName)'
    else
      aws ecr describe-repositories | jq --arg search_string "$search_string" '.repositories[]|select(.repositoryName | contains($search_string))'
    fi
  }
  
  function aws-cert-arn ()
  {
      local search_string=${1};
      if [[ -z "$search_string" ]]; then
          aws acm list-certificates --region ${2:-us-west-2} | jq '.CertificateSummaryList|sort_by(.DomainName)';
      else
          aws acm list-certificates --region ${2:-us-west-2} | jq --arg search_string "$search_string" '.CertificateSummaryList[]|select(.DomainName | contains($search_string))';
      fi
  }

  function aws-name-to-id () {
    local search_string=${1}
    aws ec2 describe-tags --filters "Name=tag:Name,Values=${search_string}" | jq -r '.Tags[] | select(.ResourceType=="instance") | .ResourceId'
  }

  function aws_key_print() {
    local KEYFILE=${1}
    openssl pkcs8 -in ${KEYFILE} -nocrypt -topk8 -outform DER | openssl sha1 -c
  }

  function aws_creds() {
      local profile_name=${1}
      if [[ -z "$profile_name" ]]; then
          printf "NAME\tROLE_ARN\n" | expand -t 40
          for name in $(aws configure list-profiles | sort | grep -v default);
            do printf "${name}\t$(aws configure get role_arn --profile ${name})\n" | expand -t 40;
          done
      else
          aws configure get role_arn --profile ${profile_name}
      fi
  }

fi

##############################
#### Kubernetes Functions ####
##############################

which kubectl > /dev/null 2>&1
KC_RET=$?
if [[ ${KC_RET} -eq 0 ]]; then
  
  # Quickly display / switch kubernetes contexts
  function kcsc
  {
    local context=${1}
    if [[ -z "$context" ]]; then
      kubectl config get-contexts
    else
      kubectl config use-context ${context}
    fi
  }
  
  function _kcsc_complete {
      local word=${COMP_WORDS[COMP_CWORD]}
      local list=$(kubectl config get-contexts --no-headers | tr -d '\*' | awk '{print $1}')
      list=$(compgen -W "$list" -- "$word")
      COMPREPLY=($list)
      return 0
  }
  
  
  # Quickly display / switch kubernetes namespaces
  function kcns
  {
    local namespace=${1}
    if [[ -z "$namespace" ]]; then
      kubectl get ns
    else
      local context=$(kubectl config current-context)
      echo "Setting context ${context} to namespace ${namespace}..."
      kubectl config set-context ${context} --namespace ${namespace}
    fi
  }
  
  
  function _kcns_complete {
      local word=${COMP_WORDS[COMP_CWORD]}
      local list=$(kubectl get ns --no-headers | awk '{print $1}')
      list=$(compgen -W "$list" -- "$word")
      COMPREPLY=($list)
      return 0
  }
  
  
  # Finds the WAN IP of a given kubernetes node
  function kube-node-wan
  {
    local node=${1:?}
    kubectl describe node/${node} \
      | awk '/Addresses/ {
          split($2, ips, ",");
          for (i in ips) {
            if ( match(ips[i], /(192\.168|10\.|172\.1[6789]\.|172\.2[0-9]\.|172\.3[01]\.)/) == 0 ) {
              print ips[i]
            }
          }
        }'
  }
  
  
  # Lists all kubernetes worker nodes and their WAN IP
  function kube-nodes
  {
    local nodes=$(kubectl get nodes --no-headers \
      | grep -v 'SchedulingDisabled' \
      | cut -d ' ' -f 1
    )
  
  
    for node in $nodes; do
      local node_wan=$(kube-node-wan ${node})
  
  
      echo "$node - $node_wan"
    done
  }
  
  
  # Returns the WAN IP for the node on which a given pod is running
  function kube-pod-wan
  {
    local pod=${1:?}
    local node=$(kubectl describe po ${pod} \
      |awk '/^Node:/ { split($NF, node, "/"); print node[1] }')
  
  
    kube-node-wan $node
  }
  
  
  # A quick and dirty way to show the resource availability in a kube cluster
  kubeCapacity () {
      for node in $(kubectl get no --no-headers | awk '$0 !~ /Disabled/ {print $1}')
      do
          echo -n "Node ${node} - "
          kubectl describe no $node | \
            grep --color -A4 'Allocated resources' | \
            tail -n1 | awk '{print "CPU Requests " $1 " " $2 " Memory Requests: " $5 " " $6}'
      done
  }
  
  
  # Grab a shell / execute a comand on a running pod
  function kube-shell
  {
    local pod=${1:?}
    shift
  
  
    # Some lazy argument parsing to see if a container is specified
    if  [[ "$1" == "-c" ]]; then
      shift
      local container=" -c ${1:?}"
      shift
    fi
  
  
    local cols=$(tput cols)
    local lines=$(tput lines)
    local term='xterm'
    local cmd=$@
    cmd=${cmd:-bash}
  
  
    kubectl exec -it $pod $container -- env COLUMNS=$cols LINES=$lines TERM=$term "$cmd"
  }
fi
