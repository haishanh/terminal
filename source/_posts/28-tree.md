---
title: tree
date: 2016-04-18
updated: 2016-04-18
---
## 简介

`tree` 用来列出一个目录的树形结构，包含目录文件，并且是循环式的，就是说子目录树也会被展开。

很多 Linux distro(发行版) 并没有默认安装 `tree`，但 `tree` 是一个非常有用的命令，所以如果你的系统上没有的话，可以自己安装一下。

## 常用选项

不用任何选项时：

```sh
$ tree
.
├── dir1
│   ├── build
│   │   └── makefile
│   ├── README.md
│   └── src
│       ├── calc.c
│       ├── calc.h
│       ├── debug.c
│       ├── main.c
│       └── start.c
├── dir2
└── hello

4 directories, 8 files
```

使用 `-d` 选项只列出目录

```sh
$ tree -d
.
├── dir1
│   ├── build
│   └── src
└── dir2

4 directories
```

`-l` 跟随symlink，就是说如果symlink是指向一个目录，则该目录也会被展开

`-f` 打印从当前目录开始的完整目录的文件名

```sh
$ tree -f
.
├── ./dir1
│   ├── ./dir1/build
│   │   └── ./dir1/build/makefile
│   ├── ./dir1/README.md
│   └── ./dir1/src
│       ├── ./dir1/src/calc.c
│       ├── ./dir1/src/calc.h
│       ├── ./dir1/src/debug.c
│       ├── ./dir1/src/main.c
│       └── ./dir1/src/start.c
├── ./dir2
└── ./hello

4 directories, 8 files
```

`-L <level>` 指定最大目录层数为`<level>`

```sh
$ tree -L 2
.
├── dir1
│   ├── build
│   ├── README.md
│   └── src
├── dir2
└── hello

4 directories, 2 files
```

`--filelimit <#>` 如果某个目录中有超过`<#>`个条目，则不对该目录进行展开

```sh
$ tree --filelimit 4
.
├── dir1
│   ├── build
│   │   └── makefile
│   ├── README.md
│   └── src [5 entries exceeds filelimit, not opening dir]
├── dir2
└── hello

4 directories, 3 files
```

还有很多关于文件方面的选项，比如 `-p` 选项可以打印出每个文件的权限。

```sh
$ tree -L 2 -p
.
├── [drwxrwxr-x]  dir1
│   ├── [drwxrwxr-x]  build
│   ├── [-rw-rw-r--]  README.md
│   └── [drwxrwxr-x]  src
├── [drwxrwxr-x]  dir2
└── [-rw-rw-r--]  hello

4 directories, 2 files
```

`-h` 选项可以友好显示文件大小

```sh
$ tree -h
.
├── [  44]  dir1
│   ├── [  21]  build
│   │   └── [1.3K]  makefile
│   ├── [2.6K]  README.md
│   └── [  73]  src
│       ├── [192K]  calc.c
│       ├── [2.9K]  calc.h
│       ├── [384K]  debug.c
│       ├── [2.1M]  main.c
│       └── [5.1K]  start.c
├── [   6]  dir2
└── [ 15K]  hello

4 directories, 8 files
```

当然还有一些其他文件选项。然而这还没完。还有排序选项(类似`ls`中的)，显示选项等等。

使用 `-H <baseHREF>` 选项，甚至可以进行 html 输出。非常适合用于静态文件的 HTTP 或者 FTP 托管的 **index** 页面。

```sh
tree -hH '/dl/resources' > index.html
```

很多选项你还是需要自己 `man tree`，探索一下滴。

That's all.