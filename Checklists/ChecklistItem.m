//
//  ChecklistsItem.m
//  Checklists
//
//  Created by Ryan Robinson on 3/29/14.
//  Copyright (c) 2014 RRobinson. All rights reserved.
//

#import "ChecklistItem.h"
#import "DataModel.h"

@implementation ChecklistItem

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:@"Text"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];
    [aCoder encodeObject:self.dueDate forKey:@"dueDate"];
    [aCoder encodeBool:self.shouldRemind forKey:@"shouldRemind"];
    [aCoder encodeInteger:self.itemId forKey:@"itemId"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super init])){
        self.text = [aDecoder decodeObjectForKey:@"Text"];
        self.checked = [aDecoder decodeBoolForKey:@"Checked"];
        self.dueDate = [aDecoder decodeObjectForKey:@"dueDate"];
        self.shouldRemind = [aDecoder decodeBoolForKey:@"shouldRemind"];
        self.itemId = [aDecoder decodeIntegerForKey:@"itemId"];
    }
    return self;
}

- (id)init
{
    if(self = [super init]){
        self.itemId = [DataModel nextChecklistItemId];
        self.dueDate = [NSDate dateWithTimeIntervalSinceNow:(3600*24)];
    }
    return self;
}

- (void)dealloc
{
    UILocalNotification *thisItemNotification = [self notificationForThisItem];
    
    if(thisItemNotification){
        [[UIApplication sharedApplication] cancelLocalNotification:thisItemNotification];
    }
}

- (void)toggleChecked;
{
    self.checked = !self.checked;
}

- (void)scheduleNotification
{
    UILocalNotification *existingNotification = [self notificationForThisItem];
    
    if(existingNotification){
        [[UIApplication sharedApplication] cancelLocalNotification:existingNotification];
    }
    
    if(self.shouldRemind && [self.dueDate compare:[NSDate date]] != NSOrderedAscending){
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        
        localNotification.fireDate = self.dueDate;
        localNotification.alertBody = self.text;
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        localNotification.userInfo = @{@"ItemID": @(self.itemId)};
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
}

- (UILocalNotification *)notificationForThisItem
{
    NSArray *allNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    
    for(UILocalNotification *notification in allNotifications){
        NSNumber *number = [notification.userInfo objectForKey:@"ItemID"];
        
        if([number integerValue] == self.itemId){
            return notification;
        }
    }
    return nil;
}
@end
