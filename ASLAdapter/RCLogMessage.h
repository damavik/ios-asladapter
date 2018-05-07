//
//  RCLogMessage.h
//  RCASLAdapter
//
//  Created by Vital Vinahradau on 3/16/16.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, RCLogFlag){
    RCLogFlagError      = (1 << 0),
    RCLogFlagWarning    = (1 << 1),
    RCLogFlagInfo       = (1 << 2),
    RCLogFlagDebug      = (1 << 3),
    RCLogFlagTrace      = (1 << 4)
};

typedef NS_ENUM(NSUInteger, RCLogLevel) {
    RCLogLevelOff       = 0,
    RCLogLevelError     = RCLogFlagError,
    RCLogLevelWarning   = (RCLogLevelError   | RCLogFlagWarning),
    RCLogLevelInfo      = (RCLogLevelWarning | RCLogFlagInfo),
    RCLogLevelDebug     = (RCLogLevelInfo    | RCLogFlagDebug),
    RCLogLevelTrace     = (RCLogLevelDebug   | RCLogFlagTrace),
    RCLogLevelAll       = NSUIntegerMax
};

NS_ASSUME_NONNULL_BEGIN

@interface RCLogMessage : NSObject <NSCopying>

@property (nonatomic, assign) RCLogFlag logLevel;
@property (nonatomic, copy) NSDate *timestamp;
@property (nonatomic, copy) NSString *message;
@property (nullable, nonatomic, copy) NSString *filename;
@property (nonatomic, assign) NSUInteger line;

@end

NS_ASSUME_NONNULL_END
