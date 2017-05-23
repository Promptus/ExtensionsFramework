//
//  DateExtensionTests.swift
//  ExtensionsFramework
//
//  Created by Alexandra Ionasc on 23/05/2017.
//  Copyright © 2017 Razvan Benga. All rights reserved.
//

import XCTest

class DateExtensionTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    
    NSTimeZone.default = TimeZone(identifier: "UTC")!
  }
  
  func test_dateStartOfDay() {
    //given - create a new date for 2005-06-01 10:00:00 UTC
    let absDate = Date(timeIntervalSince1970: 1117620000)
    let absDateString = absDate.toString(format: DateFormat.Default) ?? ""
    
    //when
    let startOfDayDate = absDate.startOfDay()
    let startOfDateString = startOfDayDate.toString(format: DateFormat.Default) ?? ""
    
    //then
    XCTAssertEqual("2005-06-01T10:00:00", absDateString, "Dateformat is not valid")
    XCTAssertEqual("2005-06-01T00:00:00", startOfDateString, "Failed to create a valid start of day instance")
  }
  
  func test_dateEndOfDay() {
    //given - create a new date for 2005-06-01 10:00:00 UTC
    let absDate = Date(timeIntervalSince1970: 1117620000)
    let absDateString = absDate.toString(format: DateFormat.Default) ?? ""
    
    //when
    let endOfDayDate = absDate.endOfDay()
    let endOfDayDateString = endOfDayDate.toString(format: DateFormat.Default) ?? ""
    
    //then
    XCTAssertEqual("2005-06-01T10:00:00", absDateString, "Dateformat is not valid")
    XCTAssertEqual("2005-06-01T23:59:59", endOfDayDateString, "Failed to create a valid end of day instance")
  }
    
}
