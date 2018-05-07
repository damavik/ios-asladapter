//
//  RCASLWriter.m
//  ASLAdapter
//
//  Created by Vital Vinahradau on 3/25/16.
//

#import "RCASLWriter.h"
#include <asl.h>

static int kSuccessCode = 0;
static char const *const kLevelStrings[] = { "0", "1", "2", "3", "4", "5", "5", "5" }; // Intentionally up to ASL_STRING_WARNING

@implementation RCASLWriter

#ifdef DEBUG
static NSString * kTargetFacility;

+ (void)setTargetFacility:(NSString *)facility {
    kTargetFacility = facility;
}

+ (void)resetTargetFacility {
    kTargetFacility = nil;
}
#endif

+ (BOOL)logWithLevel:(int)aslLevel andFinalMessage:(const char *)finalMessage {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        asl_add_log_file(NULL, STDERR_FILENO);
    });
    
    aslmsg msg = asl_new(ASL_TYPE_MSG);
    const char *level = kLevelStrings[aslLevel];
    int result = asl_set(msg, ASL_KEY_LEVEL, level);
    
    if (result != kSuccessCode) {
        asl_free(msg);
        return NO;
    }
    
    uid_t const readUID = geteuid();
    char readUIDString[16];
    snprintf(readUIDString, sizeof(readUIDString), "%d", readUID);
    
    result = asl_set(msg, ASL_KEY_READ_UID, readUIDString);
    
    if (result != kSuccessCode) {
        asl_free(msg);
        return NO;
    }
    
#ifdef DEBUG
    if (kTargetFacility.length > 0) {
        result = asl_set(msg, ASL_KEY_FACILITY, [kTargetFacility UTF8String]);
        
        if (result != kSuccessCode) {
            asl_free(msg);
            return NO;
        }
    }
#endif
    
    result = asl_set(msg, ASL_KEY_MSG, finalMessage);
    
    if (result != kSuccessCode) {
        asl_free(msg);
        return NO;
    }
    
    result = asl_send(NULL, msg);
    asl_free(msg);
    
    return (result == kSuccessCode);
}

+ (NSString *)logWithLevel:(int)aslLevel format:(NSString *)format andArgs:(va_list)args {
    NSString *finalMessage = [[NSString alloc] initWithFormat:format arguments:args];
    BOOL succeeded = [self logWithLevel:aslLevel andFinalMessage:[finalMessage UTF8String]];
    
    if (!succeeded) {
        return nil;
    }
    
    return finalMessage;
}

+ (nullable NSString *)logDebug:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    NSString *result = [self logDebug:format withArgs:args];
    va_end(args);
    
    return result;
}

+ (nullable NSString *)logTrace:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    NSString *result = [self logTrace:format withArgs:args];
    va_end(args);
    
    return result;
}

+ (nullable NSString *)logInfo:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    NSString *result = [self logInfo:format withArgs:args];
    va_end(args);
    
    return result;
}

+ (nullable NSString *)logError:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    NSString *result = [self logError:format withArgs:args];
    va_end(args);
    
    return result;
}

+ (nullable NSString *)logDebug:(NSString *)format withArgs:(va_list)args {
    return [self logWithLevel:ASL_LEVEL_DEBUG format:format andArgs:args];
}

+ (nullable NSString *)logTrace:(NSString *)format withArgs:(va_list)args {
    return [self logWithLevel:ASL_LEVEL_NOTICE format:format andArgs:args];
}

+ (nullable NSString *)logInfo:(NSString *)format withArgs:(va_list)args {
    return [self logWithLevel:ASL_LEVEL_INFO format:format andArgs:args];
}

+ (nullable NSString *)logError:(NSString *)format withArgs:(va_list)args {
    return [self logWithLevel:ASL_LEVEL_ERR format:format andArgs:args];
}


@end
