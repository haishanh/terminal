---
title: alias
date: 2016-01-25
published: 2016-01-25
---
## 用来干嘛

`alias`就是「别名」的意思。`alias`用来查看或设置别名。

`alias`是大部分shell的内置命令(Builtin Command)。

## Synopsis

```text
alias [-p] [name[=value] ...]
```

`alias`非常有用。通常都是把频繁会用到的命令或操作设置成一个`alias`，从而减少键盘的敲击。You lazy GEEK ;)

比如：

```sh
$ alias d=date

$ d
Mon Jan 25 14:39:14 CST 2016
```

上面的例子中，我们给命令`date`设置了一个alias`d`，之后我们就可以把`d`当`date`来用了。

### 放入选项

我们也可以放入经常用的选项。

```sh
$ alias da="date '+%y-%m-%d %H:%M'"

$ da
16-01-25 14:42
```

因为我们要被`alias`的命令中包含了空格，所以我们需要将这个命令放到一对`"`中。假设被`alias`的命令本身包含了`"`符号，我们可以用反斜杠(Back Slash)`\`进行转义。

```sh
$ alias da="date \"+%y-%m-%d %H:%M\""

$ da
16-01-25 14:45
```

在使用`alias`时，就可以把这个alias当作普通命令来使用。该加参数和选项还是继续加。

```sh
$ alias l='ls -l --color=auto'

$ l normal-file
-rw-r--r--. 1 root root 0 Jan 25 15:35 normal-file

$ l -a
total 8
drwxr-xr-x. 2 root root 4096 Jan 25 15:35 .
drwxr-xr-x. 3 root root 4096 Jan 25 15:35 ..
-rw-r--r--. 1 root root    0 Jan 25 15:35 .hidden-file
-rw-r--r--. 1 root root    0 Jan 25 15:35 normal-file
```

### 放入多条命令

`alias`中我们也可以放入多条命令。

```sh
$ alias d="echo -n \"DATE: \"; date \"+%y-%m-%d %H:%M\""

$ d
DATE: 16-01-25 14:49

$ alias count3="echo 3 && sleep 1 && echo 2 && sleep 1 && echo 1 && sleep 1 && echo 0"

$ count3
3
2
1
0
```

### 查看alias

直接输入`alias`命令，我们可以查看当前session的所有alias。

```sh
$ alias
alias count3='echo 3 && sleep 1 \ && echo 2 && sleep 1 && echo 1 && sleep 1 && echo 0'
alias cp='cp -i'
alias d='echo -n "DATE: "; date "+%y-%m-%d %H:%M"'
alias da='date "+%y-%m-%d %H:%M"'
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias mv='mv -i'
alias rm='rm -i'
```

在`alias`后面加上要查看的alias内容，可以查看具体的alias。

```sh
$ alias ls
alias ls='ls --color=auto'

$ alias noexist
-bash: alias: noexist: not found
```

### 「永久」生效

假设我们在一个Bash Shell中，设置好了一个alias。如果关闭这个session(通常就是在终端软件中关闭这个session所在的窗口或Tab)，你设置好的alias就会丢失。你不关闭这个session，而新建一个session，你新建的session中也不会有你的alias设置。通常的做法是，把我们的alias设置在新建shell时会source的文件中。

比如Bash Shell中，我们可以把我们的alias设置都写在`.bashrc`或`.bash_profile`中。放在`.bashrc`中和放在`.bash_profile`中会一些细微的区别，感兴趣可以自己网上看看这方面的信息。但目前大部分Linux ditro在`.bash_profile`中也会source`.bashrc`文件，所以放在哪个文件中都可以。大部分时候，大家都倾向于放到`.bashrc`中。

```sh
# in .bashrc
alias d="date"
alias count3="echo 3 && sleep 1 && echo 2 && sleep 1 && echo 1 && sleep 1 && echo 0"
# ...
```

### unalias

`unalias`命令可以移除一个alias。

```sh
$ alias d="echo -n \"DATE: \"; date \"+%y-%m-%d %H:%M\""

$ d
DATE: 16-01-25 15:25

$ unalias d

$ d
-bash: d: command not found
```

### 不同Shell中alias语法差异

因为`alias`是builtin，所以不同的shell在设置alias时也有一些差别。

比如z-shell中的`alias`语法和Bash中的相同。tc-shell中的`alias`的设置语法是这样的:

```sh
alias python3 /home/haishanh/usr/bin/python3
```

## More

注意设置`alias`的时候，alias名不要和系统现有的命令重名，不然会覆盖掉原有的命令。

That's it.
