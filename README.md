# Dot Files and Home Dir stuff

## Usage

On a BRAND NEW Machine or maybe one you've wiped recently... something like that.

From your home dir, do:

1. `alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'`
1. `echo ".cfg" >> .gitignore`
1. `git clone --bare git@github.com:the-real-cphillips/config.git $HOME/.cfg`
1. ```
   mkdir -p .config-backup && \
   config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
   xargs -I{} mv {} .config-backup/{}
   ```
1. `config checkout`
1. `config config --local status.showUntrackedFiles no`

That's it! 

As you update and change your dot files and things you can just do:

```
config add <changed file>
config commit -m "Made X changes in Y File"
config push
```

## TODO

Roll these steps into a meaningful script that can just be ran to do what we needed.

Some day.
