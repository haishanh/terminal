---
title: cat - concatenate files and print on the standard output
date: 2016-01-12
updated: 2016-01-12
---
## 用来干嘛

将多个文件内容连接起来后，输出到标准输出。

## Usage

```sh
cat [OPTION]... [FILE]...
```

### 显示文件内容

如果只有一个FILE，则显示该文件的内容。

```sh
$ cat file1
Hello world,

This is file1.

$ cat file2
Hello there,

This is file2
```

如果FILE有多个，则将它们的内容连接起来输出。


```sh
$ cat file1 file2
Hello world,

This is file1.
Hello there,

This is file2
```

### 显示行号

在输出文件内容时，可以通过`-n` (`--number`)选项显示行号。

```sh
$ cat -n file1
     1  Hello world,
     2
     3  This is file1.
```

如果是多个文件，显示的是连接后的行号。

```sh
$ cat -n file1 file2
     1  Hello world,
     2
     3  This is file1.
     4  Hello there,
     5
     6  This is file2.
```

### 只显示非空行行号

使用`-b` (`--number-nonblank`) 可以用来显示非空行的行号。空行，不计入行数。该选项会覆盖`-n`选项。

```sh
$ cat -b file1
     1  Hello world,

     2  This is file1.
```

### 去除重复空行

使用`-s` (`--squeeze-blank`)，会将多个**连续**空行缩至一个空行。

### 显示非打印字符

`-T`, `--show-tabs`可以用来把tab制表符打印成`^I`
`-E`, `--show-ends`可以将换行符打印成`$`
`-v`, `--show-nonprinting`显示非打印字符。

`-A`，`--show-all`选项会包含以上三个选项。


```sh
$ cat file3
Hello
 space space

  <-- this is a tab
This is file3

$ cat -A file3
Hello $
 space space$
$
^I<-- this is a tab$
This is file3$
```

Windows由于和Linux/Unix使用不同的行结束符，所以两者之间的文本文件交换会常常出现问题。经常我们把在Windows上创建的配置文件放到Linux/Unix上就会出现问题。使用`-A`选项，我们就可以看出其区别。

```sh
$ cat win.txt
this file is created on a Windows machine

space space
tab tab tab%

$ cat -A win.txt
this file is created on a Windows machine^M$
^M$
space space^M$
tab^Itab^Itab%
```

可以看到行结束符是`^M$`，而*nix上是`$`。

## 知识豆

### 重定向

`cat`可以把多个文件连接到一起输出，我们通常可以利用这个特性合并文件。

`>`符号是**重定向**符号，`1>`可以重定向程序的标准输出，`2>`可以重定向程序的标准错误输出。`1>`可以简写成`>`。（当然`>`符号前面也可以是别的大于2的数字，表示将程序的该文件描述符的输出进行重定向，在Shell中我们很少用到）

```sh
$ cat file1 file2 > combined

$ cat combined
Hello world,

This is file1.
Hello there,

This is file2
```

### 行结束符

行结束符，也成换行符，end of line(EOF), line break等。

`CR`(Carriage Return)，`LR`(Line Feed)都和打字机有关。LF是把纸张向上移动，CR是把打字机的打字的触头拨至最左。在字符串中用`\r`表示CR，用`\n`表示LF。

Windows使用 `CR` + `LF`作为行结束符，而*nix系统使用 `LF`作为行结束符。


That's it.
