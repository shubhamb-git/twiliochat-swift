import UIKit

class DateTodayFormatter {
  func stringFromDate(date: NSDate?) -> String? {
    if date == nil {
      return nil
    }

    let messageDate = roundDateToDay(date!)
    let todayDate = roundDateToDay(NSDate())

    let formatter = NSDateFormatter()

    if messageDate == todayDate {
      formatter.dateFormat = "'Today' - hh:mma"
    }
    else {
      formatter.dateFormat = "MMM. dd - hh:mma"
    }

    return formatter.stringFromDate(date!)
  }

  func roundDateToDay(date: NSDate) -> NSDate {
    let calendar  = NSCalendar.currentCalendar()
    let flags: NSCalendarUnit = [.Day, .Month, .Year]
    let components = calendar.components(flags, fromDate: date)
    return calendar.dateFromComponents(components)!
  }
}

extension NSDate {
  static func dateWithISO8601String(var dateString: String) -> NSDate? {
    if dateString.hasSuffix("Z") {
      let lastIndex = dateString.characters.indices.last!.predecessor()
      dateString = dateString.substringToIndex(lastIndex) + "-000"
    }
    return dateFromString(dateString, withFormat:"yyyy-MM-dd'T'HH:mm:ss.SSSZ")
  }

  static func dateFromString(str: String, withFormat dateFormat: String) -> NSDate? {
    let formatter = NSDateFormatter()
    formatter.dateFormat = dateFormat
    formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    return formatter.dateFromString(str)
  }
}