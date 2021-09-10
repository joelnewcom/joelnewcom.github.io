[Home](/)

[Back](index.md)

## Using ssh 

1. ssh-keygen -t rsa -b 4096 -C "<your-email-address"
2. Make sure you take a proper name for your key (Like: github.joel.neukom)
3. Add the public key to your account on the git host

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