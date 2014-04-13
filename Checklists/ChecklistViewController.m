//
//  ChecklistsViewController.m
//  Checklists
//
//  Created by Ryan Robinson on 3/29/14.
//  Copyright (c) 2014 RRobinson. All rights reserved.
//

#import "ChecklistViewController.h"
#import "ChecklistItem.h"
#import "Checklist.h"

@interface ChecklistViewController ()

@end

@implementation ChecklistViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.checklist.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureCheckmarkForCell:(UITableViewCell *)cell withCheckListItem:(ChecklistItem *)item
{
    UILabel *checkmark = (UILabel *)[cell viewWithTag:1001];
    if(item.checked) {
        checkmark.hidden = NO;
    } else {
        checkmark.hidden = YES;
    }
    checkmark.textColor = self.view.tintColor;
}

- (void)configureTextForCell:(UITableViewCell *)cell withCheckListItem:(ChecklistItem *)item
{
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    
    //label.text = item.text;
    
    label.text = [NSString stringWithFormat:@"%d : %@", item.itemId, item.text];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.checklist.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChecklistItem"];
    ChecklistItem *item = self.checklist.items[indexPath.row];
    
    [self configureCheckmarkForCell:cell withCheckListItem:item];
    
    [self configureTextForCell:cell withCheckListItem:item];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    ChecklistItem *item = self.checklist.items[indexPath.row];
    
    [item toggleChecked];
    
    [self configureCheckmarkForCell:cell withCheckListItem:item];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.checklist.items removeObjectAtIndex:indexPath.row];
    
    NSArray *indexPaths = @[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)showItem:(NSInteger)row
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    NSArray *indexPaths = @[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)addItem:(ChecklistItem *)newItem
{
    NSInteger index = [self.checklist.items count];
    [self.checklist.items insertObject:newItem atIndex:index];
    
    [self showItem:index];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"AddItem"]){
        UINavigationController *navigationController = segue.destinationViewController;
        
        ItemDetailViewController *controller = (ItemDetailViewController *)navigationController.topViewController;
        
        controller.delegate = self;
    }else if ([segue.identifier isEqualToString:@"EditItem"]){
        UINavigationController *navigationController = segue.destinationViewController;
        
        ItemDetailViewController *controller = (ItemDetailViewController *)navigationController.topViewController;
        
        controller.delegate = self;
        
        NSIndexPath *cellPath = [self.tableView indexPathForCell:sender];
        controller.itemToEdit = self.checklist.items[cellPath.row];
    }
}

- (void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item
{
    [self addItem:item];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(ChecklistItem *)item
{
    NSInteger index = [self.checklist.items indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    [self configureTextForCell:cell withCheckListItem:item];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
