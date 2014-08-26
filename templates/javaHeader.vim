source ~/.vim/templates/env.vim
let PackagePath = input("Please input Package Path : ")
let SrcPathList = join(split(PackagePath, '\.'),'/')
execute '!' . ' mkdir -pv ' . SrcPathList
execute '!' . ' cd ' . SrcPathList
call setline('.','/**')
normal o
call setline('.',' * Exception thrown when an operation is attempted that')
normal o
call setline('.',' * relies on an existing transaction such as setting')
normal o
call setline('.',' * rollback status and there is no existing transaction.')
normal o
call setline('.',' * This represents an illegal usage of the transaction API.')
normal o
call setline('.',' * copyright : (c) 2014  http://www.hisuntech.com all rights reserved.') 
normal o
call setline('.',' *  ')
normal o
call setline('.',' * @ProjectName:  [_project_name_]') 
normal o
call setline('.',' * @Package:      [_package_name_._file_name_] ') 
normal o
call setline('.',' * @ClassName:    [_classname_]  ') 
normal o
call setline('.',' * @Description:  [_description_]   ')
normal o
call setline('.',' * @Author:       [_author_]   ')
normal o
call setline('.',' * @CreateDate:   [_date_time_]   ')
normal o
call setline('.',' * @UpdateUser:   [_update_user_]   ')
normal o
call setline('.',' * @UpdateDate:   [_udate_time_]   ')
normal o
call setline('.',' * @UpdateRemark: [_update_remark_]  ')
normal o
call setline('.',' * @Version:      [v1.0] ')
execute '%s/_project_name_/'.ProjectName.'/g'
execute '%s/_package_name_/'.PackagePath.'/g'
execute '%s/_file_name_/'.FileName.'/g'
execute '%s/_description_/'.Description.'/g'
execute '%s/_author_/'.Author.'/g'
execute '%s/_date_time_/'.CreateTime.'/g'
execute '%s/_udate_time_/'.CreateTime.'/g'
execute '%s/_update_user_/'.UpdateUser.'/g'
execute '%s/_update_remark_/'.UpdateRemark.'/g'
execute '%s/_classname_/'.FileName.'/g'
