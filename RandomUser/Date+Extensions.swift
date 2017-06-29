//
//  Date+Extensions.swift
//  RandomUser
//
//  Created by Antonio Calvo on 29/06/2017.
//  Copyright © 2017 Antonio Calvo. All rights reserved.
//

import Foundation

extension Date {
  var calendar: Calendar {
    return Calendar(identifier: .gregorian)
  }
  
  func after(value: Int, calendarComponent: Calendar.Component) -> Date{
    return calendar.date(byAdding: calendarComponent, value: value, to: self)!
  }
  
  func minus(date: Date) -> DateComponents{
    return calendar.dateComponents([.minute], from: self, to: date)
  }
  
  func equalsTo(date: Date) -> Bool {
    return self.compare(date) == .orderedSame
  }
  
  func greaterThan(date: Date) -> Bool {
    return self.compare(date) == .orderedDescending
  }
  
  func lessThan(date: Date) -> Bool {
    return self.compare(date) == .orderedAscending
  }
  
  static func parse(_ dateString: String, format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.date(from: dateString)
  }
  
  func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.string(from: self)
  }
}
