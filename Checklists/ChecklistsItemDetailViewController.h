//
//  ChecklistsAddItemViewController.h
//  Checklists
//
//  Created by Ryan Robinson on 3/29/14.
//  Copyright (c) 2014 RRobinson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChecklistsItemDetailViewController;
@class ChecklistsItem;

@protocol ChecklistsItemDetailViewControllerDelegate <NSObject>

- (void)itemDetailViewControllerDidCancel:(ChecklistsItemDetailViewController *)controller;
- (void)itemDetailViewController:(ChecklistsItemDetailViewController *)controller didFinishAddingItem:(ChecklistsItem *)item;
- (void)itemDetailViewController:(ChecklistsItemDetailViewController *)controller didFinishEditingItem:(ChecklistsItem *)item;

@end

@interface ChecklistsItemDetailViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (weak, nonatomic) id <ChecklistsItemDetailViewControllerDelegate> delegate;
@property (strong, nonatomic) ChecklistsItem *itemToEdit;

-(IBAction)cancel;
-(IBAction)done;

@end
