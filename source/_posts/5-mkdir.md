---
title: mkdir
date: 2016-01-06
updated: 2016-01-06
---
## 用来干嘛

创建目录

## Usage

```sh
mkdir [OPTIONS]... DIRECTORY...
```

### 创建目录

```sh
# 不存在的目录或文件，会提示
$ ls dir0
ls: cannot access dir0: No such file or directory

$ mkdir dir0

$ ls dir0
```

当然你可以一次创建多个目录

```sh
mkdir dir1 dir2 dir3
```

### 创建多重目录

使用`-p`(`--parents`)选项。

```sh
# 不使用-p会报错
$ mkdir dir0/dir1/dir2
mkdir: cannot create directory 'dir0/dir1/dir2': No such file or directory

$ mkdir -p dir0/dir1/dir2
```

### 创建目录并设置成指定权限

使用`-m`(`--mode`)来指定权限。

```sh
$ mkdir dir0

$ mkdir -m 555 dir1

$ ls -ld dir*
drwxrwxr-x. 2 haishanh haishanh 6 Jan  4 20:15 dir0
dr-xr-xr-x. 2 haishanh haishanh 6 Jan  4 20:16 dir1
```

我们暂且不去管umask，所以你不知道也没关系。至少从上面能看出来通过`-m`可以把新创建的目录设置成指定权限。

That's it.
