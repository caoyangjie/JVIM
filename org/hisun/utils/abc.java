/*
 * Copyright 1999-2014 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.hisuntech.com
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.hisun.utils;
/**
 * Exception thrown when an operation is attempted that
 * relies on an existing transaction such as setting
 * rollback status and there is no existing transaction.
 * This represents an illegal usage of the transaction API.
 * copyright : (c) 2014  http://www.hisuntech.com all rights reserved.
 *  
 * @ProjectName:  [Test]
 * @Package:      [org.hisun.utils.abc] 
 * @ClassName:    [abc]  
 * @Description:  [此类用于测试自动备注是否好使!]   
 * @Author:       [cao_yj]   
 * @CreateDate:   [2014-08-17 23:42:27]   
 * @UpdateUser:   [cao_yj]   
 * @UpdateDate:   [2014-08-17 23:42:27]   
 * @UpdateRemark: [暂无备注]  
 * @Version:      [v1.0] 
 * modifications: 
 */

public class abc { 

	/** 
	* default constructor. 
	*/ 
	public abc() { 
		super(); 
	}

	/** 
	* @param args commond line parameters 
	*/ 
	public static void main(final String[] args) { 
		//TODO  dosometing ...
        System.out.println("java.ext.dirs  ==  " + System.getProperty("java.ext.dirs"));
	}
}

