//
//  Date-Utility.swift
//  MSSNGR
//
//  Created by Alexandra Ionasc on 11/10/16.
//  Copyright © 2016 Promptus. All rights reserved.
//

import Foundation

// MARK: - Date components
extension Date {
  
  /// Set to loop throuhg all `Calendar.Component` values
  ///
  internal static let componentFlagSet: Set<Calendar.Component> = [.nanosecond, .second, .minute, .hour,
                                                                   .day, .month, .year, .yearForWeekOfYear, .weekOfYear, .weekday, .quarter, .weekdayOrdinal,
                                                                   .weekOfMonth]

  /// Returns the value for an NSDateComponents object.
  /// Values returned are in the context of the calendar and time zone properties.
  ///
  /// - Parameters:
  ///     - component: specifies the calendrical unit that should be returned
  /// - Returns: The value of the NSDateComponents object for the date.
  /// - remark: asserts that no calendar or time zone flags are specified.
  ///   If one of these is present, an assertion fails and execution will halt.
  ///
  internal func value(for component: Calendar.Component) -> Int {
    assert(component != .calendar)
    assert(component != .timeZone)
    
    let value = Calendar.current.component(component, from: self)
    return value
  }
  
  /// Nearest rounded hour from the date
  public var nearestHour: Int {
    let date = self + 30.minutes
    return Int(date.hour)
  }
  
  // MARK: - NSCalendar & NSDateComponent ports
  public var minute: Int {
    return value(for: .minute)
  }
  
  public var second: Int {
    return value(for: .second)
  }
  
  public var nanosecond: Int {
    return value(for: .nanosecond)
  }
  
  public var hour: Int {
    return value(for: .hour)
  }
  
  public var year: Int {
    return value(for: .year)
  }
  
  public var month: Int {
    return value(for: .month)
  }
  
  public var day: Int {
    return value(for: .day)
  }

  // MARK: - Operators
  public func add(_ components: DateComponents) -> Date {
    return Calendar.current.date(byAdding: components, to: self)!
  }
  
}

// MARK: - Helpers to enable expressions e.g. date + 1.days - 20.seconds

public func + (lhs: Date, rhs: DateComponents) -> Date {
  return lhs.add(rhs)
}

public func - (lhs: Date, rhs: DateComponents) -> Date {
  return lhs + (-rhs)
}

/// Returns a new NSDateComponents object representing the negative values of components that are
/// submitted
///
/// - Parameters:
///     - dateComponents: the components to process
///
/// - Returns: A new NSDateComponents object representing the negative values of components that
///     are submitted
///
public prefix func - (dateComponents: DateComponents) -> DateComponents {
  var result = DateComponents()
  for component in Date.componentFlagSet {
    if let value = dateComponents.value(for: component) {
      if value != DateComponents.undefined {
        result.setValue(-value, for: component)
      }
    }
  }
  return result
}

extension DateComponents {
  
  static var undefined: Int {
    return Int.max
  }
  
}

extension Int {
  
  public var nanoseconds: DateComponents {
    return DateComponents(nanosecond: self)
  }

  public var seconds: DateComponents {
    return DateComponents(second: self)
  }
  
  public var minutes: DateComponents {
    return DateComponents(minute: self)
  }
  
  public var hours: DateComponents {
    return DateComponents(hour: self)
  }
  
  public var days: DateComponents {
    return DateComponents(day: self)
  }
  
  public var weeks: DateComponents {
    return DateComponents(weekOfYear: self)
  }
  
  public var months: DateComponents {
    return DateComponents(month: self)
  }
  
  public var years: DateComponents {
    return DateComponents(year: self)
  }
}

