//
//  ChecklistsItem.m
//  Checklists
//
//  Created by Ryan Robinson on 3/29/14.
//  Copyright (c) 2014 RRobinson. All rights reserved.
//

#import "ChecklistItem.h"

@implementation ChecklistItem

-(void)toggleChecked;
{
    self.checked = !self.checked;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:@"Text"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super init])){
        self.text = [aDecoder decodeObjectForKey:@"Text"];
        self.checked = [aDecoder decodeBoolForKey:@"Checked"];
    }
    return self;
}

@end
