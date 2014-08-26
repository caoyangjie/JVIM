" Vim plugin to set the default help language to Chinese
" Maintainer:  曹杨杰	
" Last Change: 2014年07月25日

"Maintainer:{{{
"设置是否输出日志
let g:debug = 0
if g:iswindows
    "dir /B /S /A-D /ON *.fnc *.prc *.trg *.pck *.typ *.spc *.bdy *.tps *.tpb *.txt *.sql > filenametags
    "dir /B /S /A-D /ON | findstr /V ".class$ .xls$ .doc$ .ppt$ .pdf$ .jpg$ .gif$ .zip$ .rar$ .jar$ .dat$ .mdb$ .dmp$ " > filenametags
    let g:project_cscope_file = "F:/platform/cscope.files"
    let g:project_lookup_file = "F:/platform/lookup.files"
    let g:project_find_program = "dir /B /S /A-D /ON"
    let g:project_find_param = "*.java"
    let g:this_project_base_dir = "F:/platform/app/cgb"
    let g:project_tags_dir_list = ["F:/platform/lib"]
    let g:LookupFile_TagExpr = '"F:/platform/lookup.files"'
    let g:libChange = 1
    let g:fileSpiltSpace = ";"
endif
"let g:basePath = "/home/hisun"
if g:islinux
    let g:fileSpiltSpace = ":"
    let g:LookupFile_TagExpr = '$HOME . "/lookup.files"'
    "echo g:LookupFile_TagExpr
