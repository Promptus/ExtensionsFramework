//
//  NSDate-Compatibility.swift
//  MSSNGR
//
//  Created by Alexandra Ionasc on 11/10/16.
//  Copyright © 2016 Promptus. All rights reserved.
//

import Foundation
/* wrapper extension class created over NSDate object to be compatible with ObjC code, while swift Date cannot be exposed to objC*/
public extension NSDate {
  
  @objc public static func parseFullISO8601String(_ isoStringDate: Any?) -> NSDate? {
    return Date.parseISO8601String(isoStringDate) as NSDate?
  }
  
  @objc public func toString(template templateFormat: String) -> String? {
    let swiftDate = self as Date
    return swiftDate.toString(template: templateFormat)
  }
  
  @objc public func isBetweeen(date date1: NSDate, andDate date2: NSDate) -> Bool {
    return  (self as Date).isBetweeen(date: date1 as Date, andDate: date2 as Date)
  }
  
}
