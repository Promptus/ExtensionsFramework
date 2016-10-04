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

- (void)testDateFromString {
  NSDate *dateString = [@"2016-03-08T12:47:34+01:00" ce_dateFromStringWithDestinationFormat:@"dd-MM-yyyy"];
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
  formatter.dateFormat = @"dd-MM-yyyy";
  NSDate *expectedDate = [formatter dateFromString:@"08-03-2016"];
  
  XCTAssertEqualObjects(dateString, expectedDate);
}

- (void)testNSURLFromEncodedString {
  
  // url with spaces
  NSString *spacesStringUrl = [@"https://test url " ce_urlStringUsingEncoding:NSUTF8StringEncoding];
  XCTAssertNotNil([NSURL URLWithString:spacesStringUrl], @"Empty space should be encoded");
  
  // url with special characters
  NSString *specialCharsStringUrl = [@"https://ätßen_[1]" ce_urlStringUsingEncoding:NSUTF8StringEncoding];
  XCTAssertNotNil([NSURL URLWithString:specialCharsStringUrl], @"Special chars should be encoded");
  
  // url with hash char
  NSString *hashCharAllowedStringUrl = @"http://test.com/html#![]";
  NSString *hashCharAllowedStringUrlEncoded = [hashCharAllowedStringUrl ce_urlStringUsingEncoding:NSUTF8StringEncoding];
  XCTAssertEqualStrings(hashCharAllowedStringUrl, hashCharAllowedStringUrlEncoded);
  XCTAssertNotNil([NSURL URLWithString:hashCharAllowedStringUrlEncoded], @"Hash sign should not be encoded");
  
  // url without scheme defined
  NSString *urlWithoutScheme = [@"domain.com" ce_urlStringUsingEncoding:NSUTF8StringEncoding];
  XCTAssertNotNil([NSURL URLWithString:urlWithoutScheme], @"NSURL without a scheme");
}

@end
