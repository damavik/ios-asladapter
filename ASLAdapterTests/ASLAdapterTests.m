//
//  ASLAdapterTests.m
//  ASLAdapterTests
//
//  Created by Vital Vinahradau on 3/24/16.
//

#import <XCTest/XCTest.h>
#import <libextobjc/EXTScope.h>
#import "RCASLWriter.h"
#import "RCASLCapture.h"

@interface ASLAdapterTests : XCTestCase

@property (nonatomic, strong) RCASLCapture *aslCapture;

@end

@implementation ASLAdapterTests

- (void)setUp {
    [super setUp];
    
    NSString *facility = NSStringFromClass(self.class);
    [RCASLWriter setTargetFacility:facility];
    self.aslCapture = [[RCASLCapture alloc] init];
    self.aslCapture.targetFacility = facility;
}

- (void)tearDown {
    [self.aslCapture stopWithCompletion:nil];
    self.aslCapture = nil;
    
    [RCASLWriter resetTargetFacility];
    
    [super tearDown];
}

- (void)testInfoLogCapture {
     for (NSUInteger counter = 0; counter < 10; counter++) {
        XCTestExpectation *expectation = [self expectationWithDescription:@"asl"];
        
        NSString *message = [NSString stringWithFormat:@"Some test message with counter %ld", (long)counter];
        
        @weakify(self);
        [self.aslCapture startWithCallback:^(RCLogMessage * _Nonnull logMessage) {
            @strongify(self);
            
            XCTAssertEqual(logMessage.logLevel, RCLogFlagInfo);
            XCTAssertEqualObjects(logMessage.message, message);
            
            [self.aslCapture stopWithCompletion:^{
                [expectation fulfill];
            }];
        }];
        
        [RCASLWriter logInfo:@"%@", message];
        
        [self waitForExpectationsWithTimeout:2.0 handler:nil];
    }
}

- (void)testErrorLogCapture {
    for (NSUInteger counter = 0; counter < 10; counter++) {
        XCTestExpectation *expectation = [self expectationWithDescription:@"asl"];
        
        NSString *message = [NSString stringWithFormat:@"Some test message with counter %ld", (long)counter];
        
        [self.aslCapture startWithCallback:^(RCLogMessage * _Nonnull logMessage) {
            XCTAssertEqual(logMessage.logLevel, RCLogFlagError);
            XCTAssertEqualObjects(logMessage.message, message);
            
            [self.aslCapture stopWithCompletion:^{
               [expectation fulfill];
            }];
        }];
        
        [RCASLWriter logError:@"%@", message];
        
        [self waitForExpectationsWithTimeout:2.0 handler:nil];
    }
}

@end
