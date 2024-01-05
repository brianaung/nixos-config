# A quick guide for ssh key generation

Generate a new SSH key.
```
ssh-keygen -t ed25519 -C "your_email@example.com"
```

Add it to SSH agent.
```
eval "$(ssh-agent -s)"
```

Copy public key and do whatever you want =)).
```
cat ~/.ssh/id_ed25519.pub
```
