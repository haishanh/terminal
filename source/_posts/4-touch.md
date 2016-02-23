---
title: touch
date: 2016-01-05
updated: 2016-01-05
---
## 用来干嘛

一般用来产生一个空文件。但其实`touch`是用来修改文件的access和modification时间为当前时间。

## 知识豆

在Linux上一个文件有三个时间戳属性：

 * access time(**atime**) 表示该文件上次被读取的时间
 * modify time(**mtime**) 表示该文件**内容**上次被修改的时间
 * change time(**ctime**) 表示该文件状态(metadata)上次被修改的时间。(比如说修改权限)

使用`ls -l`看到的是mtime。使用`ls -lt`可以使用mtime来排序，新的在前。

`ls`也可以用来查看`atime`和`ctime`。`ls -ltc`显示ctime，并用其排序。`ls -ltu`显示`atime`，并用其排序。

## Usage

```sh
touch [OPTIONS]... [FILE]...
```

### 生成一个空文件

```sh
$ ls -lt
-rw-rw-r--. 1 haishanh haishanh 483 Jan  4 19:32 setup.py
-rw-rw-r--. 1 haishanh haishanh 324 Jan  4 19:32 gulpfile.js

$ touch newfile

$ ls -lt
total 8
-rw-rw-r--. 1 haishanh haishanh   0 Jan  4 19:32 newfile
-rw-rw-r--. 1 haishanh haishanh 483 Jan  4 19:32 setup.py
-rw-rw-r--. 1 haishanh haishanh 324 Jan  4 19:32 gulpfile.js
```

注意上面`newfile`的size是0.

### 修改文件的mtime

```sh
$ date
Mon Jan  4 19:52:11 CST 2016

$ touch setup.py

# setup.py的时间从19:32变为19:52
$ ls -lt
total 8
-rw-rw-r--. 1 haishanh haishanh 483 Jan  4 19:52 setup.py
-rw-rw-r--. 1 haishanh haishanh   0 Jan  4 19:49 newfile
-rw-rw-r--. 1 haishanh haishanh 324 Jan  4 19:32 gulpfile.js
```

### 只修改atime

使用`-a`选项。

```sh
$ date
Mon Jan  4 19:53:12 CST 2016

$ touch -a gulpfile.js

# mtime未变
$ ls -lt
total 8
-rw-rw-r--. 1 haishanh haishanh 483 Jan  4 19:52 setup.py
-rw-rw-r--. 1 haishanh haishanh   0 Jan  4 19:49 newfile
-rw-rw-r--. 1 haishanh haishanh 324 Jan  4 19:32 gulpfile.js

$ ls -ltu
total 8
-rw-rw-r--. 1 haishanh haishanh 324 Jan  4 19:53 gulpfile.js
-rw-rw-r--. 1 haishanh haishanh 483 Jan  4 19:52 setup.py
-rw-rw-r--. 1 haishanh haishanh   0 Jan  4 19:49 newfile
```

### 自己指定时间戳

```sh
$ ls -lt
total 8
-rw-rw-r--. 1 haishanh haishanh 483 Jan  4 19:52 setup.py
-rw-rw-r--. 1 haishanh haishanh   0 Jan  4 19:49 newfile
-rw-rw-r--. 1 haishanh haishanh 324 Jan  4 19:32 gulpfile.js

$ touch -t 01051234 setup.py

$ ls -lt
total 8
-rw-rw-r--. 1 haishanh haishanh 483 Jan  5  2016 setup.py
-rw-rw-r--. 1 haishanh haishanh   0 Jan  4 19:49 newfile
-rw-rw-r--. 1 haishanh haishanh 324 Jan  4 19:32 gulpfile.js
```

其中`-t`所需参数的格式为[[CC]YY]MMDDhhmm[.ss]。


That's it.
