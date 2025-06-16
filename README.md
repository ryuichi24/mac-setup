<h1 align="center">Mac Setup</h1>

```bash
git clone https://github.com/ryuichi24/mac-setup.git \
    cd mac-setup \
    echo "GIT_USER_NAME=example\nGIT_USER_EMAIL=user@example.com" > .env \
    ./setup.sh --skip=mac,brew,shell,tap,cli,gui,mas,vim,vs,git
```