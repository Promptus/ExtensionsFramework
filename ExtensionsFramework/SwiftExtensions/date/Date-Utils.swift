//
//  NSDate-Extension.swift
//  MSSNGR
//
//  Created by Alexandra Ionasc on 02/03/16.
//  Copyright © 2016 Promptus. All rights reserved.
//

import Foundation

//MARK: Date utilities methods
extension Date {
  
  public init(date fromDate: Date, year: Int? = nil,
              month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil,
              nanosecond: Int? = nil) {
    
    let newComponents = DateComponents(
      year: year ?? fromDate.year,
      month: month ?? fromDate.month,
      day: day ?? fromDate.day,
      hour: hour ?? fromDate.hour,
      minute: minute ?? fromDate.minute,
      second: second ?? fromDate.second,
      nanosecond: nanosecond ?? fromDate.nanosecond)
    
    self.init(timeIntervalSinceReferenceDate: (Calendar.current.date(from: newComponents)?.timeIntervalSinceReferenceDate)!)
  }
  
  func nearestDateWithMinuteInterval(_ minuteInterval: Int) -> Date {
    let nextTimeSlotRatio = ceil(Float(self.minute) / Float(minuteInterval))
    let nextMinute = (Int(nextTimeSlotRatio) * minuteInterval) % 60
    
    return Date(date: self, hour:self.nearestHour, minute: nextMinute, second: 0, nanosecond: 0)
  }
  
  func isBetweeen(date date1: Date, andDate date2: Date) -> Bool {
    return date1.compare(self).rawValue * self.compare(date2).rawValue >= 0
  }
  
}




