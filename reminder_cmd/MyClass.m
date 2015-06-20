//
//  MyClass.m
//  reminder_cmd
//
//  Created by takuya on 20150617.
//  Copyright (c) 2015年 takuya. All rights reserved.
//

#import "MyClass.h"
#import "MyReminderAccess.h"
#import <EventKit/EventKit.h>


@implementation MyClass
-(void)recieve:(NSNotificationCenter *)nc{
  @autoreleasepool {
  printf("recieved\n");
    //[MyReminderAccess list_of_remidners_in_calendar_with_name:@"inbox"];
  }
}
-(id)init {
  @autoreleasepool{
    self.eventStore = [[EKEventStore alloc] init];
    self.terminated=NO;
    printf("init\n");
    return self;
  }
}
-(void)add{
  printf("add Observer\n");
  NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
  [center addObserver:self selector:@selector(recieve:) name:EKEventStoreChangedNotification object:self.eventStore];
}


@end
