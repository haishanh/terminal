---
title: uptime
date: 2016-01-21
published: 2016-01-21
---
## 用来干嘛

显示系统运行了多长时间

## Synopsis

```text
uptime [options]
```

以下是默认输出：

```sh
$ uptime
 05:02:04 up 15 days,  9:40,  4 users,  load average: 2.10, 2.11, 2.13
```

表示系统当前时间是05:02:04，系统已经运行了15天9小时40分钟。load average后面的三个数值分别表示过去1、5和15分钟系统的平均负载。怎么理解这个数值的意义，我们等下再说。


使用`-p/--pretty`可以比较友好美观的显示系统运行时间。

```sh
$ uptime
 05:14:12 up 15 days,  9:52,  6 users,  load average: 2.25, 2.16, 2.15

$ uptime -p
up 2 weeks, 1 day, 9 hours, 52 minutes
```

使用`-s/--since`可以用来显示系统从何时开始运行的。

```sh
$ uptime -s
2016-01-05 19:21:37

$ date
Thu Jan 21 05:14:51 EST 2016
```

## Load Average

`Load Average`是系统的平均负载，表示的是CPU的忙(Busy)和闲(Idle)。

`uptime`中平均负载的结果并不会对CPU数目取均值。假设我们的平均负载是1，我们也只有一个1个CPU，那么就说明CPU一直处于忙的状态，但如果我们有4个CPU，则可以认为系统的忙和闲各占25%和75%。要注意的时候，这并不代表某一个CPU一直在忙而其他3个CPU一直在闲，这里的25%和75%是相对于整个系统而言的。

通过查看`/proc/cpuinfo`文件的内容，就可以知道系统CPU的个数，最下面一个processor的id号码加上1就是CPU个数(准确的说是逻辑CPU的个数)。

比如我的机器有16个CPU，load average是2.25，那样就可以认为系统的负载并不高。


That's it.
