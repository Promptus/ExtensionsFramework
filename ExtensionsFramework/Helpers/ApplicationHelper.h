//
//  ApplicationHelper.h
//  CocoaExtensions
//
//  Created by Lars Kuhnt on 05.02.14.
//  Copyright (c) 2014 Promptus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface ApplicationHelper : NSObject

@property (readonly, nonatomic, strong) Reachability * reachability;

# pragma mark Filesystem helpers

+ (NSURL *)documentsDirectory;
+ (uint64_t)freeDiscSpace;
+ (BOOL)freeDiscSpaceFallsShortOf:(NSUInteger)megaBytes;

# pragma mark Translation helpers

+ (NSString*)t:(NSString*)key;

# pragma mark Reachability helpers

- (void)setupReachability:(NSString*)host;
- (BOOL)isReachable;
- (BOOL)isUnreachable;
- (BOOL)isReachableViaWWAN;
- (BOOL)isReachableViaWiFi;

@end
