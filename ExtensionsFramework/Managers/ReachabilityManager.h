//
//  ReachabilityManager.h
//  CocoaExtensions
//
//  Created by Lars Kuhnt on 05.02.14.
//  Copyright (c) 2014 Promptus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface ReachabilityManager : NSObject

@property (strong, nonatomic) Reachability *reachability;

+ (ReachabilityManager *)sharedManager;

+ (BOOL)isReachable;
+ (BOOL)isUnreachable;
+ (BOOL)isReachableViaWWAN;
+ (BOOL)isReachableViaWiFi;

@end
