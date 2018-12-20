aws-cert-arn ()
{
    local search_string=${1};
    if [[ -z "$search_string" ]]; then
        aws acm list-certificates --region ${2:-us-west-2} | jq '.CertificateSummaryList|sort_by(.DomainName)';
    else
        aws acm list-certificates --region ${2:-us-west-2} | jq --arg search_string "$search_string" '.CertificateSummaryList[]|select(.DomainName | contains($search_string))';
    fi
}

#### Kubernetes functions ####
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
        kubectl describe no $node | grep --color -A4 'Allocated resources' | tail -n1 | awk '{print "CPU Requests " $1 " " $2 " Memory Requests: " $5 " " $6}'
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

# Search ECR for repositories!
aws-ecr-search()
{
  local search_string=${1};
  if [[ -z "$search_string" ]]; then
    aws ecr describe-repositories | jq '.repositories|sort_by(.repositoryName)'
  else
    aws ecr describe-repositories | jq --arg search_string "$search_string" '.repositories[]|select(.repositoryName | contains($search_string))'
  fi
}
