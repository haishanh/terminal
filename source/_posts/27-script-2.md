---
title: 脚本注释与debug
date: 2016-03-29
updated: 2016-03-29
---
## 代码注释

在bash脚本中，以`#`开头的行会被当作注释。合理的注释可以让阅读脚本的人更容易理解脚本所完成的任务。

当然，并不是所有以`#`开头的行都会当作注释。比如下面的例子中，`#!/bin/bash`是`#`开头的行，但它是shebang，不是注释。而`#hello`这样的行，是命令`echo`参数中的字符串，所以也不是注释。

```sh
#!/bin/bash
# "#!" as part of the shebang(used to specify the interpreter)

# "#" as part of the command parameter
echo "
#hello
#world
"
```

这个脚本运行的结果如下：

```sh
$ bash t.sh

#hello
#world

```

## debug脚本

在要debug段落前面加上`set -x`就可以让脚本在运行的时候也打印出它真正运行的命令。`set +x`可以关闭命令打印。

```sh
#!/bin/bash

echo "before enable tracing"

set -x

echo "after enable tracing"
file="/bin/bash"
ls $file

set +x

echo "after DISABLE tracing"
```

仔细看一下上面脚本运行结果：

```sh
$ bash d.sh
before enable tracing
+ echo 'after enable tracing'
after enable tracing
+ file=/bin/bash
+ ls /bin/bash
/bin/bash
+ set +x
after DISABLE tracing
```

可以看到在`set -x`和`set +x`之间的每一条运行的命令，都打印了出来，命令中使用的变量也会打印出其真实值，这些打印的命令都以"+ "开头。当你写的脚本，运行的时候出现奇怪的结果，你不要忘了使用`set -x`来debug啊。


This's all.