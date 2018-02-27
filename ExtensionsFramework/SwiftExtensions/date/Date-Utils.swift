//
//  NSDate-Extension.swift
//  MSSNGR
//
//  Created by Alexandra Ionasc on 02/03/16.
//  Copyright © 2016 Promptus. All rights reserved.
//

import Foundation

//MARK: Date utilities methods
public extension Date {
  
  public init(date fromDate: Date, year: Int? = nil,
              month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil,
              nanosecond: Int? = nil, calendar: Calendar? = nil) {
    
    let newComponents = DateComponents(
      year: year ?? fromDate.year,
      month: month ?? fromDate.month,
      day: day ?? fromDate.day,
      hour: hour ?? fromDate.hour,
      minute: minute ?? fromDate.minute,
      second: second ?? fromDate.second,
      nanosecond: nanosecond ?? fromDate.nanosecond)
    
    let newCalendar = calendar ?? Calendar.current
    let newDate = newCalendar.date(from: newComponents) ?? Date()
    
    self.init(timeIntervalSinceReferenceDate: newDate.timeIntervalSinceReferenceDate)
  }
  
  public func nearestDateWithMinuteInterval(_ minuteInterval: Int) -> Date {
    let nextTimeSlotRatio = ceil(Float(minute) / Float(minuteInterval))
    let nextMinute = (Int(nextTimeSlotRatio) * minuteInterval) % 60
    
    return Date(date: self, hour:nearestHour, minute: nextMinute, second: 0, nanosecond: 0)
  }
  
  public func isBetweeen(date date1: Date, andDate date2: Date) -> Bool {
    return date1.compare(self).rawValue * self.compare(date2).rawValue >= 0
  }
  
  public func startOfDay(calendar: Calendar = Calendar.current) -> Date {
    return calendar.startOfDay(for: self)
  }
  
  public func endOfDay(calendar: Calendar = Calendar.current) -> Date {
    let startOfDayDate = startOfDay()
    var components = DateComponents()
    components.day = 1
    components.second = -1
    return calendar.date(byAdding: components, to: startOfDayDate) ?? (startOfDayDate + 23.hours)
  }
  
}




