//
//  NSDate+Extend.m
//  categoryKitDemo
//
//  Created by zhanghao on 2016/7/23.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

#import "NSDate+Extend.h"

@implementation NSDate (Extend)

+ (NSCalendar *)clsCalendar {
    return [[self alloc] zh_calendar];
}

- (NSCalendar *)zh_calendar {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
#else
    return [NSCalendar currentCalendar]
#endif
}

- (NSInteger)year {
    return [[[self zh_calendar] components:NSCalendarUnitYear fromDate:self] year];
}

- (NSInteger)month {
    return [[[self zh_calendar] components:NSCalendarUnitMonth fromDate:self] month];
}

- (NSInteger)day {
    return [[[self zh_calendar] components:NSCalendarUnitDay fromDate:self] day];
}

- (NSInteger)hour {
    return [[[self zh_calendar] components:NSCalendarUnitHour fromDate:self] hour];
}

- (NSInteger)minute {
    return [[[self zh_calendar] components:NSCalendarUnitMinute fromDate:self] minute];
}

- (NSInteger)second {
    return [[[self zh_calendar] components:NSCalendarUnitSecond fromDate:self] second];
}

- (NSInteger)weekday {
    return [[[self zh_calendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

- (NSString *)dayFromWeekday {
    return [NSDate dayFromWeekday:self];
}

- (NSString *)dayFromWeekday2 {
    return [NSDate dayFromWeekday2:self];
}

- (NSString *)dayFromWeekday3 {
    return [NSDate dayFromWeekday3:self];
}

+ (NSString *)dayFromWeekday:(NSDate *)date {
    switch([date weekday]) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)dayFromWeekday2:(NSDate *)date {
    switch([date weekday]) {
        case 1:
            return @"周日";
            break;
        case 2:
            return @"周一";
            break;
        case 3:
            return @"周二";
            break;
        case 4:
            return @"周三";
            break;
        case 5:
            return @"周四";
            break;
        case 6:
            return @"周五";
            break;
        case 7:
            return @"周六";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)dayFromWeekday3:(NSDate *)date {
    switch([date weekday]) {
        case 1:
            return @"Sunday";
            break;
        case 2:
            return @"Monday";
            break;
        case 3:
            return @"Tuesday";
            break;
        case 4:
            return @"Wednesday";
            break;
        case 5:
            return @"Thursday";
            break;
        case 6:
            return @"Friday";
            break;
        case 7:
            return @"Saturday";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)ymdFormatJoinedByString:(NSString *)string {
    return [NSString stringWithFormat:@"yyyy%@MM%@dd", string, string];
}

+ (NSString *)ymdHmsFormat {
    return [NSString stringWithFormat:@"%@ %@", [self ymdFormat], [self hmsFormat]];
}

+ (NSString *)ymdFormat {
    
    NSDateFormatter *forma = [[NSDateFormatter alloc]init];
    [forma setDateFormat:@"yyyy-MM-dd"];
    return [forma stringFromDate:[NSDate date]];;
}

+(BOOL)isAlikeDay:(long)oneDate Tow:(long)towDate{
    
    BOOL is = [[[self dateWithTimeIntervalSince1970:oneDate/1000] stringWithFormat:@"yy年MM月dd日"] isEqualToString:[[self dateWithTimeIntervalSince1970:towDate/1000] stringWithFormat:@"yy年MM月dd日"]];
    return is;
}

+ (NSString *)hmsFormat {
    return @"HH:mm:ss";
}

+ (NSString *)dmyFormat {
    return @"dd/MM/yyyy";
}

+ (NSString *)myFormat {
    return @"MM/yyyy";
}

+ (NSString *)currentTimeString {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%d", (int)a];
    return timeString;
}

+ (NSString *)currentTimeString:(NSString *)dataStr {
    
    NSDateFormatter *forma = [[NSDateFormatter alloc]init];
    
    [forma setDateFormat:@"yyyy-MM-dd"];
    [forma setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];

    NSDate *date = [forma dateFromString:dataStr];

    NSTimeInterval a = [date timeIntervalSince1970];
    
    
    NSString *timeString = [NSString stringWithFormat:@"%d", (int)a];
    return timeString;
}

+ (NSString *)stringWithFormat:(NSString *)format {
    return [[NSDate date] stringWithFormat:format];
}


- (NSString *)ymdFormat {
    
    NSDateFormatter *forma = [[NSDateFormatter alloc]init];
    [forma setDateFormat:@"yyyy-MM-dd"];
    return [forma stringFromDate:self];
}

- (NSString *)ymdsFormat {
    NSDateFormatter *forma = [[NSDateFormatter alloc]init];
    [forma setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [forma stringFromDate:self];;
}

- (NSString *)msecFormatter {
    return [NSString stringWithFormat:@"%.0f", [self timeIntervalSince1970]*1000];
}

+ (NSString *)ymFormat {
    
    NSDateFormatter *forma = [[NSDateFormatter alloc]init];
    [forma setDateFormat:@"yyyy-MM"];
    return [forma stringFromDate:[NSDate date]];;
}

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter stringFromDate:self];
}

+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format {
    return [date stringWithFormat:format];
}

+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:dateString];
}

// (NSDate => Timestamp)
+ (NSInteger)timestampFromDate:(NSDate *)date {
    return [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
}

// (Timestamp => NSDate)
+ (NSDate *)dateFromTimestamp:(NSInteger)timestamp {
    return [NSDate dateWithTimeIntervalSince1970:timestamp];
}

// (TimeString => Timestamp)
+ (NSInteger)timestampFromTimeString:(NSString *)timeString formatter:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    // 将字符串按formatter转成NSDate
    NSDate *date = [formatter dateFromString:timeString];
    return [self timestampFromDate:date];
}

// (Timestamp => TimeString)
+ (NSString *)timeStringFromTimestamp:(NSInteger)timestamp formatter:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *timeDate = [self dateFromTimestamp:timestamp];
    return [formatter stringFromDate:timeDate];
}

+ (NSInteger)getNowTimestampWithFormatter:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    return [self timestampFromDate:[NSDate date]];
}

+ (NSInteger)getSumOfDaysMonth:(NSInteger)month inYear:(NSInteger)year {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    NSString *dateString = [NSString stringWithFormat:@"%lu-%lu", year, month];
    NSDate *date = [formatter dateFromString:dateString];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSRange range = [[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian] rangeOfUnit:NSCalendarUnitDay
                                     inUnit:NSCalendarUnitMonth
                                    forDate:date];
    return range.length;
#else
    NSRange range = [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit
                                     inUnit: NSMonthCalendarUnit
                                    forDate:date];
    return range.length;
#endif
}

// 获取当前的"年月日时分"
+ (NSArray<NSString *> *)getCurrentTimeComponents {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy,MM,dd,HH,mm"];
    NSDate *date = [NSDate date];
    NSString *time = [formatter stringFromDate:date];
    return [time componentsSeparatedByString:@","];
}


- (NSComparisonResult)compareDateString1:(NSString *)dateString1
                             dateString2:(NSString *)dateString2
                               formatter:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    NSDate *date1 = [[NSDate alloc] init];
    NSDate *date2 = [[NSDate alloc] init];
    date1 = [formatter dateFromString:dateString1];
    date2 = [formatter dateFromString:dateString2];
    return [date1 compare:date2];
}

