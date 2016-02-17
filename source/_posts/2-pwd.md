---
title: pwd - print name of current/working directory
date: 2016-01-01
updated: 2016-01-01
---
`pwd` is short for **Print (current) Working Directory**.

### 用来干嘛

顾名思义就是用来打印出当前所在的目录名字。


### Usage

1/ 不接任何选项

```sh
$ pwd
/home/vagrant/repo/play/top
```

2/ With `-P`, `--physical`

假设当前目录是一个指向一个其他目录的符号链接(symlink)，那么`pwd`默认打印出的目录名字是这个符号链接的名字，使用`-P`选项可以打印出**最终**指向的「物理」路径。

```sh
$ ls
top  top-symlink  top-symlink-symlink

$ ls -ld top-symlink
lrwxrwxrwx 1 vagrant vagrant 3 Dec 31 21:52 top-symlink -> top

$ ls -ld top-symlink-symlink
lrwxrwxrwx 1 vagrant vagrant 11 Dec 31 21:56 top-symlink-symlink -> top-symlink

$ cd top-symlink-symlink

$ pwd
/home/vagrant/repo/play/top-symlink-symlink

$ pwd -P
/home/vagrant/repo/play/top
```

### More

在Bash中，环境变量`PWD`也动态包含立刻当前目录。

```sh
$ pwd
/home/vagrant/repo/play/top-symlink-symlink

$ echo $PWD
/home/vagrant/repo/play/top-symlink-symlink
```

这个变量在脚本中会用的很多。


That's it.

你学会了如何使用`pwd`命令了。当然这个命令非常简单，但在CLI下用的很多。`-P`选项其实也很少用，就算在shell脚本里面，人们应该也更倾向于使用`readlink`。
