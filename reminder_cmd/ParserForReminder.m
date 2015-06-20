//
//  ParserForReminder.m
//  reminder_cmd
//
//  Created by takuya  on 20150620.
//  Copyright (c) 2015年 takuya. All rights reserved.
//

#import <EventKit/EventKit.h>

#import "ParserForReminder.h"
#import "MyReminderAccess.h"

@implementation ParserForReminder

-(id)init{
  self.sub_commands = [NSDictionary dictionaryWithObjectsAndKeys:
                                //val, key
                                @"list_of_remidners",@"list",
                                @"list_of_remidners_calendar",@"list_of_list",
                                @"add_reminder_with_title_to_default_calendar",@"add",
                                @"search",@"search",
                                nil];
  return self;
}
-(void)help{
  NSArray *names = [self.sub_commands allKeys];
  printf("avaiable sub commands \n");
  for(NSString *str in names){
    printf( " -  %s\n", [str UTF8String]);
  }
}
-(void)parse :(NSArray *)args {

  self.arguments = [args mutableCopy];
  [self.arguments removeObjectAtIndex:0];
  if( self.arguments.count < 1 ){
    [self performSelector:NSSelectorFromString(@"help") ];
    return;
  }
  NSString *subcommand = [self.arguments objectAtIndex:0];
  [self.arguments removeObjectAtIndex:0];
  NSString *selector = [self.sub_commands objectForKey:subcommand];
  if( selector == nil){
    [self performSelector:NSSelectorFromString(@"help") ];
    return;
  }

  SEL sel = NSSelectorFromString(selector);
  [self performSelector: sel ];

}
-(void)list_of_remidners{
  NSArray *reminders = [MyReminderAccess performSelector:_cmd];
  for(EKReminder *reminder in reminders){
    printf("%s - %s\n",[reminder.calendar.title UTF8String],[reminder.title UTF8String]);
  }
}
-(void)list_of_remidners_calendar{
  NSArray *calendar_names = [MyReminderAccess performSelector:_cmd];
  printf("リマインダリスト一覧\n");
  for( NSString *name  in calendar_names){
    printf("%s\n",[name UTF8String]);
  }
}
-(void)add_reminder_with_title_to_default_calendar{
  NSString *remind_me = [self.arguments componentsJoinedByString:@" "];
  [MyReminderAccess add_reminder_with_title_to_default_calendar: remind_me];
}

-(void)search{
  EKEventStore *eventStore = [[EKEventStore alloc] init];
  __block BOOL busy = YES;
  __block NSArray *reminders;
      NSPredicate *predicate = [eventStore predicateForRemindersInCalendars:nil];
  [eventStore fetchRemindersMatchingPredicate:predicate completion:^(NSArray *list) {
    reminders = list;
    busy = NO;
  }];
  while( busy ){ sleep(0.1);}
  if( self.arguments.count > 0){
    NSString *keywowords =[self.arguments objectAtIndex:0];
    NSPredicate *search_by_title = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"title like '%@'", keywowords ]];
    reminders = [reminders filteredArrayUsingPredicate:search_by_title];

  }
  for(EKReminder *reminder in reminders){
      //printf("%s - %s\n",[reminder.calendar.title UTF8String],[reminder.title UTF8String]);
    printf("%s\n",[reminder.title UTF8String]);
  }

}


@end






