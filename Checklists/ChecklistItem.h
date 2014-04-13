//
//  ChecklistsItem.h
//  Checklists
//
//  Created by Ryan Robinson on 3/29/14.
//  Copyright (c) 2014 RRobinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistItem : NSObject <NSCoding>

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) BOOL checked;
@property (nonatomic, copy) NSDate *dueDate;
@property (nonatomic, assign) BOOL shouldRemind;
@property (nonatomic, assign) NSInteger itemId;

- (void)toggleChecked;
- (void)scheduleNotification;

@end
