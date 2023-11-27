//
//  TimeTable.swift
//  Alive
//
//  Created by t&a on 2023/11/21.
//

import SwiftUI
import RealmSwift

class TimeTable: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var time: Date = Date()              // 演奏時間
    @Persisted var artist: String = ""              // アーティスト
    @Persisted var memo: String = ""                // MEMO
    @Persisted var color: TimeTableColor = .yellow  // カラー
    
    
    static var demoTimeTables: Array<TimeTable> {
        var timeTables: [TimeTable] = []
        let df = DateFormatManager()
        
        var timeTable = TimeTable()
        timeTable.artist = "SPYAIR"
        timeTable.time = df.getDate(hour: 11, minute: 5)
        timeTable.color = .red
        timeTables.append(timeTable)
        
        var timeTable2 = TimeTable()
        timeTable2.artist = "四星球"
        timeTable2.time = df.getDate(hour: 11, minute: 35)
        timeTable.color = .blue
        timeTables.append(timeTable2)
        
        var timeTable3 = TimeTable()
        timeTable3.artist = "04 Limited Sazabys"
        timeTable3.time = df.getDate(hour: 13, minute: 15)
        timeTable.color = .red
        timeTables.append(timeTable3)
        
        var timeTable4 = TimeTable()
        timeTable4.artist = "Crossfaith"
        timeTable4.time = df.getDate(hour: 12, minute: 40)
        timeTable.color = .blue
        timeTables.append(timeTable4)
        
        var timeTable5 = TimeTable()
        timeTable5.artist = "coldrain"
        timeTable5.time = df.getDate(hour: 14, minute: 20)
        timeTable.color = .red
        timeTables.append(timeTable5)
        
        var timeTable6 = TimeTable()
        timeTable6.artist = "sumika"
        timeTable6.time = df.getDate(hour: 16, minute: 30)
        timeTable.color = .red
        timeTables.append(timeTable6)
        
        var timeTable7 = TimeTable()
        timeTable7.artist = "THE BACK BORN"
        timeTable7.time = df.getDate(hour: 15, minute: 55)
        timeTable.color = .blue
        timeTables.append(timeTable7)
        
        return timeTables
    }
}


enum TimeTableColor: String, PersistableEnum, Identifiable, CaseIterable {
    var id:String{self.rawValue}
    
    case red
    case yellow
    case green
    case blue
    case purple
    
    public var color: Color {
        switch self {
        case .red:
            return .themaRed
        case .yellow:
            return .themaYellow
        case .green:
            return .themaGreen
        case .blue:
            return .themaBlue
        case .purple:
            return .themaPurple
        }
    }
}
