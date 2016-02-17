---
title: cp - copy files and directories
date: 2016-01-08
updated: 2016-01-08
---
## 用来干嘛

拷贝文件和目录

## Usage

```sh
cp [OPTION]... [-T] SOURCE DEST
cp [OPTION]... SOURCE... DIRECTORY
```

### 复制单文件成另一个单文件

```sh
$ ls
file1

$ cp file1 file2

$ ls
file1  file2
```

### 复制单个文件到指定目录中

如果最后一个参数是一个目录，则源文件会被复制到该目录下

```sh
$ ls dir0

# same as: cp file1 dir1/
$ cp file1 dir0

$ ls dir0
file1
```

### 复制多个文件到指定目录中

如果你仔细看前面的Usage会发现，第二个用法(目标是目录DIRECTORY)中SOURCE后面是有省略号的，就是说源文件可以有多个。

```sh
$ ls dir1

$ cp file1 file2 dir1

$ ls dir1
file1  file2
```

### 复制目录到另一个目录下

复制目录时必须要使用`-r` (`-R`, `--recursive`)选项。

```sh
$ ls dir1

# 不加-r选项会提示跳过目录
$ cp dir0 dir1
cp: omitting directory ‘dir0’

$ cp -r dir0 dir1

$ ls dir1
dir0
```

上面的例子中，目录`dir0`中的所有文件和目录都会被拷贝到目录`dir1`中。

如果「目标」是目录，当然「源」可以是目录和文件的混合，看下面的例子。

```sh
$ ls dir1

$ cp -r dir0 file1 file2 dir1

$ ls dir1
dir0  file1  file2
```

## More

### `-i` (`--interactive`)选项。

假设DEST已经存在了，使用`-i`时，系统会提示你是否需要overwrite。输入`y`表示同意overwrite，`n`表示不同意。

```sh
$ cp file1 file2

$ cp -i file1 file2
cp: overwrite ‘file2’?
```

`cp`还有一些其他选项，但其实学习的必要性不是很大。


That's it.
