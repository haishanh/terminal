---
title: Bash脚本基础
description: Bash Scripting Basics
date: 2016-03-10
updated: 2016-03-08
---
## 什么是Bash脚本

对于我来说，Bash脚本就是Bash命令的集合。运行脚本的时候，会按(一定的)顺序执行其中的命令。这些命令可以是shell builtin命令，系统上自带的软件命令，也可以是自己安装的软件的命令。

```sh
date
echo "Hello"
```

比如说你把以上内容保存到文件`script`中。然后运行`bash script`就可以运行这个脚本了。

```sh
$ bash script
Wed Mar  9 17:14:55 CST 2016
Hello
```

## Best Practice

一般好的practice是使用`.sh`作为Bash脚本文件的后缀，所以上面的脚本可以命名成`hello.sh`，要运行这个脚本仍然是执行`bash hello.sh`。

但你也可以给脚本可执行的权限。然后执行脚本。

```sh
$ chmod +x hello.sh

$ ./hello.sh
Wed Mar  9 17:15:16 CST 2016
Hello
```

通常情况下，都可以正常执行。但Best Practice是在脚本的最开始的第一行加入[shebang][shebang] `#!/bin/bash`

脚本的运行，实际上通过解释器对脚本中的指令进行解释来执行的。Shebang可以用来指明具体用哪个解释器。

```sh
$ cat hello.sh
#!/bin/bash
date
echo "Hello"
```

## 逻辑

脚本中的逻辑让脚本变的非常强大。

```sh
#!/bin/bash

hour=$(date +%H)

if [ $hour -le 12 ]; then
  echo "Good morning!"
else
  echo "Good afternoon!"
fi
```

上面的脚本通过判断当前时间的小时数是否小于等于12来输出上午好，还是输出下午好。

```sh
$ date
Wed Mar  9 18:48:16 CST 2016

$ bash greeting.sh
Good afternoon!
```

## 函数

可重用的命令和逻辑，可以放到函数中。这样我们变可以进行重用。加上参数的使用，可以变得更灵活。

```sh
#!/bin/bash

dash_it()
{
  echo "== $@ =="
}

dash_it hello
dash_it what
```

上面的脚本中定义了一个函数`dash_it()`，其作用就是，把其所有输入参数当作一个整体，在其前后各加上2个"="号和1个空格，并输出。运行一下看看：

```sh
$ bash func.sh
== hello ==
== what is wrong with you ==
```

That's all.


[shebang]: https://en.wikipedia.org/wiki/Shebang_(Unix)
