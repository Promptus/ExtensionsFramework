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
  static let Default = "yyyy-MM-dd'T'HH:mm:ss"
  static let DateTimeShort = "ddMMYYHH:mm"
  static let TimeShort = "jj:mm"
  static let DayMonth = "EEEEdMMMM"
  static let LongDateTimeFormat = "EEEdMMMM jj:mm"
  static let Date = "EEEEdMMMMYYYY"
  static let DateShort = "EEEdMM"
}

public extension Date {
  
  public static func parseISO8601String(_ isoStringDate: Any?, isoType: ISO8601Type = .full) -> Date?  {
    guard let isoString = isoStringDate as? String else { return nil }
    let formatter = CustomDateFormatter.formatter
    formatter.dateFormat = isoType.rawValue
    return formatter.date(from: isoString)
  }
  
  func toISO8601String(isoType iso8601type: ISO8601Type = .full) -> String? {
    let dateFormatter = CustomDateFormatter.formatter
    dateFormatter.dateFormat = iso8601type.rawValue
    dateFormatter.timeZone = NSTimeZone.default
    return dateFormatter.string(from: self)
  }
  
  
  func toString(template templateFormat: String, locale: Locale = Locale.current) -> String? {
    let dateFormatter = CustomDateFormatter.createDateFormatterFromTemplate(templateFormat, locale: locale)
    dateFormatter.timeZone = NSTimeZone.default
    dateFormatter.locale = locale
    return dateFormatter.string(from: self)
  }
  
}

open class CustomDateFormatter {
  open static var formatter: Foundation.DateFormatter = {
    let formatter = Foundation.DateFormatter()
    return formatter
  }()
  
  open static func createDateFormatterFromTemplate(_ dateTemplateFormat: String = DateFormat.Default, locale: Locale? = Locale.current) -> Foundation.DateFormatter {
    let templateFromat = Foundation.DateFormatter.dateFormat(fromTemplate: dateTemplateFormat, options: 0, locale: locale)
    formatter.dateFormat = templateFromat ?? dateTemplateFormat
    return formatter
  }
}

