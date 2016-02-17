---
title: mv - move (rename) files
date: 2016-01-11
updated: 2016-01-07
---
## 用来干嘛

移动和重命名文件

## Usage

```sh
mv [OPTION]... [-T] SOURCE DEST
mv [OPTION]... SOURCE... DIRECTORY
```

`mv`和`cp`目录其实非常的像。所以并没有什么可以多说的，可以认为就是`cp`操作完成以后，把源文件或目录再删除掉。

当源和目的都是文件或者都是目录时，起的就是重命名的作用

### 移动文件或目录

```sh
$ ls
dir0  dir1  file1  file2  file3

$ mv dir0 file1 file2 dir1

$ ls
dir1  file3

$ ls dir1
dir0  file1  file2

# 移动回原来的位置
$ mv dir1/* .

$ ls dir1

$ ls
dir0  dir1  file1  file2
```

### 重命名文件或目录

重命名文件

```sh
$ ls
file1

# 把file1改名成file2
$ mv file1 file2

$ ls
file2
```

重命名目录或者移动目录时，并不需要在意源目录中是否有东西。

```sh
$ ls dir1
filex  subdir

$ mv dir1 dir2

$ ls dir2
filex  subdir
```

That's it.
