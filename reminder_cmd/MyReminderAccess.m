//
//  MyReminderAccess.m
//  reminder_cmd
//
//  Created by takuya on 20150617.
//  Copyright (c) 2015年 takuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>

#import "MyReminderAccess.h"


@implementation MyReminderAccess : NSObject
+ (NSArray *)list_of_remidners_calendar
{
  EKEventStore *eventStore = [[EKEventStore alloc] init];
  NSArray *calendars = [eventStore calendarsForEntityType:EKEntityTypeReminder];
  NSMutableArray *ret = [[NSMutableArray alloc] init];
  int size = (int)calendars.count ;
  for (int i=0; i< size; i++) {
    EKCalendar *cal = calendars[i];
    NSString *name = cal.title;
    [ret addObject:name];
  }
  return [ret copy];
}
+ (void)add_reminder_with_title_to_calendar_with_name :(NSString *)title :(NSString *)name{
  EKEventStore *eventStore = [[EKEventStore alloc] init];
  EKReminder *new_reminder  = [EKReminder reminderWithEventStore:eventStore ];
  EKCalendar *cal = [eventStore defaultCalendarForNewReminders];
  NSArray *calendars = [eventStore calendarsForEntityType:EKEntityTypeReminder];

  for (EKCalendar *calendar in calendars)
  {
    if ([calendar.title isEqualToString:name]) {
      printf("%sのカレンダを発見\n", [calendar.title UTF8String]);
      cal = calendar;

    }
  }
  new_reminder.title = title;
  new_reminder.calendar = cal;
  NSError *error;
  if(![eventStore saveReminder:new_reminder commit:YES error:&error]) NSLog(@"%@", error);

}

+ (void)add_reminder_with_title_to_default_calendar: ( NSString *)title{

  EKEventStore *eventStore = [[EKEventStore alloc] init];
  EKReminder *new_reminder  = [EKReminder reminderWithEventStore:eventStore ];
  new_reminder.title = title;
  new_reminder.calendar = [eventStore defaultCalendarForNewReminders];
    //new_reminder.calendar =  [eventStore defaultCalendarForNewReminders];
  NSError *error;
  if(![eventStore saveReminder:new_reminder commit:YES error:&error]) NSLog(@"%@", error);
}
+ (NSArray *)list_of_remidners
{
  EKEventStore *eventStore = [[EKEventStore alloc] init];
  __block BOOL busy = YES;
  __block NSArray *reminders;
  NSPredicate *predicate = [eventStore predicateForRemindersInCalendars:nil];
  [eventStore fetchRemindersMatchingPredicate:predicate completion:^(NSArray *list) {
    reminders = list;
    busy = NO;
  }];
  while( busy ){ sleep(0.1);}
  return reminders;
}


+ (void)list_of_remidners_in_calendar_with_name: ( NSString *)name
{
    //指定したリマインダのTODOを一覧する。
  EKEventStore *eventStore = [[EKEventStore alloc] init];
  EKCalendar *cal = [eventStore defaultCalendarForNewReminders];
  NSArray *calendars = [eventStore calendarsForEntityType:EKEntityTypeReminder];

  for (EKCalendar *calendar in calendars)
  {
    if ([calendar.title isEqualToString:name]) {
      printf("%sのカレンダを発見\n", [calendar.title UTF8String]);
      cal = calendar;

    }
  }
  __block BOOL busy = YES;
  __block NSArray *reminders;
  NSPredicate *predicate = [eventStore predicateForRemindersInCalendars:[NSArray arrayWithObject:cal]];
  [eventStore fetchRemindersMatchingPredicate:predicate completion:^(NSArray *list) {
    reminders = list;
    busy = NO;
  }];
  while( busy ){ sleep(0.1);}
  for( EKReminder *reminder in reminders){
    printf("%s\n", [reminder.title UTF8String]);
    printf("追加日 %s \n", [[NSDateFormatter
                          localizedStringFromDate:reminder.lastModifiedDate dateStyle:NSDateFormatterFullStyle timeStyle:NSDateFormatterShortStyle
                          ] UTF8String]);
    printf("場所 %s\n", [reminder.location UTF8String]);
    printf("URL %s\n", [[reminder.URL absoluteString] UTF8String]);
    printf("完了 %d\n", reminder.completed);
    printf("識別子(EX) %s\n", [reminder.calendarItemExternalIdentifier UTF8String]);
    printf("識別子(local) %s\n", [reminder.calendarItemIdentifier UTF8String]);
    printf("パーマリンク(local) x-apple-reminder://%s\n", [reminder.calendarItemIdentifier UTF8String]);
      //reminder.completed;
  }
}
@end
