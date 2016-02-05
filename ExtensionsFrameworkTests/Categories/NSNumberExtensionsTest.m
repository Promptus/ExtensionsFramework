//
//  NSNumberExtensionsTest.m
//  ExtensionsFramework
//
//  Created by Razvan Benga on 05/02/16.
//  Copyright © 2016 Razvan Benga. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSNumber+Extensions.h"

@interface NSNumberExtensionsTest : XCTestCase

@end

@implementation NSNumberExtensionsTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDecimalConversionFromIntegerValue {
    NSDecimalNumber *number1 = [@2345 ce_buildDecimaValueFromIntegerWithNumberOfDecimals:2];
    NSDecimalNumber *number2 = [@23 ce_buildDecimaValueFromIntegerWithNumberOfDecimals:2];
    
    XCTAssertTrue([number1 isEqualToNumber:[NSDecimalNumber decimalNumberWithString:@"23.45"]]);
    XCTAssertTrue([number2 isEqualToNumber:[NSDecimalNumber decimalNumberWithString:@"0.23"]]);
}

@end
