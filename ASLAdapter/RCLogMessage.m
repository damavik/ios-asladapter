//
//  RCLogMessage.m
//  RCASLAdapter
//
//  Created by Vital Vinahradau on 3/16/16.
//

#import "RCLogMessage.h"

@implementation RCLogMessage

- (instancetype)copyWithZone:(NSZone *)zone {
    RCLogMessage *copy = [[[self class] allocWithZone:zone] init];
    copy->_logLevel = self.logLevel;
    copy->_timestamp = [self.timestamp copyWithZone:zone];
    copy->_message = [self.message copyWithZone:zone];
    copy->_filename = [self.filename copyWithZone:zone];
    copy->_line = self.line;
    return copy;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:self.class]) {
        return NO;
    }
    
    RCLogMessage *other = (RCLogMessage *)object;
    
    if (self.logLevel != other.logLevel) {
        return NO;
    }
    
    if (![self.timestamp isEqualToDate:other.timestamp]) {
        return NO;
    }
    
    if (![self.message isEqualToString:other.message]) {
        return NO;
    }
    
    if (self.filename != other.filename && ![self.filename isEqualToString:other.filename]) {
        return NO;
    }
    
    if (self.line != other.line) {
        return NO;
    }
    
    return YES;
}

@end
