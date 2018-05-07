//
//  RCASLWriter.h
//  ASLAdapter
//
//  Created by Vital Vinahradau on 3/25/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCASLWriter : NSObject

- (instancetype)init __attribute__((unavailable("init not available")));
+ (instancetype)new __attribute__((unavailable("new not available")));

#ifdef DEBUG
    + (void)setTargetFacility:(NSString *)facility;
    + (void)resetTargetFacility;
#endif

+ (nullable NSString *)logDebug:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (nullable NSString *)logTrace:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (nullable NSString *)logInfo:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (nullable NSString *)logError:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

+ (nullable NSString *)logDebug:(NSString *)format withArgs:(va_list)args NS_FORMAT_FUNCTION(1,0);
+ (nullable NSString *)logTrace:(NSString *)format withArgs:(va_list)args NS_FORMAT_FUNCTION(1,0);
+ (nullable NSString *)logInfo:(NSString *)format withArgs:(va_list)args NS_FORMAT_FUNCTION(1,0);
+ (nullable NSString *)logError:(NSString *)format withArgs:(va_list)args NS_FORMAT_FUNCTION(1,0);

@end

NS_ASSUME_NONNULL_END
