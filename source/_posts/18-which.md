---
title: which
date: 2016-02-24
updated: 2016-02-24
---
## 用来干嘛

显示命令的全路径

## 用法

```text
which [options] [--] programname [...]
```

`which`可以接收一个或多个命令名，然后输出这些命令的全路径。

我们在shell中运行命令时可以指定这个命令的全路径。

```sh
$ /usr/bin/ls setup.sh
setup.sh
```

但如果不指定命令的全路径，则shell会**按顺序**在环境变量`PATH`中所包含的路径中查找该命令(文件)。而使用`which`命令可以输出命令的全路径，从而我们就知道我们用的是哪个条命令。对于`PATH`的路径中有多个重名命令时，`which`的输出对查问题会非常有帮助。

比如从下面例子的输出，就能知道如果我们直接使用`git`命令时，真正会运行的是哪个命令。

```sh
$ which git
/usr/bin/git
```

### 识别alias

```sh
$ alias gcm="git commit -m"

$ which gcm
alias gcm='git commit -m'
        /usr/bin/git
```

上面的例子中可以看到`which`也正确识别了alias中用到的命令的全路径。这时因为我们现在用的`which`本身就是一个alias，在这个alias中给`which`加了`--read-alias`选项，不加任何选项是不能识别alias的。


```sh
$ /usr/bin/which gcm
/usr/bin/which: no gcm in (/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin)

$ which which
alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'
        /usr/bin/alias
        /usr/bin/which
```

如果你的系统中`which`是原始命令，那么你可以自己加这个alias。

### 查看所有匹配

`which`默认指显示`PATH`中第一个匹配目标命令的结果。使用`-a/--all`选项可以显示所有的匹配。


```sh
$ hello
hello there

$ which hello
/usr/local/sbin/hello

$ which -a hello
/usr/local/sbin/hello
/usr/sbin/hello

$ /usr/sbin/hello
yo
```

### More

`which`还有一些其他选项，从前面`which`的那个alias中你就能看到一些了。都是字面意思的长选项，用的不多，自己看看试试就好。


That's it.
