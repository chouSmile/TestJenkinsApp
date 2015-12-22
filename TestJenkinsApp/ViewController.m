//
//  ViewController.m
//  MemoDemo
//
//  Created by chu on 15/9/15.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import "ViewController.h"
#import "TodoListItem.h"

@interface ViewController ()

@end

@implementation ViewController {
    
    NSMutableArray *_items;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _items = [[NSMutableArray alloc] initWithCapacity:20];
    
    TodoListItem *item;
    
    item = [[TodoListItem alloc] init];
    item.text = @"first";
    item.checked = NO;
    [_items addObject:item];
    
    item = [[TodoListItem alloc] init];
    item.text = @"second";
    item.checked = NO;
    [_items addObject:item];
    
    item = [[TodoListItem alloc] init];
    item.text = @"third";
    item.checked = NO;
    [_items addObject:item];
    
    item = [[TodoListItem alloc] init];
    item.text = @"forth";
    item.checked = NO;
    [_items addObject:item];
    
    item = [[TodoListItem alloc] init];
    item.text = @"fifth";
    item.checked = NO;
    [_items addObject:item];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_items count];       // 返回为1，表示表视图只需显示一行数据
}

- (void)configureCheckmarkForCell:(UITableViewCell *)cell withTodoListItem:(TodoListItem *)item {
    
//    if (item.checked) {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    } else {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
    
    UILabel *label = (UILabel *)[cell viewWithTag:1001];
    
    if (item.checked) {
        label.text = @"√";
    } else {
        label.text = @"";
    }
}

- (void)configureTextForCell:(UITableViewCell *)cell withTodoListItem:(TodoListItem *)item {
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    label.text = item.text;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 获取prototype cell的拷贝（不管是新的还是回收利用的），然后把它赋予新创建的一个cell本地变量，其类型是UITableViewCell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodoListItem"];
    
    TodoListItem *item = [_items objectAtIndex:indexPath.row];
    //TodoListItem *item = _items[indexPath.row];
    
    // 请求获取cell中的标记为1000的子视图，获取一个到改UILabel标签对象的引用
    //UILabel *label = (UILabel *)[cell viewWithTag:1000];
    
    //label.text = item.text;
    
    [self configureTextForCell:cell withTodoListItem:item];
    [self configureCheckmarkForCell:cell withTodoListItem:item];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //对tableView调用cellForRowAtIndexPath，获取所触碰的UITableViewCell对象
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    TodoListItem *item = [_items objectAtIndex:indexPath.row];
    //TodoListItem *item = _items[indexPath.row];
    [item focusChanged];
    
    [self configureCheckmarkForCell:cell withTodoListItem:item];
    
//    //改变触碰对象的勾选状态
//    if (cell.accessoryType == UITableViewCellAccessoryNone) {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    } else {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

/******
 * 添加按钮事件
******/
//- (IBAction)addItem:(id)sender {
//    NSInteger newRowIndex = [_items count];
//    
//    //创建一个新的TodoListItem对象
//    TodoListItem *item = [[TodoListItem alloc] init];
//    
//    item.text = @"the new one";
//    item.checked = NO;
//    [_items addObject:item];        //把TodoListItem对象添加到当前的数据模型中
//    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
//    NSArray *indexPaths = @[indexPath];
//    
//    //在表视图中为该行数据插入一个新的cell
//    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
//}

/******
 *右滑删除
******/
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [_items removeObjectAtIndex:indexPath.row];
    
    NSArray *indexPaths = @[indexPath];
    
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)addItemViewControllerDidCancel:(AddItemViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addItemViewController:(AddItemViewController *)controller didFinishAddingItem:(TodoListItem *)item {
    
    NSInteger newRowIndex = [_items count];
    [_items addObject:item];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    
    NSArray *indexPaths = @[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addItemViewController:(AddItemViewController *)controller didFinishEditingItem:(TodoListItem *)item {
    NSInteger index = [_items indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self configureTextForCell:cell withTodoListItem:item];
    [self configureCheckmarkForCell:cell withTodoListItem:item];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"addItem"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        AddItemViewController *controller =
                (AddItemViewController *)navigationController.topViewController;
        
        controller.delegate = self;
        
    } else if ([segue.identifier isEqualToString:@"editItem"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        AddItemViewController *controller =
                (AddItemViewController *)navigationController.topViewController;
        
        controller.delegate = self;
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        controller.itemToEdit = _items[indexPath.row];
    }
}

@end
