//
//  AddItemViewController.h
//  MemoDemo
//
//  Created by chu on 15/9/24.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddItemViewController;
@class TodoListItem;

@protocol AddItemViewControllerDelegate <NSObject>
- (void)addItemViewControllerDidCancel:(AddItemViewController *)controller;
- (void)addItemViewController:(AddItemViewController *)controller didFinishAddingItem:(TodoListItem *)item;
- (void)addItemViewController:(AddItemViewController *)controller
        didFinishEditingItem:(TodoListItem *)item;
@end

@interface AddItemViewController : UITableViewController<UITextFieldDelegate>

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@property (weak, nonatomic) id <AddItemViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBarButton;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic) TodoListItem *itemToEdit;

@end
