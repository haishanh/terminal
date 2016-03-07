---
title: Linux中的文件权限
date:
updated: 2016-03-07
---
## 文件和目录

在Linux中，通常把文件和目录一致对待，所以术语「文件」**有时**也包括目录在内。

## 权限类型

权限有三种类型(其实还有其他一些特殊权限，在此不表)： 读(read)，写(write)，执行(execute)。

对于文件和目录，这个三类型有不同的意义。

对于文件：

 * read(**r**) - 可以读取文件内容
 * write(**w**) - 可以向文件中写入和修改文件内容
 * execute(**x**) - 可以执行文件

对于目录：

 * read(**r**) - 读取目录中所包含项目（文件和目录）的名字，可ls
 * write(**w**) - 可以在目录中创建新文件或目录
 * execute(**x**) - 可以使用`cd`进入该目录，可以删除该目录

## ugo

```sh
$ ls -l /bin/who
-rwxr-xr-x. 1 root root 49832 Sep 15 21:24 /bin/who
```

上面的输出中，第一个root表示文件`/bin/who`的**拥有者**是root，第二root表示文件`/bin/who`的**关联群组**为root。其中`rwxr-xr-x`要分成3个部分。第一部分`rwx`表示的是文件拥有者的权限，此处即表示用户**拥有者**root拥有对该文件读/写/执行的权限。第二部分`r-x`表示的是在**群组**`root`中的**用户**对该文件用于读和执行的权限，但没有写的权限。第三部分`r-x`表示的是**其他用户**对该文件拥有读和执行的权限，但没有写的权限。其他用户即除了超级用户(root)，文件拥有者以及文件所关联群组内全部用户外的所有其他用户。

可以用`ugo`这样一个模式来记忆文件权限。

 * **u** (user, owner) 文件拥有者对该文件的权限
 * **g** (group) 文件关联的群组中的用户对该文件的权限
 * **o** (others) 其他用户对该文件的权限

## 例子

### 1/ 理解目录权限

文件的权限很容易理解。目录的权限会稍显的复杂一点。

```sh
$ ls -ld dir0
d-wx-wx--x. 2 haishanh haishanh 6 Jan  4 20:15 dir0

$ ls dir0
ls: cannot open directory dir0: Permission denied

$ cd dir0

$ pwd
/home/haishanh/test/dir0

$ ls
ls: cannot open directory .: Permission denied

$ touch hello
```

上面的例子中，从第一行命令的输出中可以看到。文件(目录)拥有者对目录的权限为`-wx`。由于没有`r`权限，用户不可以读取目录中的条目内容。但是有`x`权限，所以用户可以切换到该目录。也因为有`w`权限，所以用户也可以在该目录中创建文件。

### 2/ "Others"权限

```sh
$ ls -l byroot
-rw-r--r--. 1 root root 0 Jan  4 20:48 byroot

$ whoami
haishanh

$ echo "xx" > byroot
bash: byroot: Permission denied
```

这个例子中，文件`byroot`的o权限是`r--`。所以其他用户无法写入。

## chmod

命令`chmod`用来修改文件权限，chmod就是change file mode bits的意思。

### 用法

```sh
chmod [OPTION]... MODE[,MODE]... FILE...
chmod [OPTION]... OCTAL-MODE FILE...
chmod [OPTION]... --reference=RFILE FILE...
```


第一种用法中，MODE的格式为[**ugoa**...][[**+-=**][*perms*...]...]

其中ugo就是前面提到ugo模式，而a是all的意思。"perms"是由"rwxXst"中的字母的0个或多个组成的权限描述。比如说如果MODE是`u+x`就表示对文件拥有者添加执行权限，`o-wx`就表示去掉其他用户对该文件的读和执行权限。`g=r`表示把文件所关联的组权限设为读权限，如果组权限有"w"和"x"权限则去掉。`a+x`就表示ugo都添加"x"权限。

MODE描述可以有多条，用逗号相隔。

```sh
$ ls -l file0
-rw-r----- 1 vagrant vagrant 0 Mar  7 22:14 file0

$ chmod u+x file0

$ ls -l file0
-rwxr----- 1 vagrant vagrant 0 Mar  7 22:14 file0

$ chmod u-x,g+rx file0

$ ls -l file0
-rw-r-x--- 1 vagrant vagrant 0 Mar  7 22:14 file0

$ chmod g=w file0

$ ls -l file0
-rw--w---- 1 vagrant vagrant 0 Mar  7 22:14 file0
```

第二种用法是使用数字来表示权限(OCTAL-MODE)。1（二进制为001）表示"x"权限，2（二进制为010）表示"w"权限，4（二进制为100）表示"r"权限。则数字5（二进制为101）就表示"r"和"x"权限。三个数字放在一起，则能表示出ugo权限。比如说`754`表示u的权限为"rwx"，g的权限为"r-x"，o的权限为"r--"。

```sh
$ ls -l file1
-rw-r----- 1 vagrant vagrant 0 Mar  7 22:14 file1

$ chmod 754 file1

$ ls -l file1
-rwxr-xr-- 1 vagrant vagrant 0 Mar  7 22:14 file1
```

数字还可以是四位，如`2754`，其中"2"表示的是特殊权限（可以看下篇）,"754"则分别表示ugo的权限。


第三种用法就是用`--reference <file>`把目标文件的权限设置成同文件file的权限一样。比如下面的例子中，把file0的权限设置成和file1一样。

```sh
$ ls -l file0 file1
-rw--w---- 1 vagrant vagrant 0 Mar  7 22:14 file0
-rwxr-xr-- 1 vagrant vagrant 0 Mar  7 22:14 file1

$ chmod --reference file1 file0

$ ls -l file0 file1
-rwxr-xr-- 1 vagrant vagrant 0 Mar  7 22:14 file0
-rwxr-xr-- 1 vagrant vagrant 0 Mar  7 22:14 file1
```

### 修改整个目录中文件的权限

使用`-R/--recursive`选项可以将整个目录中的所有文件和子目录设置成指定的权限。

```sh
$ ls -ld dir0/file0 dir0/subdir dir0/subdir/subfile0
-rw-r----- 1 vagrant vagrant    0 Mar  7 22:41 dir0/file0
drwxr-x--- 2 vagrant vagrant 4096 Mar  7 22:42 dir0/subdir
-rw-r----- 1 vagrant vagrant    0 Mar  7 22:42 dir0/subdir/subfile0

$ chmod -R 777 dir0

$ ls -ld dir0/file0 dir0/subdir dir0/subdir/subfile0
-rwxrwxrwx 1 vagrant vagrant    0 Mar  7 22:41 dir0/file0
drwxrwxrwx 2 vagrant vagrant 4096 Mar  7 22:42 dir0/subdir
-rwxrwxrwx 1 vagrant vagrant    0 Mar  7 22:42 dir0/subdir/subfile0
```

文件权限的概念非常重要，所以需要好好理解。

That's it.
