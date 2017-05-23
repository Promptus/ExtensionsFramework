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
    
    NSTimeZone.default = TimeZone(identifier: "Europe/Berlin")!
  }
  
  func test_dateStartOfDay() {
    //given - create a new date for 2005-06-01T12:00:00+02:00 Europe/Berlin timezone
    let absDate = Date(timeIntervalSince1970: 1117620000)
    let absDateString = absDate.toISO8601String() ?? ""
    
    //when
    let startOfDayDate = absDate.startOfDay()
    let startOfDateString = startOfDayDate.toISO8601String() ?? ""
    
    //then
    XCTAssertEqual("2005-06-01T12:00:00+02:00", absDateString, "Dateformat is not valid")
    XCTAssertEqual("2005-06-01T00:00:00+02:00", startOfDateString, "Failed to create a valid start of day instance")
  }
  
  func test_dateEndOfDay() {
     //given - create a new date for 2005-06-01T12:00:00+02:00 Europe/Berlin timezone
    let absDate = Date(timeIntervalSince1970: 1117620000)
    let absDateString = absDate.toISO8601String() ?? ""
    
    //when
    let endOfDayDate = absDate.endOfDay()
    let endOfDayDateString = endOfDayDate.toISO8601String() ?? ""
    
    //then
    XCTAssertEqual("2005-06-01T12:00:00+02:00", absDateString, "Dateformat is not valid")
    XCTAssertEqual("2005-06-01T23:59:59+02:00", endOfDayDateString, "Failed to create a valid end of day instance")
  }
  
  func test_dateEndOfDay_timezone_dst_start_change() {
    //given - 26 March 2017, 02:00:00 clocks were turned forward 1 hour in Europe/Berlin
    let dstIsChangedAtHour = 2
    let beforeDSTHour = dstIsChangedAtHour - 1
    let dstHourAddition = 1

    let startOfToday = Date().startOfDay()
    let dstStartDate = Date(date: startOfToday, year: 2017, month: 3, day: 26, hour: dstIsChangedAtHour)
    let beforeDstStartDate = Date(date: startOfToday, year: 2017, month: 3, day: 26, hour:beforeDSTHour)
    
    //when
    let endOfDayDate = dstStartDate.endOfDay()
    let endOfDayDateString = endOfDayDate.toISO8601String() ?? ""
    
    let endOfDayBeforeDstDate = beforeDstStartDate.endOfDay()
    let endOfDayBeforeDstDateString = endOfDayBeforeDstDate.toISO8601String() ?? ""
    
    //then
    XCTAssertEqual(dstStartDate.hour, dstIsChangedAtHour + dstHourAddition, "DST should be applied")
    XCTAssertEqual(beforeDstStartDate.hour, beforeDSTHour, "Is before DST, should not have any change of hour than hour used in initialisation")
    XCTAssertEqual(endOfDayDateString, endOfDayBeforeDstDateString, "End of dates before/after dst changes should be the same")

  }
    
}
