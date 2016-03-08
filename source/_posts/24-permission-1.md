---
title: Linux中的文件权限2
date: 2016-03-08
updated: 2016-03-08
---
![chmod](http://7fva40.com1.z0.glb.clouddn.com/chmod.jpg)

## umask

你有没有想过，创建一个文件或目录时，其默认权限是什么呢。

`umask`就是干这个事的。如果`umask`值是`022`，创建目录时其默认权限会是`777`**逐位**减去`022`，也就是`755`，创建文件时的默认权限会是`666`**逐位**减去`022`，也就是`644`。

```sh
$ umask
0022

$ touch what
$ ls -l what
-rw-r--r--. 1 root root 0 Mar  9 00:58 what

$ mkdir whathell
$ ls -ld whathell
drwxr-xr-x. 2 root root 6 Mar  9 00:58 whathell

# 将umask设置为033
$ umask 033

$ touch why

$ ls -l why
-rw-r--r--. 1 root root 0 Mar  9 01:30 why

$ mkdir whyhell

$ ls -ld whyhell
drwxr--r--. 2 root root 6 Mar  9 01:30 whyhell
```

上面例子中的`umask 033`，可以把umask设置成`033`。

`-S`选项可以以ugo的形式打印出umask。

```sh
$ umask -S
u=rwx,g=r,o=r
```

## 特殊文件权限

特殊权限通常用于可执行文件和公共目录。

### setuid权限

setuid是**set** **u**ser **id**的缩写。

```sh
$ ls -l /bin/passwd
-rwsr-xr-x. 1 root root 27832 Jun 10  2014 /bin/passwd
```

可以看到上面的例子中，文件拥有者的权限为`rws`，此处`s`就是setuid权限。setuid用于可执行文件。运行该文件的用户，会暂时使用文件拥有这的UID，也就是被给予该文件拥有者的身份。

通常setuid文件的拥有者是root用户。其作用就是让其他用户可以暂时以超级用户的身份运行该文件，来执行一些特殊任务。

#### 设置setuid权限

通过使用`chmod`在正常权限前再加一个数字`4`来设置setuid权限。

```sh
# 当前用户为haishanh
$ tcpdump -i eth0
tcpdump: eth0: You don't have permission to capture on that device
(socket: Operation not permitted)

$ which tcpudmp
/usr/sbin/tcpdump

$ ls -l /usr/sbin/tcpdump
-rwxr-xr-x. 1 root root 838864 Jun 10  2014 /usr/sbin/tcpdump

# 切换到root
$ su -
Password:  # 此处root用户密码

# 设置setuid权限
$ chmod 4755 /usr/sbin/tcpdump

# Ctrl + D 登出root用户
# 回到用户haishanh
$ ls -l /usr/sbin/tcpdump
-rwsr-xr-x. 1 root root 838864 Jun 10  2014 /usr/sbin/tcpdump

$ tcpdump -i eth0
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 65535 bytes
```

上面的例子通过给tcpdump(网络数据包抓包软件) setuid权限，来让普通用户也可以来抓包。

#### 去除setuid权限

把特殊为设置为0，就可以去除setuid权限了。

```sh
$ chmod 0775 /usr/sbin/tcpdump
```

### setgid权限

setgid权限和setuid权限类似。运行该文件是，会暂时文件所在组的GID，也就是被给予该文件所在组的用户权限。

设置setgui权限，特殊位设成`2`即可。

```sh
chmod 2755 /usr/sbin/tcpdump
```

如果要同时设置setuid和setgid，特殊为置成`6`(2+4)即可。

### Sticky Bit

Sticky bit用于保护目录中文件。如果一个目录被设置了Sticky bit，则其中的文件只能被该文件的拥有者，该目录的拥有者，以及root用户所删除。

```sh
$ ls -ld /tmp
drwxrwxrwt. 64 root root 4096 Mar  7 23:58 /tmp
```

在上面的例子，`o`部分的权限`rwt`中的`t`就表示设置了sticky bit。这就避免了`/tmp`中的内容被其他用户删除。

假设不考虑Sticky bit，由于其他用户对目录`/tmp`有`rw`权限，所以用户A可以在`/tmp`中创建一个文件，用户B也可以删除A创建的这个文件。但设置了sticky bit之后，如果B要删除A创建的文件就会报错。(此处A和B不为root。)

`chmod`上特殊为使用`1`即可设置sticky bit。

```sh
$ mkdir dir0

$ ls -ld dir0
drwxr-xr-x. 2 root root 6 Mar  8 00:19 dir0

$ chmod 1077 dir0

$ ls -ld dir0
d---rwxrwt. 2 root root 6 Mar  8 00:19 dir0
```

正如上述，setuid和setgid的使用其实存在安全性问题。所以用的场景并不多。但我们应该知道它们的存在。


That's it.