---
title: whoami
date: 2016-01-14
updated: 2016-01-14
---
## 用来干嘛

显示当前登录用户

## Synopsis

```text
whoami [OPTION]...
```

其实OPTION只有`--help`和`--version`两个选项。所以这个命令真的很简单啊。

```sh
$ whoami
root

$ su - haishanh

$ whoami
haishanh
```

大部分时候，我们在shell的提示符(prompt)中都会显示用户名，所以`whoami`命令用的并不多。但假设prompt中不显示当前用户名，这个命令就会非常有用了。比如在一些嵌入式环境中，不同的用户有着不同的操作权限，辨别当前「身份」会比较重要。


## More

在Bash中，环境变量`USER`也保存了当前登录用户的用户名。

```sh
echo $USER
haishnah
```

除了用户名之外，有时我们也需要关注用户ID。可以用变量环境变量`UID`查看。

```sh
$ echo $USER $UID
root 0

$ su - haishanh

$ echo $USER $UID
haishanh 1000
```

从上面看到root用户的ID是0。脚本中我们会经常用UID是不是等于0来判断，当前用户是不是root。

```
#!/bin/bash

if [ $UID -eq 0 ]; then
  echo "You are root"
else
  echo "You are not root"
fi
```


That's it.
