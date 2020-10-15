### Install firebird

```
open ~/.bash_profile

export FIREBIRD_HOME=/Library/Frameworks/Firebird.framework/Resources
export PATH=$PATH:$FIREBIRD_HOME/bin

sudo isql

CONNECT "path"
user 'SYSDBA' password 'masterkey';

show tables;


```

