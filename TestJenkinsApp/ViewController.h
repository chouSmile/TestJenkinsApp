//
//  ViewController.h
//  MemoDemo
//
//  Created by chu on 15/9/15.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddItemViewController.h"

@interface ViewController : UITableViewController<AddItemViewControllerDelegate>

//- (IBAction)addItem:(id)sender;
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

@end

