//
//  NSArrayExtensionsTest.m
//  CocoaExtensions
//
//  Created by Lars Kuhnt on 31.10.13.
//  Copyright (c) 2013 Promptus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+Extensions.h"

@interface NSArrayExtensionsTest : XCTestCase {
  NSArray * sample;
}


@end

@implementation NSArrayExtensionsTest

- (void)setUp {
  [super setUp];
  sample = @[@1, @2, @3, @4];
}

- (void)tearDown {
  [super tearDown];
}

#pragma mark map

- (void)testMap {
  NSArray * result = [sample ce_map:^(NSNumber *item) {
    return [item stringValue];
  }];
  XCTAssertTrue([[result objectAtIndex:0] isEqualToString:@"1"], @"");
  XCTAssertTrue([[result objectAtIndex:1] isEqualToString:@"2"], @"");
}

- (void)testSelect {
  NSArray * result = [sample ce_select:^(NSNumber *item) {
    return (BOOL) ([item intValue] == 1);
  }];
  XCTAssertTrue(result.count == (NSUInteger)1, @"");
  XCTAssertTrue([[result objectAtIndex:0] intValue] == 1, @"");
}

- (void)testReject {
  NSArray * result = [sample ce_reject:^(NSNumber *item) {
    return (BOOL) ([item intValue] % 2 == 0);
  }];
  XCTAssertTrue(result.count == (NSUInteger)2, @"");
  XCTAssertTrue([[result objectAtIndex:0] intValue] == 1, @"");
  XCTAssertTrue([[result objectAtIndex:1] intValue] == 3, @"");
}

@end
