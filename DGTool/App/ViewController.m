//
//  ViewController.m
//  DGTool
//
//  Created by david on 2018/9/28.
//  Copyright © 2018 david. All rights reserved.
//

#import "ViewController.h"
#import "DGImageTool.h"
#import "NSDate+DGTool.h"
#import "NSObject+DGRuntime.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.grayColor;
    
    //[self testCalendar];
    //[self testDate];
    [self testPredicate];
    
   NSDictionary *dic = [[[UIResponder alloc]init] getAllProperties];
    NSLog(@"properties:%@",dic);
}

#pragma mark -
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

}

#pragma mark -
-(void)testDate {
    NSDate *date = [NSDate date];
    
    NSLog(@"dateStrToDay: %@",[date dateStrToDay]);
    NSLog(@"dateStrToMinute: %@",[date dateStrToMinute]);
    NSLog(@"dateStrToSecond: %@",[date dateStrToSecond]);
    NSLog(@"readableDateStrToDay: %@",[date readableDateStrToDay]);
    NSLog(@"readableDateStrToMinute: %@",[date readableDateStrToMinute]);
}


-(void)testCalendar {
    // 定义
    NSCalendar *calendar = NSCalendar.currentCalendar;
    
    // 通过已定义的日历对象，获取某个时间点的NSDateComponents表示，并设置需要表示哪些信息（NSYearCalendarUnit, NSMonthCalendarUnit, NSDayCalendarUnit等）
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitEra |
    NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond |
    NSCalendarUnitWeekday |
    NSCalendarUnitWeekdayOrdinal |
    NSCalendarUnitQuarter |
    NSCalendarUnitWeekOfMonth |
    NSCalendarUnitWeekOfYear |
    NSCalendarUnitYearForWeekOfYear |
    NSCalendarUnitNanosecond |
    NSCalendarUnitCalendar |
    NSCalendarUnitTimeZone;
    comps = [calendar components:unitFlags fromDate:[NSDate date]];
    
    NSLog(@"era(世纪): %ld", (long)comps.era);
    NSLog(@"year(年份): %ld", (long)comps.year);
    NSLog(@"quarter(季度):%ld", (long)comps.quarter);
    NSLog(@"month(月份):%ld", (long)comps.month);
    NSLog(@"day(日期):%ld", (long)comps.day);
    NSLog(@"hour(小时):%ld", (long)comps.hour);
    NSLog(@"minute(分钟):%ld", (long)comps.minute);
    NSLog(@"second(秒):%ld", (long)comps.second);
    
    //    Sunday:1, Monday:2, Tuesday:3, Wednesday:4, Thursday:5, Friday:6, Saturday:7
    NSLog(@"weekday(星期):%ld", (long)comps.weekday);
    
    NSLog(@"weekOfYear(该年第几周):%ld", (long)comps.weekOfYear);
    NSLog(@"weekOfMonth(该月第几周):%ld", (long)comps.weekOfMonth);
    NSLog(@"yearForWeekOfYear(年):%ld", (long)comps.yearForWeekOfYear);//不是很明白其含义
}


-(void)testPredicate {
    NSPredicate *p = [NSPredicate predicateWithFormat:@"age = 5 && name = david"];
    
}
@end
