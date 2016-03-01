---
title: 文件压缩
date: 2016-03-01
updated: 2016-02-29
---

## 用来干嘛

文件压缩，自然是为了节省磁盘空间。在Linux上`gzip`, `bzip2`, `xz`三个命令都可以用来对文件进行压缩。这三个命令对于不同的压缩算法。而且它们都有对应的解压缩以及查看已压缩文件内容的命令。我们主要以`gzip`为例。

## 用法

`gzip`压缩文件时，使用的是Lempel-Ziv(LZ77)编码。`gunzip`用来解压缩，`zcat`用来直接查看压缩文件的内容。

```text
gzip [ -acdfhlLnNrtvV19 ] [-S suffix] [ name ...  ]
gunzip [ -acfhlLnNrtvV ] [-S suffix] [ name ...  ]
zcat [ -fhLV ] [ name ...  ]
```

`gzip`在压缩后完文件后，会默认添加`.gz`扩展名。用法：

```sh
$ ls
hello.txt

$ gzip hello.txt

$ ls
hello.txt.gz

$ file hello.txt.gz
hello.txt.gz: gzip compressed data, was "hello.txt", from Unix, last modified: Mon Feb 29 19:17:53 2016
```

`gunzip`的简单用法：

```sh
$ ls
hello.txt.gz

$ gunzip hello.txt.gz  // 或者 gzip -d hello.txt.gz

$ ls
hello.txt
```

`gunzip`的功能与`gzip`使用`-d/--decompress/--uncompress`选项相同。


zcat的简单用法：

```sh
$ cat hello.txt.gz
// 乱码输出

$ zcat hello.txt.gz  // 或者 gunzip -c hello.txt.gz
hello
```

`zcat`的功能与`gunzip`(注意这里是g**un**zip)使用`-c/--stdout/--to-stdout`选项相同。


当然在使用`gzip`的使用你也可以使用`-S .suf / --suffix .suf`的显示，修改默认压缩文件的扩展名。这样的选项大部分人应该都不会记在脑中，所以一般都是先`gzip`然后`mv`改扩展名。

```sh
$ ls
hello.txt

$ gzip -S .what hello.txt

$ ls
hello.txt.what
```

## More

`bzip2`使用的是Burrows-Wheeler block sorting文本压缩算法以及Huffman编码。使用方法和`gzip`类似，也有对应的`bunzip2`和`bzcat`命令。同样，`bunzip2`相当于`bzip2 -d`，`bzcat`相当于`bunzip2 -c`。`bzip2`默认使用`.bz2`作为扩展名。

```sh
$ bzip2 hello.txt

$ ls
hello.txt.bz2

$ bzcat hello.txt.bz2
Hello World

$ bunzip2 hello.txt.bz2

$ ls
hello.txt
```

`xz`使用xx编码，其命令用法和`gzip`与`bzip2`类似。也有对应的`unxz`和`xzcat`命令。默认扩展名是`.xz`。

对于不同的压缩命令/算法，在判断优缺点时大概需要考虑以下因素：

  * 压缩率(Compression Ratio) - 能把文件压缩到多小
  * 解压缩所需时间(Decompression Speed) - 反映到对CPU的需求
  * 解压缩的内存需求(Decompression Memory Requirement)
  * 兼容性/可用性(Compatibility and Availability) - 比如：一般要考虑别的操作系统上是否也可以解压

显然，压缩时需要的时间和内存使用不是那么的重要。

`bzip2`相比较`gzip`有更高的压缩率，而`xz`的压缩率通常比`bzip2`还高。解压时间上，通常`gzip`最快，`xz`次之，`bzip2`最慢。具体可以看[这里的benchmark][zip-bench]。

That's it.

[zip-bench]: http://tukaani.org/lzma/benchmarks.html
