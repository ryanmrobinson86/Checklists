//
//  DataModel.h
//  Checklists
//
//  Created by Ryan Robinson on 4/4/14.
//  Copyright (c) 2014 RRobinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property (strong, nonatomic)NSMutableArray *lists;

- (void)saveChecklists;
- (void)loadChecklists;
- (NSInteger)indexOfSelectedChecklist;
- (void)setIndexofSelectedChecklist:(NSInteger)index;
- (void)setFirstTime;
- (void)sortChecklists;

+ (NSInteger)nextChecklistItemId;

@end
