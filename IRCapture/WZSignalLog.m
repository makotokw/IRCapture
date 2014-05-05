//
//  WZSignalLog.m
//  IRCapture
//
//  Copyright (c) 2014 makoto_kw. All rights reserved.
//

#import "WZSignalLog.h"

@implementation WZSignalLog

{
    NSDate *_date;
}

@dynamic date;

- (id)initWithSignal:(IRSignal *)signal
{
    self = [super init];
    if (self) {
        _date               = [NSDate date];
        _signal             = signal;
        _signalDataString   = [WZSignalLog signalDataStringWithSignal:_signal];
        _signalAsJsonString = [WZSignalLog signalStringWithSignal:_signal];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _date               = [coder decodeObjectForKey:@"dt"];
        _signal             = [coder decodeObjectForKey:@"s"];
        _signalDataString   = [WZSignalLog signalDataStringWithSignal:_signal];
        _signalAsJsonString = [WZSignalLog signalStringWithSignal:_signal];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_date forKey:@"dt"];
    [coder encodeObject:_signal forKey:@"s"];
}

+ (NSString *)signalStringWithSignal:(IRSignal *)signal
{
    NSDictionary *message = @{ @"format": (signal.format) ? signal.format : [NSNull null],
                               @"freq": (signal.frequency) ? signal.frequency : [NSNull null],
                               @"data": (signal.data) ? signal.data : @[], };
    NSError *error;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:message
                                                        options:0
                                                          error:&error];
    
    if (jsonData) {
        NSString *JSONString = [[NSString alloc] initWithBytes:jsonData.bytes length:jsonData.length encoding:NSUTF8StringEncoding];
        
        return JSONString;
    }
    
    return nil;
}

+ (NSString *)signalDataStringWithSignal:(IRSignal *)signal
{
    NSError *error;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:signal.data
                                                        options:0
                                                          error:&error];
    
    if (jsonData) {
        NSString *JSONString = [[NSString alloc] initWithBytes:jsonData.bytes length:jsonData.length encoding:NSUTF8StringEncoding];
        
        return JSONString;
    }
    
    return nil;
}

- (NSDate *)date
{
    return _date;
}

- (NSString *)description
{
    return self.signalAsJsonString;
}

@end
