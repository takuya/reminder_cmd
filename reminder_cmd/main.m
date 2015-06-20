//
//  main.m
//  reminder_cmd
//
//  Created by takuya  on 20150611.
//  Copyright (c) 2015年 takuya. All rights reserved.
//


#import "MyReminderAccess.h"
#import "MyClass.h"


#import "ParserForReminder.h"
int main(int argc, const char * argv[]) {
  @autoreleasepool {
    NSProcessInfo *pinfo = [NSProcessInfo processInfo];
    ParserForReminder *parser = [[ParserForReminder alloc]init];
    [parser parse:pinfo.arguments];
  }
    return 0;
}
