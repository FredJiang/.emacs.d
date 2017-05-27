

还没安装 emacs 的，可以参考下面链接安装

[emacs 源码安装](http://fred.itxfd.com/2016/11/16/emacs-%E6%BA%90%E7%A0%81%E5%AE%89%E8%A3%85/)


安装完后，下载配置文件

```
cd && \
git clone https://github.com/FredJiang/.emacs.d.git && \
cd .emacs.d && \
git submodule init && \
git submodule update && \
./setup.sh
```

#### 错误处理

如果报错

> File error: http://stable.melpa.org/packages/async-1.9.tar, Not found

在 emacs 中运行如下命令

<kbd>M-x</kbd> `package-refresh-contents` 