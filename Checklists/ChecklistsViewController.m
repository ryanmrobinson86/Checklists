//
//  ChecklistsViewController.m
//  Checklists
//
//  Created by Ryan Robinson on 3/29/14.
//  Copyright (c) 2014 RRobinson. All rights reserved.
//

#import "ChecklistsViewController.h"
#import "ChecklistsItem.h"

@interface ChecklistsViewController ()

@end

@implementation ChecklistsViewController
{
    NSMutableArray *_items;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _items = [[NSMutableArray alloc] initWithCapacity:20];
    ChecklistsItem *item;
    
    item = [[ChecklistsItem alloc] init];
    item.text = @"Walk the Dog";
    item.checked = NO;
    [_items addObject:item];
    item = [[ChecklistsItem alloc] init];
    item.text = @"Brush my teeth";
    item.checked = YES;
    [_items addObject:item];
    item = [[ChecklistsItem alloc] init];
    item.text = @"Learn iOS development";
    item.checked = YES;
    [_items addObject:item];
    item = [[ChecklistsItem alloc] init];
    item.text = @"Soccer practice";
    item.checked = NO;
    [_items addObject:item];
    item = [[ChecklistsItem alloc] init];
    item.text = @"Eat ice cream";
    item.checked = YES;
    [_items addObject:item];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_items count];
}

- (void)configureCheckmarkForCell:(UITableViewCell *)cell withCheckListItem:(ChecklistsItem *)item
{
    UILabel *checkmark = (UILabel *)[cell viewWithTag:1001];
    if(item.checked) {
        checkmark.hidden = NO;
    } else {
        checkmark.hidden = YES;
    }
}

- (void)configureTextForCell:(UITableViewCell *)cell withCheckListItem:(ChecklistsItem *)item
{
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    
    label.text = item.text;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChecklistItem"];
    ChecklistsItem *item = _items[indexPath.row];
    
    [self configureCheckmarkForCell:cell withCheckListItem:item];
    
    [self configureTextForCell:cell withCheckListItem:item];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    ChecklistsItem *item = _items[indexPath.row];
    
    [item toggleChecked];
    
    [self configureCheckmarkForCell:cell withCheckListItem:item];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)showItem:(NSInteger)row
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    NSArray *indexPaths = @[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)addItem:(ChecklistsItem *)newItem
{
    [_items insertObject:newItem atIndex:0];
    
    [self showItem:0];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_items removeObjectAtIndex:indexPath.row];
    
    NSArray *indexPaths = @[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"AddItem"]){
        UINavigationController *navigationController = segue.destinationViewController;
        
        ChecklistsItemDetailViewController *controller = (ChecklistsItemDetailViewController *)navigationController.topViewController;
        
        controller.delegate = self;
    }else if ([segue.identifier isEqualToString:@"EditItem"]){
        UINavigationController *navigationController = segue.destinationViewController;
        
        ChecklistsItemDetailViewController *controller = (ChecklistsItemDetailViewController *)navigationController.topViewController;
        
        controller.delegate = self;
        
        NSIndexPath *cellPath = [self.tableView indexPathForCell:sender];
        controller.itemToEdit = _items[cellPath.row];
    }
}

- (void)itemDetailViewControllerDidCancel:(ChecklistsItemDetailViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)itemDetailViewController:(ChecklistsItemDetailViewController *)controller didFinishAddingItem:(ChecklistsItem *)item
{
    [self addItem:item];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)itemDetailViewController:(ChecklistsItemDetailViewController *)controller didFinishEditingItem:(ChecklistsItem *)item
{
    NSInteger index = [_items indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    [self configureTextForCell:cell withCheckListItem:item];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
