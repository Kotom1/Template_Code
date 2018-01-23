#  程序模板仓库  
该仓库作为SIIG+Github程序托管项目的模板，用以规范输入输出、基本应用指导等。  

# 输入与输出:  
## 输入
* 所有的输入输出只允许采用终端和参数文件形式，不允许在程序中采用硬编码形式实现。
* 参数文件的基本格式应该为:  
  nx 20  
  nz 30  
  dx 10  
  dz 20  
* 输入的参数分为两种：  
  1、 非必须的，即可以设置默认值的，在终端输入的形式下，如果没有，则采用默认值；    
  2、 必须的，在终端输入的情况下，如果没有则报错或者显示帮助信息。  
* 对于C语言：  
  1、 程序的输入参照Madagascar标准形式。  
* 对于Fortran语言：  
  1、 输入采用 parfile 的形式。  
## 输出
* 需要有两种输出文件：  
  1、 程序运行日志文件，默认应该为终端输出，如果需要保留可以采用重定向形式导出到文件中  
  2、 结果文件： 二进制文件  
  3、 二进制文件应该单独建一个文件夹，保证程序和数据空间的整洁性。
* 需要输出帮助信息，在终端输入 -h 或者参数为空、缺失情况下。  
  1、 帮助信息应该包括： 主要程序开发人员、参数说明以及建议的参数取值范围和基本的程序运行情况  

# C 语言
## 编程规范
  1、 头文件只能放声明： extern开头的变量声明和函数声明， 源文件放定义： 变量定义和函数定义；  
  .h 文件：
```
   extern int i;
   void sum(i);
```
  .c 文件：
```
   int i;
   void sum(i)
   {
   }
```
  2、 不允许存在定义未使用和使用未定义的变量；  
  3、 程序需要分段进行注释，每个子函数需要在开头进行注释，说明子函数的主要功能和参数意义：  
```
	int sum (int i) 
	/* sum numbers from 0 to i  
	   @input@  
	   i: end of summation  
	   @ouput@    
	   sum results
	*/  
```    
  4、 函数for循环的深度最大应该小于5层；  
  5、 申请过的空间必须要释放，保证不发生内存泄漏；  
  6、 程序应该采用gdb等软件进行调试和内存检查；  
  7、 清除不必要的空格等  
  8、 所有代码需要对2个以上数据，对每个参数进行变化测试。  
## C & Madagascar
  1、 所有C语言程序按照madagascar进行输入输出的定义  
  2、 C语言程序的编译文件参照Madagascar中Sconstruct 进行编写，相关的库函数引用参照用例路径  

# Fortran 语言
## 编程规范
  1、 申请过的内存必须要有对应的释放  
  2、 注释的要求与上述C语言相同  
  3、 输入采用parfile的形式，parfile的格式参照输入输出部分  
  4、 清除不必要的空格等

# SU 和 Madagascar 的整合
  本项目中将SU和Madagascar代码采用fork的形式将其作为代码仓库的子仓进行管理，并且实时与源码仓库进行通信保证代码时效性。  
  下载本项目仓库可以直接安装上述标准软件，不需要单独在其官网进行下载。  
  
  如果需要向上述两个开源组织贡献代码，请将修改好的代码贡献到公共仓库后由管理员进行审核并进行merge操作。  
  
  如果需要类似的开源程序、代码段，可以向管理员说明，在相关组织进行fork，也可以自己fork，然后merge到公共仓库。  
  
  使用了其他开源程序需要在程序和帮助信息中说明。  

# 利用 Makefile 进行编译
  所有的程序应该包含一个Makefile进行编译和运行，关于Makefile的教程可以单击[这里](https://yq.aliyun.com/articles/9243).  

# Build the Error Reference Library
  When facing error, Your first choice is to search error information in the Error_library.  
  Enriching the Error Library with new information and solution method !  

# Git 基础
## 下载与安装
  git 的下载安装网站请到[此处](https://git-scm.com/download/)  
  Windows 下图形界面的 git 为[TurtoiseGit](https://tortoisegit.org/)  
## 教程与基本命令
  关于git的模型与基本命令，请移步[此处](http://www.runoob.com/git/git-tutorial.html)  
  * 利用github，需要认识Git的基本构架，包括工作区，暂存区，版本库等。  
  * 需要一些了解一些基础的git命令，其中包括但不限于：   
  本地操作： git add; git commit; git branch; git checkout; git reset; git merge; git rebase 等  
  远程操作： git remote; git clone; git fetch; git pull; git push; git submodule; 等  
  在线操作： 从他人代码库中创建代码分支： fork； 向他人代码库中贡献代码： merge 等  
## 参考网址
  一些关于git的参考资料网址：  
  1、[git 的奇淫巧技](https://github.com/521xueweihan/git-tips)

# 加载个人仓库与向中心仓库贡献代码
## 加载个人仓库
  每人需要注册一个github账号,建立project，将中心仓库代码fork到个人仓库，从个人仓库将代码加载到本地，进行软件安装与基本程序的运行、改写等。
## 向中心仓库贡献代码
  修改好的程序提交后上传到个人代码仓库，向中心代码仓库提出合并申请，中心代码仓库管理员审核，合格情况下并入中心仓库永久保留。  
  提交的代码要求包含一定量的注释，基本格式为：  
  **[研究方向]** 全波形反演   
  **[二级研究方向]** 弹性波FWI   
  **[开发人]** 崔超   
  **[基本运行环境]** Ubuntu Dell 工作站  
  **[开发语言]** C， GPU， MPI   
  **[是否为新程序]** 是/否   
  **[实现的功能/修正的BUG]** 多尺度 FWI  
  **[基本测试用例情况]** Marmousi， BP 2004  
  **[共同开发人]** 无  
  **[是否经过评审/评审人]** 是/黄建平   
# 其他
  本仓库还可以用于保存部分文献，文档以及小型的benchmark模型等。  
  但是为了节约空间，本仓库不保存任何大型二进制数据，将来采用git-lfs后会陆续接纳部分大型二进制数据等。

任何问题欢迎联系: 黄建平 崔超
