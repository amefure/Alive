//
//  TimeTable.swift
//  Alive
//
//  Created by t&a on 2023/11/21.
//

import UIKit
import RealmSwift

class TimeTable: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var time: Date = Date()         // 演奏時間
    @Persisted var artist: String = ""         // アーティスト
    @Persisted var setList: String = ""        // セトリ
}
