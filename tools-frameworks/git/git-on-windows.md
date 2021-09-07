[Back](index.md)

### Adding company certificate to GIT trusted root CA's
Run this command to check current settings:

``` 
git config -l
```

If you see this config: http.sslbackend=openssl, it means GIT will use 

```
C:\Program Files\Git\mingw64\ssl\certs\ca-bundle.crt​
or
C:\Users\username\AppData\Local\Programs\Git\mingw64\ssl\certs\ca-bundle.crt​
```

to configure GIT use the windows certificate store:
```
git config --global http.sslBackend schannel
```

### Work with SSH on windows
Install git bash on windows.
In the git bash shell you can create a .bashrc file in your userhome directory:
```
touch ~.bashrc
```

#### Create SSH key pair:
1. ssh-keygen -t rsa -b 4096 -C "<your-email-address"
2. Add the public key to your account on the git host

#### Start shh-agent automatically
 [follow this manual](https://help.github.com/en/github/authenticating-to-github/working-with-ssh-key-passphrases).

In summary you would need to run this:
```
 vi .bashrc
 :set paste
 CTRL+i
 paste the code which starts the ssh-agent automatically.
 ```

#### Check sha256 fingerprint
On the first connection the shell will ask you if you trust the server fingerprint. 