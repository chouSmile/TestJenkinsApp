//
//  TodoListItem.m
//  MemoDemo
//
//  Created by chu on 15/9/23.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import "TodoListItem.h"

@implementation TodoListItem

- (void)focusChanged {
    self.checked = !self.checked;
}

@end
