//
//  RCASLCapture.h
//  RCASLAdapter
//
//  Created by Vital Vinahradau on 3/16/16.
//

#import "RCLogMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface RCASLCapture : NSObject

@property (nonatomic, assign) RCLogLevel logLevel;

#ifdef DEBUG
@property (nullable, nonatomic, copy) NSString *targetFacility;
#endif

- (void)startWithCallback:(void (^)(RCLogMessage *logMessage))callback;
- (void)stopWithCompletion:(nullable void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END
