//
//  TodoListItem.h
//  MemoDemo
//
//  Created by chu on 15/9/23.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodoListItem : NSObject

@property(nonatomic,copy)NSString *text;        //保存待办事务的具体描述
@property(nonatomic,assign)BOOL checked;        //判断是否需要显示勾选标识

- (void)focusChanged;

@end
