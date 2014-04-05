//
//  ChecklistsViewController.h
//  Checklists
//
//  Created by Ryan Robinson on 3/29/14.
//  Copyright (c) 2014 RRobinson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"

@class Checklist;

@interface ChecklistViewController : UITableViewController <ItemDetailViewControllerDelegate>

- (void)addItem:(ChecklistItem *)newItem;

@property (strong, nonatomic) Checklist *checklist;

@end
