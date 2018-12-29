//
//  NSDate+DGTool.m
//  DGTool
//
//  Created by david on 2018/12/25.
//  Copyright © 2018 david. All rights reserved.
//

#import "NSDate+DGTool.h"

@implementation NSDate (DGTool)


#pragma mark - 判断
- (BOOL)isToday {
    NSCalendar* calendar = NSCalendar.currentCalendar;
    return [calendar isDateInToday:self];
    
    /*
    NSDateComponents *components = [calendar components:NSCalendarUnitDay
                                                    fromDate:[NSDate date]];
    NSDateComponents *selfComponents = [calendar components:NSCalendarUnitDay
                                                   fromDate:self];
    return (components.day == selfComponents.day);
     */
}

- (BOOL)isYesterday {
    NSCalendar* calendar = NSCalendar.currentCalendar;
    return [calendar isDateInYesterday:self];
    
    /*
     NSDateComponents *components = [calendar components:NSCalendarUnitDay
     fromDate:[NSDate date]];
     NSDateComponents *selfComponents = [calendar components:NSCalendarUnitDay
     fromDate:self];
     return (components.day - 1 == selfComponents.day);
     */
}

- (BOOL)isTomorrow {
    
    NSCalendar* calendar = NSCalendar.currentCalendar;
    return [calendar isDateInTomorrow:self];
    
    /*
    NSDateComponents *components = [calendar components:NSCalendarUnitDay
                                                    fromDate:[NSDate date]];
    NSDateComponents *selfComponents = [calendar components:NSCalendarUnitDay
                                                   fromDate:self];
    return (components.day + 1 == selfComponents.day);
     */
}

- (BOOL)isInWeek {
    NSCalendar* calendar = NSCalendar.currentCalendar;
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekOfYear
                                                    fromDate:[NSDate date]];
    NSDateComponents *selfComponents = [calendar components:NSCalendarUnitDay
                                                   fromDate:self];
    return (components.weekOfYear == selfComponents.weekOfYear);
}

- (BOOL)isInYear {
    NSCalendar* calendar = NSCalendar.currentCalendar;
    NSDateComponents *components = [calendar components:NSCalendarUnitYear
                                                    fromDate:[NSDate date]];
    NSDateComponents *selfComponents = [calendar components:NSCalendarUnitYear
                                                   fromDate:self];
    return (components.year == selfComponents.year);
}

#pragma mark - 单一值获取
- (NSInteger)getEra {
    NSCalendar *calendar = NSCalendar.currentCalendar;
    NSDateComponents *components = [calendar components:NSCalendarUnitEra fromDate:self];
    return components.era;
}

- (NSInteger)getYear {
    NSCalendar *calendar = NSCalendar.currentCalendar;
    NSDateComponents *component = [calendar components:NSCalendarUnitYear fromDate:self];
    return component.year;
}

- (NSInteger)getMonth {
    NSCalendar *calendar = NSCalendar.currentCalendar;
    NSDateComponents *component = [calendar components:NSCalendarUnitMonth fromDate:self];
    return component.month;
}

- (NSInteger)getDay {
    NSCalendar *calendar = NSCalendar.currentCalendar;
    NSDateComponents *component = [calendar components:NSCalendarUnitDay fromDate:self];
    return component.day;
}

- (NSInteger)getHour {
    NSCalendar *calendar = NSCalendar.currentCalendar;
    NSDateComponents *component = [calendar components:NSCalendarUnitHour fromDate:self];
    return component.hour;
}

- (NSInteger)getMinute {
    NSCalendar *calendar = NSCalendar.currentCalendar;
    NSDateComponents *component = [calendar components:NSCalendarUnitMinute fromDate:self];
    return component.minute;
}

- (NSInteger)getSecond {
    NSCalendar *calendar = NSCalendar.currentCalendar;
    NSDateComponents *component = [calendar components:NSCalendarUnitSecond fromDate:self];
    return component.second;
}


