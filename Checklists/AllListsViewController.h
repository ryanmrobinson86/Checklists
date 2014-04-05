//
//  AllListsViewController.h
//  Checklists
//
//  Created by Ryan Robinson on 4/3/14.
//  Copyright (c) 2014 RRobinson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListDetailViewController.h"

@class DataModel;

@interface AllListsViewController : UITableViewController <ListDetailViewControllerDelegate>

@property (strong, nonatomic)DataModel *dataModel;

@end
