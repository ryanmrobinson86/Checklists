//
//  Checklist.h
//  Checklists
//
//  Created by Ryan Robinson on 4/3/14.
//  Copyright (c) 2014 RRobinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Checklist : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong)NSMutableArray *items;

@end
