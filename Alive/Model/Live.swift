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
    @Persisted var memo: String = ""           // メモ
    

    static var demoLive: Live {
        let live = Live()
        live.artist = "吉田　真紘"
        live.date = Date()
        live.venue = "Tokyo Studio"
        live.price = 2500
        live.memo = "これはメモです"

        return live
    }
}