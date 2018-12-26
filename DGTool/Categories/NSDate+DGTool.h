//
//  NSDate+DGTool.h
//  DGTool
//
//  Created by david on 2018/12/25.
//  Copyright © 2018 david. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (DGTool)

#pragma mark - 判断
- (BOOL)isToday;
- (BOOL)isYesterday;
- (BOOL)isTomorrow;
- (BOOL)isInWeek;
- (BOOL)isInYear;

- (NSInteger)getEra;
- (NSInteger)getYear;
- (NSInteger)getMonth;
- (NSInteger)getDay;
- (NSInteger)getHour;
- (NSInteger)getMinute;
- (NSInteger)getSecond;

#pragma mark - 计算
- (NSInteger)daysOfMonth;
- (NSDate *)getNextMonthFirstDayForDate:(NSDate*)date;

#pragma mark - 转换str
/** yyyy-MM-dd HH:mm:ss */
- (NSString *)dateStrToSecond;

/** yyyy-MM-dd HH:mm:ss */
- (NSString *)dateStrToMinute;

/** yyyy-MM-dd */
- (NSString *)dateStrToDay;

/** yyyy年MM月dd日 (今天xx月xx日)*/
- (NSString *)readableDateStrToDay;

/** yyyy年MM月dd日 08:08 (具体到分, 当天不显示月日)*/
- (NSString *)readableDateStrToMinute;

#pragma mark - 周几
- (NSString *)convertToWeekDay;


@end

NS_ASSUME_NONNULL_END
