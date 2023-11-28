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
    
    /// yyyy年M月d日(今日)
    public func getNowTime() -> String {
        df.dateFormat = L10n.dateFormat
        return df.string(from: Date())
    }
    
    /// yyyy年\nM月d日
    public func getStringBlake(date: Date) -> String {
        df.dateFormat = L10n.dateFormatBlake
        return df.string(from: date)
    }
    
    /// yyyy年M月d日
    public func getString(date: Date) -> String {
        df.dateFormat = L10n.dateFormat
        return df.string(from: date)
    }
    
    /// yyyy/M/d/
    public func getStringSlash(date: Date) -> String {
        df.dateFormat = "YYYY/M/d"
        return df.string(from: date)
    }
    
    /// yyyy年M月d日 Date
    public func getDate(str: String) -> Date {
        df.dateFormat = L10n.dateFormat
        return df.date(from: str) ?? Date()
    }
    
    /// YYYY
    public func getYearString(date: Date) -> String {
        df.dateFormat = "YYYY"
        return df.string(from: date)
    }
    
    /// "HH:mm"
    public func getTimeString(date: Date) -> String {
        df.dateFormat = "HH:mm"
        return df.string(from: date)
    }
    
    /// "M/dd"
    public func getShortString(date: Date) -> String {
        df.dateFormat = "M/d"
        return df.string(from: date)
    }
    
    /// ("M","d")
    public func getMouthAndDayString(date: Date) -> (String, String) {
        df.dateFormat = "M"
        let month = df.string(from: date)
        df.dateFormat = "d"
        let day = df.string(from: date)
        return (month, day)
    }
    
    /// "EE"
    public func getDayOfWeekString(date: Date) -> String {
        df.dateFormat = "EE"
        return df.string(from: date)
    }
    
    /// "HH:mm" Date
    public func getDate(hour: Int, minute: Int) -> Date {
        let time = "\(hour):\(minute)"
        df.dateFormat = "HH:mm"
        return df.date(from: time) ?? Date()
    }

}
