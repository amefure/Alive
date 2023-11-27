//
//  DateFormatManager.swift
//  Alive
//
//  Created by t&a on 2023/11/20.
//

import UIKit

class DateFormatManager {

    private let df = DateFormatter()

    init() {
        df.dateFormat = L10n.dateFormat
        df.locale = Locale(identifier: L10n.dateLocale)
        df.calendar = Calendar(identifier: .gregorian)
    }
    
    public func getNowTime() -> String {
        df.dateFormat = L10n.dateFormat
        return df.string(from: Date())
    }
    
    public func getStringBlake(date: Date) -> String {
        df.dateFormat = L10n.dateFormatBlake
        return df.string(from: date)
    }
    
    public func getString(date: Date) -> String {
        df.dateFormat = L10n.dateFormat
        return df.string(from: date)
    }
    
    public func getDate(str: String) -> Date {
        df.dateFormat = L10n.dateFormat
        return df.date(from: str) ?? Date()
    }
    
    public func getYearString(date: Date) -> String {
        df.dateFormat = "YYYY"
        return df.string(from: date)
    }
    
    public func getTimeString(date: Date) -> String {
        df.dateFormat = "HH:mm"
        return df.string(from: date)
    }
    
    public func getShortString(date: Date) -> String {
        df.dateFormat = "M/dd"
        return df.string(from: date)
    }
    
    public func getMouthAndDayString(date: Date) -> (String, String) {
        df.dateFormat = "M"
        let month = df.string(from: date)
        df.dateFormat = "d"
        let day = df.string(from: date)
        return (month, day)
    }
    
    public func getDayOfWeekString(date: Date) -> String {
        df.dateFormat = "EE"
        return df.string(from: date)
    }
    
    public func getDate(hour: Int, minute: Int) -> Date {
        let time = "\(hour):\(minute)"
        df.dateFormat = "HH:mm"
        return df.date(from: time) ?? Date()
    }

}
