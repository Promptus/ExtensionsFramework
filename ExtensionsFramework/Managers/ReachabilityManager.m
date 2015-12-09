//
//  ReachabilityManager.m
//  CocoaExtensions
//
//  Created by Lars Kuhnt on 05.02.14.
//  Copyright (c) 2014 Promptus. All rights reserved.
//

#import "ReachabilityManager.h"

@implementation ReachabilityManager

+ (ReachabilityManager *)sharedManager {
  static ReachabilityManager *_sharedManager = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedManager = [[self alloc] init];
  });
  return _sharedManager;
}

- (void)dealloc {
  if (_reachability) {
    [_reachability stopNotifier];
  }
}

+ (BOOL)isReachable {
  return [[[ReachabilityManager sharedManager] reachability] isReachable];
}
+ (BOOL)isUnreachable {
  return ![[[ReachabilityManager sharedManager] reachability] isReachable];
}
+ (BOOL)isReachableViaWWAN {
  return [[[ReachabilityManager sharedManager] reachability] isReachableViaWWAN];
}
+ (BOOL)isReachableViaWiFi {
  return [[[ReachabilityManager sharedManager] reachability] isReachableViaWiFi];
}

- (id)init {
  self = [super init];
  if (self) {
    self.reachability = [Reachability reachabilityWithHostname:@"www.google.com"];
    [self.reachability startNotifier];
  }
  return self;
}

@end
