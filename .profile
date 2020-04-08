# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022


# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
else
    export PATH="$HOME/local/bin:$PATH"
    export PATH="$HOME/local/usr/bin:$PATH"
    export PATH="$HOME/.cargo/bin:$PATH"
    export PATH="$HOME/.local/bin":$PATH
    export LD_LIBRARY_PATH="$HOME/local/lib":"$HOME/local/lib64":$LD_LIBRARY_PATH 
    export LD_LIBRARY_PATH="$HOME/local/usr/lib":$LD_LIBRARY_PATH 
    export LD_LIBRARY_PATH="$HOME/local/lib/x86_64-linux-gnu/":$LD_LIBRARY_PATH 
fi
