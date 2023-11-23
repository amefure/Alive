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
