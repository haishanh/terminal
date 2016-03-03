---
title: tar
date: 2016-03-03
updated: 2016-02-29
---
## 用来干嘛

命令`tar`用来归档(Archive)文件或文件夹。通常我们用`tar`把一个或多个文件（夹）打包成一个文件。`tar`非常常用，所以它的基本用法应该要熟练掌握。

## 用法

```text
tar [OPTION...] [FILE]...
```

### 打包/归档

打包一个文件夹：

```sh
$ ls
bye.txt  dir0  hello.txt

$ ls dir0
file0  file1  subdir

$ tar -cf dir0.tar dir0

$ ls
bye.txt  dir0  dir0.tar  hello.txt
```

打包多个文件和文件夹：

```sh
$ tar -cf important-files.tar bye.txt hello.txt dir0

$ ls
bye.txt  dir0  hello.txt  important-files.tar
```

其中`-c`(`--create`)选项表示创建一个归档。而`-f ARCHIVE`(`--file=ARCHIVE`)指明要生成的归档的名字。可以看到打包完，源文件仍保存在文件系统中。

### 提取/解包/解归档

使用`-x/--extract/--get`选项可以对归档文件进行解包。此时`-f ARCHIVE`指明被解包的归档文件名字。


```sh
$ mkdir new

$ cp important-files.tar new/

$ cd new

$ tar -xf important-files.tar

$ ls
bye.txt  dir0  hello.txt  important-files.tar
```

解包出来的目录结构与打包的时候一致，并不会将归档解包到一个单独的以归档名字命名的文件夹中，这一点需要特别注意。我们可以使用选项`-C DIR / --directory=DIR`，将归档解包到指定的目录`DIR`中。

```sh
$ mkdir important

$ tar -xf important-files.tar -C important

$ ls important
bye.txt  dir0  hello.txt
```

### Verbose

在上面所有的例子中，不管是打包还是解包，运行tar时都没有输出。我们可以使用`-v / --verbose`来让`tar`在运行的过程中有输出。

```sh
# 打包
$ tar -cvf important-files.tar hello.txt bye.txt dir0
hello.txt
bye.txt
dir0/
dir0/file0
dir0/file1
dir0/subdir/

# 解包
$ tar -xvf important-files.tar -C important
bye.txt
hello.txt
dir0/
dir0/file0
dir0/file1
dir0/subdir/
```

一般在使用`tar`时，我们都会使用`-v`选项，这样可以容易确定操作的正确性。

### 不解包列出内容

如果我们不清楚归档中的内容，也不想先解包，此时可以使用`-t / --list`选项在不解包的情况下，列出归档中的内容。

```sh
$ tar -tf important-files.tar
bye.txt
hello.txt
dir0/
dir0/file0
dir0/file1
dir0/subdir/

$ tar -tvf important-files.tar
-rw-rw-r-- haishanh/haishanh 9 2016-02-29 20:00 bye.txt
-rw-rw-r-- haishanh/haishanh 12 2016-02-29 19:59 hello.txt
drwxrwxr-x haishanh/haishanh  0 2016-02-29 21:14 dir0/
-rw-rw-r-- haishanh/haishanh  6 2016-02-29 21:12 dir0/file0
-rw-rw-r-- haishanh/haishanh  5 2016-02-29 21:14 dir0/file1
drwxrwxr-x haishanh/haishanh  0 2016-02-29 21:14 dir0/subdir/
```


## With zipping

`tar`归档通常和压缩一起使用，来达到即归档又压缩的效果。`tar`可以通过以下这些选项来指定不同的压缩方法；

 * `-z / --gzip` 用来指明使用`gzip`来压缩或解压
 * `-j / --bzip2` 用来指明使用`bzip2`来压缩或解压
 * `-J / --xz` 用来指明使用`xz`来压缩或解压

比如用`bzip2`：

```sh
$ tar -jcvf important-files.tar.bz2 dir0 hello.txt bye.txt
dir0/
dir0/file0
dir0/file1
dir0/subdir/
hello.txt
bye.txt

$ ls
bye.txt  dir0  hello.txt  important-files.tar.bz2

$ mkdir importantant

$ tar -jxvf important-files.tar.bz2 -C important
dir0/
dir0/file0
dir0/file1
dir0/subdir/
hello.txt
bye.txt
```

`-z`和`-J`的使用一样。按照惯例，如果使用gzip压缩，文件扩展名用`.tar.gz`。bzip2压缩，扩展名使用`.tar.bz2`。xz压缩，扩展名使用`.tar.xz`。

需要提及的时，现在`tar`已经可以自己判断一个归档文件所使用的压缩方法。所以在解包的时候，可以不指定压缩选项，直接压缩。

```sh
$ tar -Jcvf important-files.tar.gz hello.txt bye.txt
hello.txt
bye.txt

$ tar zxvf important-files.tar.gz -C important

gzip: stdin: not in gzip format
tar: Child returned status 1
tar: Error is not recoverable: exiting now

$ tar xvf important-files.tar.gz -C important
hello.txt
bye.txt
```

上面的例子中，我们先创建一个xz来压缩的归档，但我们使用gzip压缩时所采用的文件扩展名。此时如果使用`-z`选项来解包，会报错。但如果不使用压缩选项，反而`tar`可以正确解包。

注意到上面的例子中，`-zxvf`以及`-xvf`前面的短横线我也省去了吗。这是因为`tar`内部实现的时候，考虑到不用短横线的情况了，大部分命令使用选项时你都不可以省去它。

That's it.