---
title: who - show who is logged on
date: 2016-01-07
updated: 2016-01-07
---
### 用来干嘛

用来显示本机器当前的在线用户

### Usage

#### 1/ 不接任何选项

输出当前在线的用户，其中包含的信息有用户的login名，系统给该用户分配的伪终端号，用户登录的时间，以及登录源。

```sh
vagrant  pts/0        2016-01-01 01:08 (10.0.2.2)
haishanh pts/1        2016-01-01 01:08 (10.0.2.2)
root     pts/2        2016-01-01 01:08 (10.0.2.2)
vagrant  pts/3        2016-01-01 01:15 (10.0.2.2)
```

#### 2/ with `-a`, `--all`

`who`有些选项，比如打印机器启动的时间可以用`-b/--boot`。但通常我们更乐于使用`-a`，选项，因为`-a`，包含了选项`-b` `-d` `--login` `-p` `-r` `-t` `-T` `-u`。

具体这些选项的意义，并不是那么的重要。输出如下：

```sh
$ who -a
           system boot  2016-01-01 01:07
LOGIN      tty1         2016-01-01 01:08               275 id=tty1
vagrant  + pts/0        2016-01-01 01:08   .           483 (10.0.2.2)
haishanh + pts/1        2016-01-01 01:08   .           668 (10.0.2.2)
root     + pts/2        2016-01-01 01:08   .           688 (10.0.2.2)
vagrant  + pts/3        2016-01-01 01:15 00:20         965 (10.0.2.2)
```

上面的结果中，有些栏的结果并不知道是什么意思。我们可以使用`-H`选项，来显示标题(heading)，你一看便知。

```sh
$ who -aH
NAME       LINE         TIME             IDLE          PID COMMENT  EXIT
           system boot  2016-01-01 01:07
LOGIN      tty1         2016-01-01 01:08               275 id=tty1
vagrant  + pts/0        2016-01-01 01:08   .           483 (10.0.2.2)
haishanh + pts/1        2016-01-01 01:08 00:03         668 (10.0.2.2)
root     + pts/2        2016-01-01 01:08 00:03         688 (10.0.2.2)
vagrant  + pts/3        2016-01-01 01:15 00:23         965 (10.0.2.2)
```

### More

上面`who -aH`的输出中，第二栏的用户名后面都有个`+`号，这个表示该用户可以接收其他用户的消息。

  * `+` allowing `write` messages
  * `-` disallowing `write` messages
  * `?` cannot find terminal device

可以怎么使用呢？假设管理员想重启一下机器，而用户`haishanh`还在线，则管理员可以向`haishanh`的伪终端设备写入消息，来通知用户`haishanh`。

```sh
root@archlinux:~# who
vagrant  pts/0        2016-01-01 01:08 (10.0.2.2)
haishanh pts/1        2016-01-01 01:08 (10.0.2.2)
root     pts/2        2016-01-01 01:08 (10.0.2.2)
vagrant  pts/3        2016-01-01 01:15 (10.0.2.2)

root@archlinux:~# cat <<EOF> /dev/pts/1
>
> 同学，
> 我要重启下机器
> 你等会再玩？
> EOF
```

这时用户`haishanh`的终端上就会有如下输出。

```sh
[haishanh@archlinux ~]$
同学，
我要重启下机器
你等会再玩？
```

That's it.
