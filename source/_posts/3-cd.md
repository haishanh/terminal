---
title: cd - change the working directory
date: 2016-01-02 
updated: 2015-12-31
---
## 用来干嘛

切换工作路径

## Usage

```sh
cd [−L|−P] [directory]
cd −
```

### point 1

虽然有`-L`, `-P`，这两个选项，但我们基本上用不上，我也没见人用过。不加任何参数和选项时，默认切换到当前用户的**HOME**目录。用户的**HOME**通常用符号`~`表示，对于root用户，其`~`为`/root`，对于其它用户(如johh)来说，其`~`**一般**是`/home/john`。(`~`一般中文叫做*波浪*号，英文叫做*tilde*符号)

```sh
root@archlinux:~# cd
root@archlinux:~# pwd
/root

[haishanh@archlinux ~]$ cd
[haishanh@archlinux ~]$ pwd
/home/haishanh
```

**Note**: shell中有个环境变量`HOME`包含了当前用户HOME目录的名字，在写脚本的时候，这个变量会非常有用。

```sh
[haishanh@archlinux ~]$ echo $HOME
/home/haishanh
```

### point 2

如果`cd`后面接了参数(为一个目录)，则切换到该目录

```sh
$ cd repo

$ pwd
/home/vagrant/repo

$ cd ~

$ pwd
/home/vagrant
```

### point 3

`cd -`可以切换到前一个工作目录。


```sh
$ pwd
/home/vagrant/repo/play

$ cd

$ pwd
/home/vagrant

$ cd -
~/repo/play

$ pwd
/home/vagrant/repo/play
```

在shell中，环境变量`PWD`包含当前工作目录的名字，而`OLDPWD`包含前一个工作目录的名字。

如果仔细观察上面的输出结果可以发现，`cd -`其实不仅切换到前一个工作目录，还会输出切换后的目录名。

可以认为`cd -`等于下面的命令

```sh
cd "$OLDPWD" && pwd
```


## 相对路径和绝对路径

在shell中，`.`号表示当前目录，`..`表示当前目录的父级目录。

```sh
$ pwd
/home/vagrant/repo/play

$ cd .

$ pwd
/home/vagrant/repo/play

$ cd ..

$ pwd
/home/vagrant/repo

$ ls ..
dotfiles  repo  usr
```

`.`和`..`都是相对于当前路径(目录)来说的。

如果一个路径，是相对于当前路径来说的，就是相对路径。

相对目录和绝对路径很容易辨别，只要是以`/`开始的路径，都是绝对路径，比如说`/home`。而`~`也是绝对路径，因为它事实上也是展开成`/root`或`/home/<user>`的。


That's it.
