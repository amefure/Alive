//
//  DateFormatManager.swift
//  Alive
//
//  Created by t&a on 2023/11/20.
//

import UIKit

class DateFormatManager {

    public let df = DateFormatter()
    public let today = Date()

    init() {
        df.dateFormat = L10n.dateFormat
        df.locale = Locale(identifier: L10n.dateLocale)
        df.calendar = Calendar(identifier: .gregorian)
    }
    
    public func getString(date: Date) -> String {
        return df.string(from: date)
    }
    
    public func getShortString(date: Date) -> String {
        df.dateFormat = "MM/dd"
        return df.string(from: date)
    }
    
    public func getDayOfWeekString(date: Date) -> String {
        df.dateFormat = "EE"
        return df.string(from: date)
    }

}
