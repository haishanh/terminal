---
title: ls - list directory contents
date: 2015-12-31
updated: 2015-12-31
---
## ls

![ls-with-color](imgs/ls-with-color.png)

Hello, 这是这个公众号的第一篇，好紧张。

作为一个介绍Unix-like系统上命令行的微信号，第一篇post介绍的必须是`ls`啊。`ls` is short for "list".

### Name

`ls` 列出目录中的内容。

### 使用方法

```sh
ls [OPTIONS]... [FILE]...
```

### 常用选项和例子

`-a`, `--all` 列出以"."开头的「隐藏」文件

```sh
$ ls
dir0  dir1  file0  file1

$ ls -a
.  ..  .dotfile  dir0  dir1  file0  file1
```

`-l` 显示详细信息


```sh
$ ls -l
total 133
drwx---r-x+ 1 haishan haishan      0 Dec 31 13:08 dir0
drwx---r-x+ 1 haishan haishan      0 Dec 31 12:28 dir1
-rw----r--  1 haishan haishan   1275 Dec 31 13:43 file0
-rw----r--  1 haishan haishan 129567 Dec 31 13:43 file1
-rwx---r-x  1 haishan haishan     25 Dec 31 13:44 test.sh
```

`-h`, `--human-readable` 友好的方式显示size的单位(默认是Byte)，一般是和`-l`一起使用

```sh
$ ls -lh
total 133K
drwx---r-x+ 1 haishan haishan    0 Dec 31 13:08 dir0
drwx---r-x+ 1 haishan haishan    0 Dec 31 12:28 dir1
-rw----r--  1 haishan haishan 1.3K Dec 31 13:43 file0
-rw----r--  1 haishan haishan 127K Dec 31 13:43 file1
-rwx---r-x  1 haishan haishan   25 Dec 31 13:44 test.sh
```


`-t` 按时间顺序排列， 最新的在前

```sh
$ ls -lht
total 133K
-rwx---r-x  1 haishan haishan   25 Dec 31 13:44 test.sh
-rw----r--  1 haishan haishan 127K Dec 31 13:43 file1
-rw----r--  1 haishan haishan 1.3K Dec 31 13:43 file0
drwx---r-x+ 1 haishan haishan    0 Dec 31 13:08 dir0
drwx---r-x+ 1 haishan haishan    0 Dec 31 12:28 dir1
```


还有一个比较有意思的是`--color`，这个需要给参数。可以是`--color=never`或`--color=auto`，使用auto时，ls会根据文件的类型和权限来显示不同的颜色，见题图。

```sh
$ ls --color=auto
dir0  dir1  file0  file1  test.sh
```

很多发行版会通过alias的方式让ls默认使用`--color=auto`。比如我们可以把以下行添加到`~/.bashrc`中（在此假设你用的Shell是Bash）

```sh
alias ls="ls --color=auto"
```

source这个文件，来立即生效。或者你也可以新进一个shell。

```sh
. ~/.bashrc
```


That's it.

**First POST, yeah!!!**
