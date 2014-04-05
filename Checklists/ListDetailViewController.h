//
//  ListDetailViewController.h
//  Checklists
//
//  Created by Ryan Robinson on 4/4/14.
//  Copyright (c) 2014 RRobinson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListDetailViewController;
@class Checklist;

@protocol ListDetailViewControllerDelegate <NSObject>

- (void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller;
- (void)listDetailViewcontroller:(ListDetailViewController *)controller didFinishAddingChecklist:(Checklist *)checklist;
- (void)listDetailViewcontroller:(ListDetailViewController *)controller didFinishEditingChecklist:(Checklist *)checklist;

@end

@interface ListDetailViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (weak, nonatomic) id <ListDetailViewControllerDelegate> delegate;
@property (strong, nonatomic) Checklist *checklistToEdit;

- (IBAction)cancel;
- (IBAction)done;

@end
