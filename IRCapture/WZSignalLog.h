//
//  WZSignalLog.h
//  IRCapture
//
//  Copyright (c) 2014 makoto_kw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZSignalLog : NSObject

@property (readonly) NSDate *date;
@property IRSignal *signal;
@property (readonly) NSString *signalAsJsonString;
@property (readonly) NSString *signalDataString;

- (id)initWithSignal:(IRSignal *)signal;

@end
