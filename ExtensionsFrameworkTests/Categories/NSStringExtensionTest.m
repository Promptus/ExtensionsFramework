//
//  NSStringExtensionTest.m
//  CocoaExtensions
//
//  Created by Lars Kuhnt on 04.11.13.
//  Copyright (c) 2013 Promptus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+Extensions.h"
#import "XCTAssertMacroExtension.h"

@interface NSStringExtensionTest : XCTestCase

@end

@implementation NSStringExtensionTest

- (void)setUp {
  [super setUp];
}

- (void)tearDown {
  [super tearDown];
}

#pragma mark match

- (void)testMatchSimpleString {
  NSArray * matches = [@"This is a test string" ce_match:@"test"];
  XCTAssertEqualStrings([matches objectAtIndex:0], @"test");
}

- (void)testMatchWithMatchGroups {
  NSArray * matches = [@"This is a test string" ce_match:@"is (.).*st(\\w+)"];
  XCTAssertEqualStrings([matches objectAtIndex:0], @"is is a test string");
  XCTAssertEqualStrings([matches objectAtIndex:1], @"i");
  XCTAssertEqualStrings([matches objectAtIndex:2], @"ring");
}

#pragma mark scan

- (void)testScanSimpleString {
  NSArray * matches = [@"12 dsf45 safd 24325" ce_scan:@"(\\d+)"];
  XCTAssertEqualStrings([matches objectAtIndex:0], @"12");
  XCTAssertEqualStrings([matches objectAtIndex:1], @"45");
  XCTAssertEqualStrings([matches objectAtIndex:2], @"24325");
}

- (void)testTruncateEmptyStrings {
    NSString *truncatedString = [@" , , test string" ce_truncateEmptyStringComponentsSeparatedByCharacter:@", "];
    NSString *expectedString = @"test string";
    XCTAssertEqualStrings(truncatedString, expectedString);
}

@end