endif
au! BufLeave *.{c,cpp,h,java,javascript,html,jsp} call UpdateFileDesc()
au! BufWrite *.{java,jsp} call LinuxF12()
"map <F12> :call ProjectTagUpdateLookupFile()<CR>
"  自动替换模板内容中的变量
"let g:JavaPackage='org.hisun.test'
"let g:inputStr=input("请输入java类所在目录!")
"map gnp :%s/_filename_/\=bufname("%")/<CR>:%s/_datetime_/\=strftime("%c")/<CR>:%s/_classname_/\=split(bufname("%"),'.java')[0]/<CR>:%s/_package_/\='org.hisun.test'/<CR> 
"map gsg 0f;dw"ad0wwviw"bxwviw"cx0da "apapublic void set"cpb3~$a(final "bpa "cpa) { this."cpa = "cpa; }public "bpa get"cpb3~$a() { return "cpa; }0 
"autocmd BufNewFile * normal G
"autocmd BufNewFile *.java 0r ~/.vim/templates/javaClass.tpl
"autocmd bufnewfile *.java normal gnp 

"map <F10> :call s:SET_COMMENTV()<CR>
"vmap <C-S-M> call s:SET_COMMENTV()
"command! -nargs=0 SetV call s:SET_COMMENT()
"command! -nargs=0 SetV call s:SET_COMMENTV()
"autocmd bufnewfile * normal <F2><CR>
"g:syntastic_java_javac_delete_output = "/home/hisun/bin"
"let g:syntastic_java_javac_options = ""
"let g:syntastic_java_javac_temp_dir = "/home/hisun/bin"
"let g:syntastic_java_javac_config_file_enabled = 1 
"let g:syntastic_java_javac_config_file = "/home/hisun/workspace/TestEhcache/Env.sh"
"设置当前工作项目执行脚本，需扩展
"let g:s"yntastic_java_javac_custom_classpath_command = 'sh /root/workspace/Test/Env.sh'
"修改javlac 参数为：无默认构建生成路径
"let g:s"yntastic_java_javac_delete_output = 0
"设置默 l认java的classpath路径
"let g:syntastic_java_javac_classpath = "/home/hisun/applib/p2plibs"
"设置javac构建参数(在快捷键F4中自动设置）
"let g:syntastic_java_javac_options = ""
"设置javacomplete控件的classpath环境变量(在快捷键F4中自动设置)
"let g:java_classpath = ""
"
"}}}

"FUNCTION: {{{
function! BuildProject()
    let cmd= 'D:\Bat\timerClose.bat'
    silent execute '!' . cmd
endfunction

function! LayoutEclipse()
    silent execute 'vsp __Tag_List__'
    silent execute 'wincmd j'
    WidthToSize(30)
    silent execute 'sp NERD_tree_title'
    silent execute 'wincmd l'
    silent execute 'bel sp DebugFile'
    silent execute 'wincmd j'
    HeightToSize(30)
endfunction

func! HeightToSize(height)
    let currwinno=winnr()
    if winheight(currwinno)>a:height
        while winheight(currwinno)>a:height
            execute "normal \<c-w>-"
        endwhile
    elseif winheight(currwinno)<a:height
        while winheight(currwinno)<a:height
            execute "normal \<c-w>+"
        endwhile
    endif
endfunc
 
func! WidthToSize(width)
    let currwinno=winnr()
    if winwidth(currwinno)>a:width
        while winwidth(currwinno)>a:width
            execute "normal \<c-w><"
        endwhile
 
    elseif winwidth(currwinno)<a:width
        while winwidth(currwinno)<a:width
            execute "normal \<c-w>>"
        endwhile
    endif
endfunc

function! JavaRun()
    if &filetype == "java"  
        "exec "!java -classpath %:h; %:t:r"  
        let cmd = 'D:\compiler.bat org.hisun.utils.%:t:r'
        silent execute '!'.cmd
    endif  
endfunction

function! StartFepService()
    let cmd= 'D:\cgb\cgb-fep\bin\cgb-fep.bat'
    silent execute '!' . cmd
endfunction

"}}}

"Starttomcat#FUNCTION: {{{

function! StartTomcat()
    let preCommand='D:'
    let dir = 'D:\Program Files\Apache Software Foundation\Tomcat 6.0\bin'
    let cmd = 'tomcat6.exe' 
    silent execute '! cd '.dir.'\ &'.preCommand.'&start '.cmd 
endfunction

" }}}

"Projecttagupdatelookupfile#FUNCTION: {{{
function! ProjectTagUpdateLookupFile()
    if g:iswindows
  echo "generate lookupfile.tag"
  if filereadable(g:project_lookup_file)
    call delete(g:project_lookup_file)
  endif
  execute "cd " .  g:this_project_base_dir
  let l:lookup_tags = ["!_TAG_FILE_SORTED 2 \/2=foldcase\/"] 

  if has("win32")
    let l:this_project_base_dir = substitute(g:this_project_base_dir, "/", "\\", "g") . "\\"
  else
    let l:this_project_base_dir = g:this_project_base_dir
  endif
  "let l:lookup_tags_file_string = system(g:project_find_program . " " . l:this_project_base_dir . " " . g:project_find_param)
  let l:lookup_tags_file_string = system(g:project_find_program . " " . g:project_find_param)
  let l:lookup_tags_file_list = split(l:lookup_tags_file_string, '\n')
  let l:cscope_tags_file_list = split(l:lookup_tags_file_string, '\n')
  let l:lookup_tags_file_list = sort(l:lookup_tags_file_list)
  if g:libChange
"    let l:libs_tags_file_string = system(g:project_find_program . 
    echo "build Java Open Source!"
    let l:ltfs = ""
    for l:ltfs in g:project_tags_dir_list
        execute "cd " . l:ltfs 
        let l:ptdl = split(system(g:project_find_program . " " . g:project_find_param), '\n')
        call extend(l:cscope_tags_file_list, l:ptdl)
        call extend(l:lookup_tags_file_list, l:ptdl)
    endfor     
  endif

  let l:item = ""
  let l:count = 0 
  for l:item in l:lookup_tags_file_list
    let l:item = fnamemodify(l:item, ':t') . "\t" . l:item . "\t" . "1"
    let l:lookup_tags_file_list[l:count] = l:item
    let l:count = l:count + 1
  endfor 
  call extend(l:lookup_tags, l:lookup_tags_file_list)
  call writefile(l:lookup_tags, g:project_lookup_file)
  echo "generate lookupfile tag done"
  call writefile(l:cscope_tags_file_list, g:project_cscope_file)
  "execute "! cscope -Rbkq -i " . g:project_cscope_file
  echo "generate all success!"
    endif
    if g:islinux
        "find . -not -regex '.*\.\(java\|gradle\)' -type f -printf "%f\t%p\t1\n" | sort -f >> filenametags 
        call LinuxF12()
    endif
endfunction

" }}}

"Linuxf12#FUNCTION: {{{
    function! LinuxF12()
        if g:debug
            echo "do something in ubuntu.!".expand("%:p:h")
        endif
        "设置当前工作项目执行脚本，需扩展
        "let g:syntastic_java_javac_custom_classpath_command = 'sh /root/workspace/Test/Env.sh'
        "修改javac 参数为：无默认构建生成路径
        if g:islinux
            let pathbase=split(expand("%:p:h"),"src/main/java/")
            let buildPath = pathbase[0]."build"
            let buildJars = pathbase[0]."libs"
            let buildEnvs = "sh " . pathbase[0] . "Env.sh"
            let buildSrcs = pathbase[0]."src/main/java"
        endif
        if g:iswindows
            let pathbase = split(expand("%:p:h"),"\\\\src\\\\main\\\\java")
            let buildPath = pathbase[0]."\\build"
            let buildJars = pathbase[0]."\\libs"
            let buildEnvs = pathbase[0]."\\Env.bat"
            let buildSrcs = pathbase[0]."\\src\\main\\java"
        endif
        "let runClassPath = pathbase[1] ."/". expand("%:r")
        "let runClassI = join(split(runClassPath,"/"),".")
        "echo "!javac -cp ".buildPath.":".buildJars." -sourcepath ".buildPath." -Djava.ext.dirs=". buildJars ." -d ".buildPath." *.java"
        "echo pathbase 
        "echo runClassI
        "echo "java -cp " . buildPath . " -Djava.ext.dirs=" .pathbase[0]."libs " . runClassI
        "设置javacomplete控件的classpath环境变量(在快捷键F12中自动设置)
        let g:java_classpath = buildPath.g:fileSpiltSpace.buildJars
        "设置javac构建参数(在快捷键F12中自动设置）
        let g:syntastic_java_javac_delete_output = 0
        let g:syntastic_java_javac_custom_classpath_command = buildEnvs
        let g:syntastic_java_javac_autoload_maven_classpath = 0
        let g:syntastic_java_javac_options = "-encoding UTF-8 -sourcepath ".buildSrcs." -Djava.ext.dirs=". buildJars . " -d ".buildPath." "
        if g:iswindows
            let g:java_classpath .= g:fileSpiltSpace."F:\\platform\\bin\\p2pclasses\\"
            "echo g:java_classpath
        endif
        "execute "!javac -encoding UTF-8 -cp ".buildPath.g:fileSpiltSpace.buildJars." -sourcepath ".buildSrcs." -Djava.ext.dirs=". buildJars ." -d ".buildPath." " . expand("%:t")
        if g:debug
            echo buildEnvs
            echo buildPath
            echo buildJars
            echo g:syntastic_java_javac_options
            echo "Reflesh My WorkSpace enviroment success!"
        endif
    endfunction 

    function! LinuxF4()
        "execute "!cd " . projectArgsList[0] 
        "let buildPath = projectArgsList[0]."/build"
        "let buildJars = projectArgsList[0]."/libs"
        "let buildSrcs = projectArgsList[0]."/src/main/java"
        if g:islinux
            let pathbase = split(expand("%:p:h"),"/src/main/java")
            let buildSourceFile = pathbase[0]."/source.list"
            let buildPath = pathbase[0]."/build"
            let buildJars = pathbase[0]."/libs"
            let buildEnvs = "sh " . pathbase[0] . "/Env.sh"
            let buildSrcs = pathbase[0]."/src/main/java"
            "let sourcefilecmd = "find " . buildSrcs . " -name *.java"
            "echo sourcefilecmd
            "let l:javaSource_file_string = system(sourcefilecmd)
            "let l:lookup_tags_file_list = split(l:javaSource_file_string, '\n')
        endif
        if g:iswindows
            let pathbase = split(expand("%:p:h"),"\\\\src\\\\main\\\\java")
            let buildSourceFile = pathbase[0]."\\source.list"
            let buildPath = pathbase[0]."\\build"
            let buildJars = pathbase[0]."\\libs"
            let buildEnvs = pathbase[0]."\\Env.bat"
            let buildSrcs = pathbase[0]."\\src\\main\\java"
            "execute "!cd " . pathbase[0] 
            let l:javaSource_file_string = system("cd " . pathbase[0] . "&&" .g:project_find_program . " " . g:project_find_param)
            let l:lookup_tags_file_list = split(l:javaSource_file_string, '\n')
            call writefile( l:lookup_tags_file_list ,buildSourceFile)
        endif
        "设置编译器提示
        "let g:syntastic_java_javac_custom_classpath_command = buildEnvs
        "let runClassPath = pathbase[1] ."/". expand("%:r")
        "设置javacomplete控件的classpath环境变量(在快捷键F12中自动设置)
        let g:java_classpath = buildPath.g:fileSpiltSpace.buildJars
        "设置javac构建参数(在快捷键F12中自动设置）
        "let g:syntastic_java_javac_options = " -sourcepath ".buildPath." -Djava.ext.dirs=". buildJars . " -d ".buildPath." "
        let g:syntastic_java_javac_options = " -encoding UTF-8 -sourcepath ".buildPath." -Djava.ext.dirs=". buildJars . " -d ".buildPath." "
        execute "!javac -encoding UTF-8 -cp ".buildPath.g:fileSpiltSpace.buildJars." -sourcepath ".buildSrcs." -Djava.ext.dirs=". buildJars ." -d ".buildPath. " @" . buildSourceFile
        if g:iswindows
            let g:java_classpath .= g:fileSpiltSpace."F:\\platform\\bin\\p2pclasses\\"
            execute "!xcopy ".buildPath."\\* F:\\platform\\bin\\p2pclasses\\* /E/Y"
        endif
        " *.java"
    endfunction
    
    function! RunJava()
        if g:islinux
            let pathbase = split(expand("%:p:h"),"/src/main/java/")
            let buildPath = pathbase[0]."/build"
            let buildJars = pathbase[0]."/libs"
            let runClassPath = pathbase[1] ."/". expand("%:r")
            let runClassI = join(split(runClassPath,"/"),".")
        endif
        if g:iswindows
            let pathbase = split(expand("%:p:h"),"\\\\src\\\\main\\\\java")
            let buildPath = pathbase[0]."\\build"
            let buildJars = pathbase[0]."\\libs"
            let runClassPath = pathbase[1] ."\\". expand("%:r")
            let runClassI = join(split(runClassPath,"\\"),".")
        endif
        "expand("%p:h:t") . expand("%p:t:r")
        "execute "!java -cp " . buildPath . " -Djava.ext.dirs=" .pathbase[0]."libs " . runClassI
        let cmdArgs= "!java -cp " . buildPath . " -Djava.ext.dirs=" .buildJars ." " . runClassI
        "echo cmdArgs
        execute cmdArgs
        "execute "!java -cp " . buildPath . " -Djava.ext.dirs=" .projectArgsList[0]."libs " . runClassI

    endfunction

    function! CreateJavaPro()
        let ProjectName=input("请输入项目名称: ")
        if g:islinux
            execute "!cd ~"
            execute "!mkdir -pv ~/workspace/".ProjectName 
            execute "!cp -R ~/.vim/JavaProjectTemplate/J2EE/* ~/workspace/".ProjectName
        endif
        if g:iswindows
            execute "!cd ~"
            execute "!mkdir -pv F:/platform/workspace/".ProjectName 
            execute "!cp -R $VIM/vimfiles/JavaProjectTemplate/J2EE/* F:/platform/workspace/".ProjectName
        endif
    endfunction

"}}}

"FUNCTION: {{{

"非视图模式下所调用的函数
function! s:SET_COMMENT()
    let lindex=line(".")
    let str=getline(lindex)
    "查看当前是否为注释行
    let CommentMsg=s:IsComment(str)
    call s:SET_COMMENTV_LINE(lindex,CommentMsg[1],CommentMsg[0])
endfunction

"视图模式下所调用的函数
function! s:SET_COMMENTV()
    let lbeginindex=line("'<") 
    "得到视图中的第一行的行数
    let lendindex=line("'>") 
    "得到视图中的最后一行的行数
    let str=getline(lbeginindex)
    "查看当前是否为注释行
    let CommentMsg=s:IsComment(str)
    "为各行设置
    let i=lbeginindex
    while i<=lendindex
        call s:SET_COMMENTV_LINE(i,CommentMsg[1],CommentMsg[0])
        let i=i+1
    endwhile
endfunction

"设置注释
"index:在第几行
"pos:在第几列
"comment_flag: 0:添加注释符 1:删除注释符
function! s:SET_COMMENTV_LINE( index,pos, comment_flag  )
    let poscur = [0, 0,0, 0]
    let poscur[1]=a:index
    let poscur[2]=a:pos+1
    call setpos(".",poscur) "设置光标的位置
    
    if a:comment_flag==0
        "插入//
        exec "normal! i//"
    else
        "删除//
        exec "normal! xx"
    endif
endfunction

"查看当前是否为注释行并返回相关信息
"str:一行代码
function! s:IsComment(str)
    let ret= [0, 0] "第一项为是否为注释行（0,1）,第二项为要处理的列，
    let i=0
    let strlen=len(a:str)
    while i < strlen "空格和tab允许为"//"的前缀
        if !(a:str[i]==' ' || a:str[i] == ' ' )
            let ret[1]=i
            if a:str[i]=='/' && a:str[i+1]=='/'
                let ret[0]=1
            else
                let ret[0]=0
            endif
            return ret
        endif
        let i=i+1
    endwhile
    return [0,0] "空串处理
endfunction

" }}}

"FUNCTION:{{{

function! UpdateFileDesc()
    let oldDebug = g:debug
    let g:debug = 0
    "call LinuxF12()
    "echo "UpdateFileDesc()" 
    let g:debug = oldDebug
endfunction

"}}}
