//
//  MyReminderAccess.h
//  reminder_cmd
//
//  Created by takuya on 20150617.
//  Copyright (c) 2015年 takuya. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyReminderAccess : NSObject
+ (NSArray *)list_of_remidners_calendar;
+ (NSArray *)list_of_remidners;
+ (void)add_reminder_with_title_to_calendar_with_name :(NSString *)title :(NSString *)name;
+ (void)add_reminder_with_title_to_default_calendar:(NSString *)title;
+ (void)list_of_remidners_in_calendar_with_name:( NSString *)name ;
@end
