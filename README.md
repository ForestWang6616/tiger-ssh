公司堡垒机采用谷歌二段验证，登录堡垒机后每次需要输入验证码，而验证码需要在手机或者浏览器上查看，太麻烦了。

谷歌二段验证，基于[TOTP](https://en.wikipedia.org/wiki/Time-based_One-time_Password_algorithm)算法，[oathtool](https://www.nongnu.org/oath-toolkit/man-oathtool.html)完美支持。所以简单的编写一个小工具，可以直接调用，省去一切过程。


说明：

不支持Windows系统

MacOS可能需要略微调整脚本内容

Ubuntu18.04完美运行

前期准备：

安装oathtool

    sudo apt-get update
    sudo apt-get install oathtool

安装expect

    sudo apt-get update
    sudo apt-get install expect

配置ssh tiger(如果配置的名字不想叫tiger，请一并修改totp_input.ex)

https://linux.cn/article-8306-1.html

    sudo vim ~/.ssh/config

    Host tiger
        HostName $tigerHost
        Port $tigerPort
        User $yourTigerUser
        IdentityFile $keyPath

特别操作（二选一）：

1.将 totp_input.ex 文件中的  “wangyajun” 替换成  $yourTigerUser

2.干脆去掉登录成功后的clear操作，看个人习惯咯

配置全局运行

    cd totp.sh所在目录
    echo "alias totp=\"$PWD/totp.sh\"" >> ~/.bashrc
    source ~/.bashrc
 

