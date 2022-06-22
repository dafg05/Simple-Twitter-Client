//
//  Tweet.m
//  twitter
//
//  Created by Daniel Flores Garcia on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Tweet.h"

@implementation Tweet

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    if (self) {
        // Is this a re-tweet?
        NSDictionary *originalTweet = dictionary[@"retweeted_status"];
        if (originalTweet != nil) {
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];

            // Change tweet to original tweet
            dictionary = originalTweet;
        }
        self.idStr = dictionary[@"id_str"];
        self.text = dictionary[@"text"];
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];

        // initialize user
        NSDictionary *user = dictionary[@"user"];
        self.user = [[User alloc] initWithDictionary:user];

        // Format and set createdAtString
        
        NSString *createdAtOriginalString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // Configure the input format to parse the date string
        formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
        // Convert String to Date
        NSDate *date = [formatter dateFromString:createdAtOriginalString];
        self.createdAtString = [Tweet timeAgoStringFromDate:date];
//        // Configure output format
//        formatter.dateStyle = NSDateFormatterShortStyle;
//        formatter.timeStyle = NSDateFormatterNoStyle;
//        // Convert Date to String
//        self.createdAtString = [formatter stringFromDate:date];
    }
    return self;
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries {
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    return tweets;
}

+ (NSString *)timeAgoStringFromDate:(NSDate *)date {
    // code from stack overflow:
    // https://stackoverflow.com/questions/27519533/how-to-format-date-in-to-string-like-as-one-days-ago-minutes-ago-in-ios
    
    NSDateComponentsFormatter *formatter = [[NSDateComponentsFormatter alloc] init];
    formatter.unitsStyle = NSDateComponentsFormatterUnitsStyleFull;

    NSDate *now = [NSDate date];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekOfMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond)
                                               fromDate:date
                                                 toDate:now
                                                options:0];

    if (components.year > 0) {
        formatter.allowedUnits = NSCalendarUnitYear;
    } else if (components.month > 0) {
        formatter.allowedUnits = NSCalendarUnitMonth;
    } else if (components.weekOfMonth > 0) {
        formatter.allowedUnits = NSCalendarUnitWeekOfMonth;
    } else if (components.day > 0) {
        formatter.allowedUnits = NSCalendarUnitDay;
    } else if (components.hour > 0) {
        formatter.allowedUnits = NSCalendarUnitHour;
    } else if (components.minute > 0) {
        formatter.allowedUnits = NSCalendarUnitMinute;
    } else {
        formatter.allowedUnits = NSCalendarUnitSecond;
    }

    NSString *formatString = NSLocalizedString(@"%@ ago", @"Used to say how much time has passed. e.g. '2 hours ago'");

    return [NSString stringWithFormat:formatString, [formatter stringFromDateComponents:components]];
}

@end