#pragma mark - 判断
- (NSInteger)daysOfMonth {
    NSCalendar * calendar = NSCalendar.currentCalendar;
    //两个参数一个大单位，一个小单位(.length就是天数，.location就是月)
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return (NSInteger)range.length;
}

- (NSDate *)getNextMonthFirstDayForDate:(NSDate*)date {
    NSCalendar *calendar = NSCalendar.currentCalendar;
    //1.unit
    NSCalendarUnit dayInfoUnits  = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    //2.components
    NSDateComponents *components = [calendar components: dayInfoUnits fromDate:date];
    
    //3. 编辑
    components.day = 1;
    components.month++;
    
    //4.转成需要的date对象return
     return [calendar dateFromComponents:components];
}

#pragma mark - 转换str
/** yyyy-MM-dd */
- (NSString *)dateStrToDay {
    
    static NSDateFormatter* dateFormat = nil;
    if (!dateFormat) {
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];//hh:12小时制, HH:24小时制
    }
    return [dateFormat stringFromDate:self];
}

/** yyyy-MM-dd HH:mm */
- (NSString *)dateStrToMinute {
    static NSDateFormatter* dateFormat = nil;
    if (!dateFormat) {
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];//hh:12小时制, HH:24小时制
    }
    return [dateFormat stringFromDate:self];
}

/** yyyy-MM-dd HH:mm:ss */
- (NSString *)dateStrToSecond {
    
    static NSDateFormatter* dateFormat = nil;
    if (!dateFormat) {
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//hh:12小时制, HH:24小时制
    }
    return [dateFormat stringFromDate:self];
}

/** yyyy年MM月dd日 */
- (NSString *)readableDateStrToDay {
    
    //1.转换成dateStr
    static NSDateFormatter* dateFormat = nil;
    if (!dateFormat) {
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy年MM月dd日"];//hh:12小时制, HH:24小时制
    }
    NSString *dateStr = [dateFormat stringFromDate:self];
    
    //2.不同年
    if(![self isInYear]){
        return dateStr ;
    }
    
    //3.同年
    dateStr = [dateStr substringWithRange:NSMakeRange(5, 6)];
    
    //3.1 当天
    if([self isToday]){
        return [@"今天 " stringByAppendingString: dateStr];
    }
    
    //3.2 昨天
    if ([self isYesterday]) {
        return [@"昨天 " stringByAppendingString: dateStr];
    }
    
    //3.3 年内某一天
    return dateStr;
}

/** yyyy年MM月dd日 08:08 (具体到分, 当天不显示月日)*/
- (NSString *)readableDateStrToMinute {
    
    //1.转换成dateStr
    static NSDateFormatter* dateFormat = nil;
    if (!dateFormat) {
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy年MM月dd日 HH:mm"];//hh:12小时制, HH:24小时制
    }
    NSString *dateStr = [dateFormat stringFromDate:self];
    
    //2.不同年
    if(![self isInYear]){
        return dateStr;
    }
    
    //3.同年
    //3.1 当天
    if([self isToday]){
        dateStr = [dateStr substringWithRange:NSMakeRange(12, 5)];
        return [@"今天 " stringByAppendingString: dateStr];
    }
    
    //3.2 昨天
    if ([self isYesterday]) {
        dateStr = [dateStr substringWithRange:NSMakeRange(12, 5)];
        return [@"昨天 " stringByAppendingString: dateStr];
    }
    
    //3.3 年内某一天
    return [dateStr substringWithRange:NSMakeRange(5, 12)];
}


#pragma mark - 周几
-(NSString *)convertToWeekDay {
    NSCalendar* calendar = NSCalendar.currentCalendar;
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday
                                                    fromDate:self];
    static NSArray *weekdays = nil;
    if(!weekdays){
       weekdays =@[@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
    }
    return  weekdays[components.weekday-1];
    
}
@end
