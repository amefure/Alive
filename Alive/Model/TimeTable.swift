//
//  TimeTable.swift
//  Alive
//
//  Created by t&a on 2023/11/21.
//

import SwiftUI
import RealmSwift

class TimeTable: Object, ObjectKeyIdentifiable, Codable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var time: Date = Date()              // 演奏時間
    @Persisted var artist: String = ""              // アーティスト
    @Persisted var memo: String = ""                // MEMO
    @Persisted var color: TimeTableColor = .yellow  // カラー
    
    enum CodingKeys: String, CodingKey {
        case id, time, artist, memo, color
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(ObjectId.self, forKey: .id)
        time = try container.decode(Date.self, forKey: .time)
        artist = try container.decode(String.self, forKey: .artist)
        memo = try container.decode(String.self, forKey: .memo)
        color = try container.decode(TimeTableColor.self, forKey: .color)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(time, forKey: .time)
        try container.encode(artist, forKey: .artist)
        try container.encode(memo, forKey: .memo)
        try container.encode(color, forKey: .color)
    }
}

// MARK: DemoData
extension TimeTable {
    
    // DetailLiveViewに直接渡す
    static var demoTimeTables: Array<TimeTable> {
        var timeTables: [TimeTable] = []
        let df = DateFormatManager()
        
        let timeTable = TimeTable()
        timeTable.artist = "SPYAIR"
        timeTable.time = df.getDate(hour: 11, minute: 5)
        timeTable.color = .red
        timeTables.append(timeTable)
        
        let timeTable2 = TimeTable()
        timeTable2.artist = "四星球"
        timeTable2.time = df.getDate(hour: 11, minute: 35)
        timeTable2.color = .yellow
        timeTables.append(timeTable2)
        
        let timeTable3 = TimeTable()
        timeTable3.artist = "04 Limited Sazabys"
        timeTable3.time = df.getDate(hour: 13, minute: 15)
        timeTable3.color = .red
        timeTables.append(timeTable3)
        
        let timeTable4 = TimeTable()
        timeTable4.artist = "Crossfaith"
        timeTable4.time = df.getDate(hour: 12, minute: 40)
        timeTable4.color = .purple
        timeTables.append(timeTable4)
        
        let timeTable5 = TimeTable()
        timeTable5.artist = "coldrain"
        timeTable5.time = df.getDate(hour: 14, minute: 20)
        timeTable5.color = .green
        timeTables.append(timeTable5)
        
        let timeTable6 = TimeTable()
        timeTable6.artist = "sumika"
        timeTable6.time = df.getDate(hour: 16, minute: 30)
        timeTable6.color = .red
        timeTables.append(timeTable6)
        
        let timeTable7 = TimeTable()
        timeTable7.artist = "THE BACK BORN"
        timeTable7.time = df.getDate(hour: 15, minute: 55)
        timeTable7.color = .blue
        timeTables.append(timeTable7)
        
        let timeTable8 = TimeTable()
        timeTable8.artist = "ROTTENGRAFFTY"
        timeTable8.time = df.getDate(hour: 17, minute: 10)
        timeTable8.color = .purple
        timeTables.append(timeTable8)
        
        let timeTable9 = TimeTable()
        timeTable9.artist = "MY FIRST STORY"
        timeTable9.time = df.getDate(hour: 17, minute: 50)
        timeTable9.color = .yellow
        timeTables.append(timeTable9)
        return timeTables
    }
    
    static var demoTimeTablesEn: Array<TimeTable> {
        var timeTables: [TimeTable] = []
        let df = DateFormatManager()
        
        let timeTable = TimeTable()
        timeTable.artist = "Avicii"
        timeTable.time = df.getDate(hour: 11, minute: 5)
        timeTable.color = .red
        timeTables.append(timeTable)
        
        let timeTable2 = TimeTable()
        timeTable2.artist = "Ariana Grande"
        timeTable2.time = df.getDate(hour: 11, minute: 35)
        timeTable2.color = .yellow
        timeTables.append(timeTable2)
        
        let timeTable3 = TimeTable()
        timeTable3.artist = "Justin Bieber"
        timeTable3.time = df.getDate(hour: 13, minute: 15)
        timeTable3.color = .red
        timeTables.append(timeTable3)
        
        let timeTable4 = TimeTable()
        timeTable4.artist = "Ed Sheeran"
        timeTable4.time = df.getDate(hour: 12, minute: 40)
        timeTable4.color = .purple
        timeTables.append(timeTable4)
        
        let timeTable5 = TimeTable()
        timeTable5.artist = "Taylor Swift"
        timeTable5.time = df.getDate(hour: 14, minute: 20)
        timeTable5.color = .green
        timeTables.append(timeTable5)
        
        let timeTable6 = TimeTable()
        timeTable6.artist = "Bruno Mars"
        timeTable6.time = df.getDate(hour: 16, minute: 30)
        timeTable6.color = .red
        timeTables.append(timeTable6)
        
        let timeTable7 = TimeTable()
        timeTable7.artist = "THE BACK BORN"
        timeTable7.time = df.getDate(hour: 15, minute: 55)
        timeTable7.color = .blue
        timeTables.append(timeTable7)
        
        let timeTable8 = TimeTable()
        timeTable8.artist = "ONE OK ROCK"
        timeTable8.time = df.getDate(hour: 17, minute: 10)
        timeTable8.color = .purple
        timeTables.append(timeTable8)
        
        let timeTable9 = TimeTable()
        timeTable9.artist = "MY FIRST STORY"
        timeTable9.time = df.getDate(hour: 17, minute: 50)
        timeTable9.color = .yellow
        timeTables.append(timeTable9)
        return timeTables
    }
}

enum TimeTableColor: String, PersistableEnum, Identifiable, CaseIterable, Codable {
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
