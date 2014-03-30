//
//  ChecklistsAddItemViewController.h
//  Checklists
//
//  Created by Ryan Robinson on 3/29/14.
//  Copyright (c) 2014 RRobinson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChecklistsAddItemViewController;
@class ChecklistsItem;

@protocol ChecklistsAddItemViewControllerDelegate <NSObject>

- (void)addItemViewControllerDidCancel:(ChecklistsAddItemViewController *)controller;
- (void)addItemViewController:(ChecklistsAddItemViewController *)controller didFinishAddingItem:(ChecklistsItem *)item;

@end

@interface ChecklistsAddItemViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (weak, nonatomic) id <ChecklistsAddItemViewControllerDelegate> delegate;

-(IBAction)cancel;
-(IBAction)done;

@end
