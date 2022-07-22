---
layout: single
---

## Using ssh 
Following this [manual](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

1. Check if you have already a key you can do this in GitBash: ```ls -al ~/.ssh``` 
2. If we need a new key: In GitBash: ```ssh-keygen -t ed25519 -C "<your-mail>"```
3. Use a proper name for your key-file (Like: github.joel.neukom)
4. Add the public key to your account on the git server
5. If you used previously https: protocol to sync you can change it to ssh with this: ```git remote set-url origin git@github.com:USERNAME/REPO.git```

#### using ssh config file 
Go to the .ssh directory /c/Users/PC_USER_NAME/.ssh/
touch config

```
Write something like
# GITHUB
Host github.com
    HostName github.com
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_rsa_hub
 
# GITLAB
Host gitlab.com
    HostName gitlab.com
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_rsa_lab
```

## Using ssh agent of git
SSH agent will make sure you won't get asked for username password all the time using git with ssh.

Install git bash on windows.
In the git bash shell you can create a .bashrc file in your userhome directory:
```
touch ~.bashrc
```
#### Start shh-agent automatically
 [follow this manual](https://help.github.com/en/github/authenticating-to-github/working-with-ssh-key-passphrases).

In summary, you would need to run this:
```
 vi .bashrc
 :set paste
 CTRL+i
 paste the code which starts the ssh-agent automatically.
```

#### Check sha256 fingerprint
On the first connection the shell will ask you if you trust the server fingerprint. 

## Using the ssh client of windows instead of git

### Adding company certificate to GIT trusted root CA's
Run this command to check current settings:

``` 
git config -l
```

If you see this config: http.sslbackend=openssl, it means GIT will use the bundled certificates: 

```
C:\Program Files\Git\mingw64\ssl\certs\ca-bundle.crt​
or
C:\Users\username\AppData\Local\Programs\Git\mingw64\ssl\certs\ca-bundle.crt​
```

to configure GIT use the windows certificate store:
```
git config --global http.sslBackend schannel
```

### Configure git to use the ssh client of windows
```
git config --global core.sshCommand "C:/Windows/System32/OpenSSH/ssh.exe"
```

```
PS> [Environment]::SetEnvironmentVariable("GIT_SSH", "$((Get-Command ssh).Source)", [System.EnvironmentVariableTarget]::User)
```

### Make sure windows ssh-agent starts automatically
Set the ssh-agent service to run automatically when the OS starts. 
```
PS> Get-Service ssh-agent | Set-Service -StartupType Automatic
```

Check if the command points to C:\Windows\System32\OpenSSH\ssh.exe
```
PS> Get-Command ssh | Select-Object Source
```
## Troubleshooting
Check if ssh-agent is even running by: ``` eval `ssh-agent -s` ```

Git would only add ssh key files automatically starting with id_
Add your ssh key to ssh-agent: ``` ssh-add ~/.ssh/id_rsa ```

Check if you can ssh to your git server:  ```ssh -v git@ssh.dev.azure.com```

Let git show you what target it has:  ```git config --get remote.origin.url```

