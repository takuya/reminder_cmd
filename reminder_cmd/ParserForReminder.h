//
//  ParserForReminder.h
//  reminder_cmd
//
//  Created by takuya  on 20150620.
//  Copyright (c) 2015年 takuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParserForReminder : NSObject

@property   NSDictionary *sub_commands;
@property   NSMutableArray *arguments;

-(void)list_of_remidners_calendar;
-(void)search;
-(void)add_reminder_with_title_to_default_calendar;
-(void)list_of_all_reminder_items;
-(void)parse:(NSArray *)arguments;



@end
