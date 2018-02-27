//
//  Date-Formatter.swift
//  MSSNGR
//
//  Created by Alexandra Ionasc on 11/10/16.
//  Copyright © 2016 Promptus. All rights reserved.
//

import Foundation

public enum ISO8601Type: String {
  case year					= "yyyy"
  case yearMonth				= "yyyy-MM"
  case date					= "yyyy-MM-dd"
  case hourMinute             = "HH:mm"
  case time                   = "HH:mm:ss"
  case dateTime				= "yyyy-MM-dd'T'HH:mmZZZZZ"
  case full					= "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
  case extended				= "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
}

public struct DateFormat {
  public static let Default = "yyyy-MM-dd'T'HH:mm:ss"
  public static let DateTimeShort = "ddMMYYHH:mm"
  public static let TimeShort = "jj:mm"
  public static let DayMonth = "EEEEdMMMM"
  public static let LongDateTimeFormat = "EEEdMMMM jj:mm"
  public static let Date = "EEEEdMMMMYYYY"
  public static let DateShort = "EEEdMM"
}

public extension Date {
  
  public static func parseISO8601String(_ isoStringDate: Any?, isoType: ISO8601Type = .full) -> Date?  {
    guard let isoString = isoStringDate as? String else { return nil }
    let formatter = CustomDateFormatter.formatter
    formatter.dateFormat = isoType.rawValue
    formatter.calendar = CustomDateFormatter.gregorianCalendar
    return formatter.date(from: isoString)
  }
  
  public func toISO8601String(isoType iso8601type: ISO8601Type = .full) -> String? {
    return toString(format: iso8601type.rawValue)
  }
  
  public func toString(format dateFormat: String, calendar: Calendar = Calendar.current) -> String? {
    let dateFormatter = CustomDateFormatter.formatter
    dateFormatter.dateFormat = dateFormat
    dateFormatter.timeZone = NSTimeZone.default
    dateFormatter.calendar = calendar
    return dateFormatter.string(from: self)
  }
  
  public func toString(template templateFormat: String, locale: Locale = Locale.current, calendar: Calendar = Calendar.current) -> String? {
    let dateFormatter = CustomDateFormatter.createDateFormatterFromTemplate(templateFormat, locale: locale)
    dateFormatter.timeZone = NSTimeZone.default
    dateFormatter.locale = locale
    dateFormatter.calendar = calendar
    return dateFormatter.string(from: self)
  }
  
}

public class CustomDateFormatter {
  
  public static var gregorianCalendar: Calendar = {
    return Calendar(identifier: .gregorian)
  }()
  
  public static var formatter: Foundation.DateFormatter = {
    let formatter = Foundation.DateFormatter()
    return formatter
  }()
  
  public static func createDateFormatterFromTemplate(_ dateTemplateFormat: String = DateFormat.Default, locale: Locale? = Locale.current) -> Foundation.DateFormatter {
    let templateFromat = Foundation.DateFormatter.dateFormat(fromTemplate: dateTemplateFormat, options: 0, locale: locale)
    formatter.dateFormat = templateFromat ?? dateTemplateFormat
    return formatter
  }
}

