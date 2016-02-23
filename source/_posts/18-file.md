---
title: file
date: 2016-02-23
updated: 2016-02-14
tags:
---
## 用来干嘛

`file`用来检测一个文件的类型。

## Synopsis

```sh
file [-bcEhiklLNnprsvzZ0] [--apple] [--extension] [--mime-encoding] [--mime-type] [-e testname]
     [-F separator] [-f namefile] [-m magicfiles] [-P name=value] file ...
file -C [-m magicfiles]
file [--help]
```

从上面的用法或者其man page可以看到`file`可用的选项挺多的。大部分时候都不使用任何选项，所以在此不做介绍（其实我也不熟 :)）。

### 例子

对于文本文件`file`也会根据文件内容，判断其类型。

```sh
# 一个文本文件
$ file file0.txt
file0.txt: ASCII text

# Bash脚本
$ file script.sh
script.sh: Bourne-Again shell script, ASCII text executable

# C源文件
$ file test.c
test.c: C source, ASCII text
```

`file`也可以识别可执行文件

```sh
$ file a.out
a.out: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 2.6.32, BuildID[sha1]=8df7e51f8d7bdf3df73b20aeba9657512ee524b6, not stripped

$ file /usr/bin/file
/usr/bin/file: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 2.6.32, BuildID[sha1]=10636e26b99b67f759b632dd69ed150558ce24b1, stripped
```

媒体文件也不是问题，而且能给出很详细的信息。比如下面的图片文件中，给出了拍摄的相机型号，使用的处理软件等。

```sh
$ file undertheradar14.mp3
undertheradar14.mp3: Audio file with ID3 version 2.3.0, contains: MPEG ADTS, layer III, v1,  96 kbps, 44.1 kHz, JntStereo

$ file image.jpg
image.jpg: JPEG image data, JFIF standard 1.02, resolution (DPI), density 72x72, segment length 16, Exif Standard: [TIFF image data, little-endian, direntries=14, manufacturer=Canon, model=Canon EOS 5D Mark II, orientation=upper-left, xresolution=209, yresolution=217, resolutionunit=2, software=Adobe Photoshop CS3 Windows, datetime=2014:07:07 17:34:28, GPS-Data], baseline, precision 8, 5616x3744, frames 3
```

压缩和归档文件

```sh
$ file file0.txt.gz
file0.txt.gz: gzip compressed data, was "file0.txt", last modified: Sun Feb 14 15:21:53 2016, from Unix

$ file a.out.xz
a.out.xz: XZ compressed data

$ file script.tar
script.tar: POSIX tar archive (GNU)
```

设备文件，符号链接

```sh
$ file /dev/sda1
/dev/sda1: block special (8/1)

$ file /dev/tty0
/dev/tty0: character special (4/0)

$ file test.ln
test.ln: symbolic link to test.c
```

试试别的「乱七八糟」的文件

```sh
# Ruby gem
$ file rubygems-update-2.0.15.gem
rubygems-update-2.0.15.gem: POSIX tar archive

# Android安装文件
$ file shadowsocks-nightly-2.9.7.apk
shadowsocks-nightly-2.9.7.apk: Zip archive data, at least v2.0 to extract
```

可以看到`file`将它们识别为压缩或归档文件。

## More

`file`是如何判断一个文件类型的呢？

`file`按以下顺序检测一个文件：文件系统检测，Magic检测和语言检测。

文件系统检测，主要是判断文件是不是空文件或者是不是其他特殊文件。比如说字符设备文件（用`ls -l`可以看出来）就是一种特殊文件。

那什么是Magic检测呢？很多二进制/数据文件在其开头的某个或某些特定字段都会使用特殊的内容来区分其格式。这些特殊内容通常叫做"magic number"。很多应用程序依赖于magic number来识别文件的类型。比如说C源文件编译出来的可执行文件中就包含magic number。

语言检测主要就是通过检测文本文件开头的一些关键字来来猜测文本的类型。比如说`file`就是这样判断bash脚本文件和C源文件的。

That's it.
