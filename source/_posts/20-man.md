---
title: man
created: 2016-02-17
date: 2016-02-29
updated: 2016-02-29
---
## 用来干嘛

manual page(或man page, manpage)是Unix-like系统上非常通用的文档/手册的存在形式。命令`man`就是用来查看这些手册。任何时候，遇到不会用的命令或者看到了某个命令不熟悉的用法，你有应该「man一下」。

## 简单使用

先来看例子。

```sh
man mkdir
man sendto
```

一般情况下，运行上面的第一个命令你可以查看命令`mkdir`的用法，运行第二命令你可以查看C语言socket发送函数`sendto`的用法。

## 分类/section

正如上面例子中看到的，man可以查看的手册不仅仅是平时用的一些命令。man page包含了各种乱七八糟的东西，有命令手册，有函数文档（后面会将命令/工具/函数等统称为工具）。其实系统中的手册分9个section，如下：

 1. 可执行程序或shell命令
 2. 系统调用(kernel提供的函数)
 3. 库调用(系统上安装的库提供的函数)
 4. 特殊文件(通常在/dev中)
 5. 文件格式规范 比如/etc/passwd
 6. 游戏
 7. 其他杂项
 8. 系统管理员命令(通常只能root使用)

一般我们不会去管这些section，但需要知道它的存在。这个地方的section可以理解成*分类*。在前面的例子中我们看到man既能查看普通的命令，又可以查看C语言函数，如果有两个工具名字一样，怎么办呢。你现在可以试试在你的terminal中分别输入以下命令看看：

```sh
man 1 printf
man 3 printf
```

上面第一条命令查看的是可以在shell中直接使用的`printf`命令的手册，在man page的最上面写着*User Commands*。第二条命令查看的是C语言中的`printf`函数的手册，最上面写着*Linux Programmer's Manual*。如果省略命令中的数字，则默认查看的是shell的`printf`手册。

## man page组成

一个完整的man page包含这些模块：

 - **NAME** man page所说明的工具的名字，通常还包含一个简短的介绍
 - **SYNOPSIS** 用法概要，一般就是把所有的选项和参数列出来
 - **DESCRIPTION** 对该工具的详细描述
 - **OPTIONS** 命令中各选项的使用
 - **EXIT STATUS** 退出值的含义
 - **RETURN VALUE** 返回值的含义
 - **ERRORS** 通常函数调用会出现的错误
 - **ENVIRONMENT** 相关的环境变量
 - **FILES** 相关的文件
 - **VERSIONS** 版本
 - **NOTES** 一般是手册作者的一些提醒
 - **BUGS** 该工具中已知的bug
 - **EXAMPLE** 使用的例子
 - **AUTHORS** 作者
 - **HISTORY** 历史
 - **SEE ALSO** 相关内容

不同的man page可能包含不同的模块，也会包含上面没提到的模块。

在**SEE ALSO**中我们可以看到更多相关的内容，一般同名工具也会放在这。当你查看的`printf`不是你想查看的那个，你在SEE ALSO中通常可以看到别的section中`printf`的section号。

## More

### 分页器

man page默认使用`less`作为分页器。所以`less`中的命令都可以在man page中使用，搜索什么的很方便。

### SYNOPSIS规范

在说明一个命令的用法时，你通常看到的这样：

```sh
mkdir [OPTION]... DIRECTORY...
```

很多terminal软件中，你还会发现其中"mkdir"是粗体。

通常规范如下：

 - **粗体字** - 表示字面字符串，你在使用的时候照抄不误
 - *斜体字* - 表示可以替换的参数
 - [-a] - 表示`-a`是选项
 - [-abc] - 表示`-a`, `-b`, `-c`都是选项，当然你也可以一起使用
 - -a|-b - 表示选项`-a`和`-b`不能一起使用
 - DIRECTORY... - 表示DIRECTORY这个参数可以有多个
 - [expression]... - 方括号中的表达式expression可以有多个

需要注意的是，在很多terminal软件和设备可能不支持粗体和斜体字体的显示。还有，很多工具没有很好的遵循这个规范，或者有非常复杂的用法难以用上面的记法进行描述。

### 搜索已有的man page

关键字搜索。

```sh
$ man -k printf
asprintf (3)         - print to allocated string
ber_printf (3)       - OpenLDAP LBER simplified Basic Encoding Rules library routines for encoding
curl_mprintf (3)     - formatted output conversion
dprintf (3)          - print to a file descriptor
format (n)           - Format a string in the style of sprintf
fprintf (3)          - formatted output conversion
...
```

支持使用正则表达式搜索。

```sh
$ man -k ^printf$
printf (1)           - format and print data
printf (1p)          - write formatted output
printf (3)           - formatted output conversion
printf (3p)          - print formatted output
```

### 找出man page源文件

man page使用GNU troff(groff)格式的源文件进行格式化显示。假设想找到该原文件的位置，可以这样：

```sh
$ man -w mkdir
/usr/share/man/man1/mkdir.1.gz
```

### 在线手册

很多网站也提供在线查询manpage的功能。比如:

 * man7 [man7.org/linux/man-pages/](http://man7.org/linux/man-pages/)
 * die.net [linux.die.net/man/](http://linux.die.net/man/)

这些站点的好处就是，manpage中提及其他工具时都使用了可点击的链接，这可以让你任意驰骋在manpage的知识海洋中。网页形式的呈现对大部分人也会友好一点，查询不认识的单词什么的也很方便。而且这些站点上的manpage都会是比较新的版本。你不需要bookmark他们，平时搜索资料的时候你经常就能遇到他们。

That's it.