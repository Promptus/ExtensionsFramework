//
//  ApplicationHelper.m
//  CocoaExtensions
//
//  Created by Lars Kuhnt on 05.02.14.
//  Copyright (c) 2014 Promptus. All rights reserved.
//

#import "ApplicationHelper.h"

@implementation ApplicationHelper

@synthesize reachability;

- (void)dealloc {
  if (reachability)
    [reachability stopNotifier];
}

# pragma mark Filesystem helpers

+ (NSURL *)documentsDirectory {
  return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (uint64_t)freeDiscSpace {
  uint64_t totalSpace = 0;
  uint64_t totalFreeSpace = 0;
  
  __autoreleasing NSError *error = nil;
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
  
  if (dictionary) {
    NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
    NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
    totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
    totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
  }
  
  return totalFreeSpace;
}

+ (BOOL)freeDiscSpaceFallsShortOf:(NSUInteger)megaBytes {
  uint64_t bytes = megaBytes * 1024ll * 1024ll;
  NSLog(@"%llu / %llu", bytes, [ApplicationHelper freeDiscSpace]);
  return [ApplicationHelper freeDiscSpace] < bytes;
}

# pragma mark Translation helpers

+ (NSString *)t:(NSString *)key {
  return NSLocalizedString(key, @"");
}

# pragma mark Reachability helpers

- (void)setupReachability:(NSString*)host {
  if (reachability == nil) {
    reachability = [Reachability reachabilityWithHostname:host];
    [reachability startNotifier];
  }
}

- (Reachability*)reachability {
  return reachability;
}

- (BOOL)isReachable {
  return [self.reachability isReachable];
}

- (BOOL)isUnreachable {
  return ![self.reachability isReachable];
}

- (BOOL)isReachableViaWWAN {
  return [self.reachability isReachableViaWWAN];
}

- (BOOL)isReachableViaWiFi {
  return [self.reachability isReachableViaWiFi];
}

@end
