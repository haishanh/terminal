---
title: date
date: 2016-01-19
updated: 2016-01-19
---
## 用来干嘛

输出或设置当前日期和时间

## Synopsis

```text
date [OPTION]... [+FORMAT]
date [-u|--utc|--universal] [MMDDhhmm[[CC]YY][.ss]]
```

默认输出是这样的：

```sh
$ date
Mon Jan 18 07:38:58 EST 2016
```

如果你**locale**设置的是中文或其他语言，输出有可能会对应这个语言。

## 指定输出格式

通过把"+"符号和格式化字符串连在一起，可以让`date`以指定的格式输出日期和时间。


```sh
$ date "+%y-%m-%d %H:%M"
16-01-18 07:52
```

其中`%y`表示2位数字的年份，`%m`表示2位数字的月份，`%d`表示2位数具体的日子，`%H`表示2位数24小时制的时间，`%M`表示2位数的分钟。

格式化字符有很多，大小写也很重要，比如说`%Y`表示的是4位数的年份。更多的见`date`的man page。在脚本中，格式化`date`的输出非常常用。

## 设置时间

通过`-s, --set=STRING`的方式，我们可以给系统设置时间。


```sh
$ date
Mon Jan 18 08:04:20 EST 2016

$ date -s "Jan 17 08:04:20 EST 2016"
Sun Jan 17 08:04:20 EST 2016
```

这个`STRING`怎么获得，我的做法就是直接使用`date`的输出，然后修改其中的字段就可以了。比如上面的例子中，修改了日期信息。


## 其他

使用`-u/--utc/--universal`选项，显示UTC时间。

```sh
$ date
Mon Jan 18 07:57:40 EST 2016

$ date -u
Mon Jan 18 12:57:43 UTC 2016

$  date "+%y-%m-%d %H:%M"
16-01-18 07:58

$ date -u "+%y-%m-%d %H:%M"
16-01-18 12:58
```

使用选项`-d, --date=STRING`，可以让`date`从对人友好的时间描述字符串"STRING"中解析日期和时间。

```sh
$ date -d "next friday"
Fri Jan 22 00:00:00 EST 2016
```

当然这个选项，玩玩就好。


That's it.
