//
//  MyClass.h
//  reminder_cmd
//
//  Created by takuya on 20150617.
//  Copyright (c) 2015年 takuya. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>

@interface MyClass : NSObject

@property (strong, nonatomic) EKEventStore *eventStore;
@property (nonatomic) BOOL terminated;

-(void)recieve:(NSNotificationCenter *)nc;
-(void)add;
@end

