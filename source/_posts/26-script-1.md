---
title: 各种shell
date: 2016-03-17
updated: 2016-03-17
---
![Bash log](http://7fva40.com1.z0.glb.clouddn.com/bash-bg.png)

其实shell不止bash一种。比如说：

 - **sh**(Bourne Shell)，sh是Unix系统最开始默认的shell。它简洁，紧凑。在今天，基本上所有的Unix like系统都仍然安装有sh。
 - **bash**(Bourne Again Shell), bash是标准GNU shell。基本上所有的Linux发行版都使用bash作为默认shell。bash是应用最广泛的shell，即使有一些发行版不使用bash做默认shell，它也不可能没安装bash。而且bash是sh的超集，兼容sh的语法。
 - **csh**(C Shell), csh的语法来源于C语言，所以C程序员很喜欢csh。
 - **tcsh***(TENEX C Shell), tcsh是csh的超集，更友好，速度更快。
 - **ksh**(Korn Shell)，深受有Unix背景的用户所喜欢。
 - **zsh**(Z Shell)，zsh的命令补全功能强大，而且可扩展性很好，对bash的兼容性也很好。
 - **fish**(Friendly Interactive Shell)，和zsh很像，在命令补全和扩展上比zsh更极端。

文件'/etc/shells'中可以看到系统**可以使用**的shell

```sh
$ cat /etc/shells
/bin/sh
/bin/bash
/sbin/nologin
/usr/bin/sh
/usr/bin/bash
/usr/sbin/nologin
/bin/tcsh
/bin/csh
/bin/git-shell
/usr/bin/tmux
/bin/zsh
```

然后可以使用类似下面的命令，却更换当前用户的默认shell

```sh
chsh -s /bin/zsh
```

使用`chsh -l`也可以列出可以更换的shell。如果你的系统上安装了某个不在该列表中的shell，可以自己手动将其加入到`/etc/shells`中。

那为什么要学的是bash脚本，而不是其他shell脚本呢。最主要的原因就是bash是最普遍被使用的shell，同时它遵循IEEE POSIX的shell标准。bash的普遍使用，意味着写的脚本在各个Unix like的系统上都可以跑。

需要说明的是，用户当前使用的可能是其他shell，比如zsh，但这并不影响他在当前shell的环境下运行bash的脚本。你可以直接在zsh中使用bash命令来运行一个脚本。如果这个脚本中包含bash的shebang，并且有可执行权限，你也可以直接运行这个脚本（不需要在前面加上bash命令）。

```sh
$ bash hello.sh

$ cat hello.sh
#!/bin/bash
echo "hello"

$ chmod +x hello.sh

$ ./hello.sh
hello
```

正如前面提到的，不同的shell语法上会有一些区别。所以一定要很明确的知道自己当前用的是什么shell。大部分时候我们学习的都是适用于bash shell的命令，如果你当前使用的是其他shell比如csh，你可能会发现你的命令运行不了，或者结果不是你想要的。这个时候你就最好进入bash，再运行你那个命令。

That's it.