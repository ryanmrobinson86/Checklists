//
//  ChecklistsViewController.h
//  Checklists
//
//  Created by Ryan Robinson on 3/29/14.
//  Copyright (c) 2014 RRobinson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChecklistsAddItemViewController.h"

@interface ChecklistsViewController : UITableViewController <ChecklistsAddItemViewControllerDelegate>

- (void)addItem:(ChecklistsItem *)newItem;

@end
