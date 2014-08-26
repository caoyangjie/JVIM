#辅助VIM插件JavaComplier,语法syntastic校验插件
#项目工作空间
WorkPath=$HOME/workspace
#项目名称
ProjectName=Test
#项目开发库路径
ProjectLibs=$WorkPath/$ProjectName/libs
#项目Class构建生成目录
ProjectBuilds=$WorkPath/$ProjectName/build
#输出两个需要JVM加载的类路径
echo $ProjectLibs
echo $ProjectBuilds