- (BOOL)isInPast {
    return ([self compare:[NSDate date]] == NSOrderedAscending);
}

- (BOOL)isInFuture {
    return ([self compare:[NSDate date]] == NSOrderedDescending);
}

- (BOOL)zh_isSameDay:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}

- (BOOL)isToday {
    return [self zh_isSameDay:[NSDate date]];
}

+ (NSDate *)backward:(NSInteger)backwardN unitType:(NSCalendarUnit)unit {
    NSDateComponents *dateComponentsAsTimeQantum = [[NSDateComponents alloc] init];
    [dateComponentsAsTimeQantum setValue:backwardN forComponent:unit];
    
    NSDate *dateFromDateComponentsAsTimeQantum = [[self clsCalendar]
                                                  dateByAddingComponents:dateComponentsAsTimeQantum
                                                  toDate:[NSDate date]
                                                  options:0];
    return dateFromDateComponentsAsTimeQantum;
}

+ (NSDate *)forward:(NSInteger)forwardN unitType:(NSCalendarUnit)unit {
    return [self backward:-forwardN unitType:unit];
}

/**
 计算两个日期间隔多少天
 
 @param startDate 开始
 @param endDate 结束
 @return day
 */
+ (NSInteger)calSpaceDayDate:(NSString *)startDate endDate:(NSString *)endDate{
    //现在的时间
    NSDate * nowDate = [self dateWithString:startDate format:@"yyyy-MM-dd"];
    //字符串转NSDate格式的方法
    NSDate * ValueDate = [self dateWithString:endDate format:@"yyyy-MM-dd"];
    //计算两个中间差值(秒)
    NSTimeInterval time = [nowDate timeIntervalSinceDate:ValueDate];
    
    //开始时间和结束时间的中间相差的时间
    int days;
    days = ((int)time)/(3600*24);  //一天是24小时*3600秒
    return abs(days);
}

/**
 获取前一个月
 
 @param strDate <#strDate description#>
 @return <#return value description#>
 */
+ (NSDate *)getLastMonthWithDateString:(NSString *)strDate{
    NSCalendar *calender = [NSCalendar currentCalendar];
    // 设置属性，因为我只需要年和月，这个属性还可以支持时，分，秒
    NSDateComponents *cmp = [calender components:(NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:[NSDate dateWithString:strDate format:@"yyyy-MM-dd"]];
    //设置上个月，即在现有的基础上减去一个月(2017年1月 减去一个月 会得到2016年12月)
    [cmp setMonth:[cmp month] - 1];
    //拿到上个月的NSDate，再用NSDateFormatter就可以拿到单独的年和月了。
    NSDate *lastMonDate = [calender dateFromComponents:cmp];
    
    return lastMonDate;
}

/**
 获取后一个月
 
 @param strDate <#strDate description#>
 @return <#return value description#>
 */
+ (NSDate *)getNextMonthWithDateString:(NSString *)strDate{
    NSCalendar *calender = [NSCalendar currentCalendar];
    // 设置属性，因为我只需要年和月，这个属性还可以支持时，分，秒
    NSDateComponents *cmp = [calender components:(NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:[NSDate dateWithString:strDate format:@"yyyy-MM-dd"]];
    //设置上个月，即在现有的基础上减去一个月(2017年1月 减去一个月 会得到2016年12月)
    [cmp setMonth:[cmp month] + 1];
    //拿到上个月的NSDate，再用NSDateFormatter就可以拿到单独的年和月了。
    NSDate *nextMonDate = [calender dateFromComponents:cmp];
    
    return nextMonDate;
}

/**
 获取指定月份的天数
 
 @return <#return value description#>
 */
- (NSUInteger)getDays{
    //1.获取当月的总天数
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    
    NSUInteger numberOfDaysInMonth = range.length;
    
    return numberOfDaysInMonth;
    
    
}

@end
