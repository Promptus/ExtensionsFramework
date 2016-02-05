//
//  NSDecimalNumberExtensionsTest.m
//  ExtensionsFramework
//
//  Created by Razvan Benga on 05/02/16.
//  Copyright © 2016 Razvan Benga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDecimalNumber+Extensions.h"
#import "NSDictionary+Extensions.h"

@interface NSDecimalNumberExtensionsTest : XCTestCase

@end

@implementation NSDecimalNumberExtensionsTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIntegerConversionFromFullValue {
    NSDecimalNumber *testNumber = [NSDecimalNumber decimalNumberWithString:@"23.45"];
    NSDecimalNumber *testNumber2 = [NSDecimalNumber decimalNumberWithString:@"0.23"];

    XCTAssertTrue([testNumber ce_integerWithNumberOfDecimalValues:2] == 2345);
    XCTAssertTrue([testNumber2 ce_integerWithNumberOfDecimalValues:2] == 23);
}

@end
