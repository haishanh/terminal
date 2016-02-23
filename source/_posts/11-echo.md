---
title: echo
date: 2016-01-18
updated: 2016-01-18
---
## 用来干嘛

显示一行信息

## Synopsis

```text
echo [SHORT-OPTION]... [STRING]...
echo LONG-OPTION
```

`echo`默认会输出到标准输出。

```sh
$ echo hello
hello
```

当然我们也可以将其输出重定向到文件中。

```sh
$ echo "hello" > file0

$ cat file0
hello

$ echo "world" >> file0

$ cat file0
hello
world
```


## 尾部不加换行符

`echo` 默认会在最后加上一个换行符，可以使用`-n`选项让其结尾不换行。

```sh
root@localhost $ echo -n hello
helloroot@localhost $
```

## 转义生效

我们都知道`\n`表示换行，`\t`表示一个tab，如果我们在`echo`中使用这些字符会是这样：

```sh
$ echo "a\tb"
a\tb
```

可以看到`\t`没有其作用，如果我们使用`-e`选项就可以让其生效。

```sh
$ echo -e "a\tb"
a       b

$ echo -e "a\nb"
a
b
```

*注意*: 对于字符字面值，我们通常不需要将其放到引号中。但如果其中包含了转义字符，必须要将其放入引号中，单引号和双引号都可以。

现在你可以试试这个：

```sh
$ echo -e "\e[0;31ma\e[0m"
a
```

如果你的终端软件支持且你没有改动其配色的话，你会看到输出的"a"是红色。输出更多颜色的方法，你自己网上再找找看。


## 查看变量内容

```sh
$ a="hello"

$ echo "$a"
hello

$ echo "$a world"
hello world

```

上面的第一条命令中，我们给变量`a`赋了一个值。然后我们可以用`echo`来查看其值，这在脚本中尤其有用。查看的变量可以其他字符串放在一起。这很方便，但有时也会让人分辨不出变量和字面字符。比如：

```sh
$ a="hi"

$ ab="hey"

$ abc="hello"

$ echo "$abc"
hello
```

如果你不看最后的输出，你可能并不能确定其结果。所以好习惯是，一但在有可能出现歧义的地方，就把变量放到一对花括号`{}`中。

```sh
$ echo "${abc}def"
hellodef
```

当然，不仅可以用`echo`来查看自己创建的变量值，你也可以查看shell环境变量的值。比如：

```sh
$ echo "$PATH"
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
```

*注意*: 当涉及到变量时，我们可以不使用引号，但如果使用，只能使用双引号。看看下面的例子。


```sh
$ echo '${abc}'
${abc}

$ echo "${abc}"
hello
```

在Shell中，通常会使用空白字符作为分隔字段。

```sh
$ echo hello world
hello world
```

上面的例子中，hello是echo的第一个参数，而world是第二参数。在下面的例子中，输出不会有变化，但echo只有**一个**参数"hello world"。

```sh
$ echo "hello world"
hello world
```

所以大部分时候，为了避免意想不到的结果，应该是一个整体的字符串(包含其中的变量)，我们最好将其放到一对双引号中。


That's it.
