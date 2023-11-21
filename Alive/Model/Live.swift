//
//  Live.swift
//  Alive
//
//  Created by t&a on 2023/11/20.
//

import RealmSwift

class Live: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var artist: String = ""         // アーティスト
    @Persisted var date: Date = Date()         // 開催日
    @Persisted var venue: String = ""          // 開催地(箱)
    @Persisted var price: Int = 0              // 料金
    @Persisted var type: LiveType = .unknown   // ライブ種類
    @Persisted var memo: String = ""           // メモ
    
    // Live後に追加できる項目
    @Persisted var setList: String = ""        // セトリ
    @Persisted var timeTable: List<TimeTable>  // タイムテーブル
    @Persisted var memory: String = ""         // 感想
    @Persisted var imagePath: String = ""      // 画像
    

    static var demoLive: Live {
        let live = Live()
        live.artist = "吉田　真紘"
        live.date = Date()
        live.venue = "Tokyo Studio"
        live.price = 2500
        live.type = .oneman
        live.memo = "これはメモです"
        return live
    }
}
