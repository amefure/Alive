//
//  Live.swift
//  Alive
//
//  Created by t&a on 2023/11/20.
//

import RealmSwift

class Live2 {
    var date = Date()
}

class Live: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var artist: String = ""           // アーティスト
    @Persisted var name: String = "未登録"             // ライブ名
    @Persisted var date = Date()                 // 開催日
    @Persisted var openingTime: Date? = nil      // 開場
    @Persisted var performanceTime: Date? = nil  // 開演
    @Persisted var closingTime: Date? = nil      // 終演
    @Persisted var venue: String = ""            // 開催地(箱)
    @Persisted var price: Int = -1               // 料金
    @Persisted var type: LiveType = .unknown     // ライブ種類
    @Persisted var memo: String = ""             // メモ
    @Persisted var imagePath: String = ""      // 画像
    
    // Live後に追加できる項目
    // セトリ
    @Persisted var setList: String = "1.\n2.\n3.\n4.\n5.\n6.\n7.\n"
    @Persisted var timeTable: List<TimeTable>  // タイムテーブル
    
    

    static var demoLive: Live {
        let live = Live()
        live.artist = "吉田　真紘"
        live.name = "ぐるぐるツアー"
        live.date = Date()
        live.openingTime = Date()
        live.performanceTime = Date()
        live.closingTime = Date()
        live.venue = "Tokyo Studio"
        live.price = 2500
        live.type = .oneman
        live.memo = "グッズの販売は10時\n依ちゃんと一緒に集合"
        live.setList = "1.AAAAAAA\n2.AAAAAAA\n3.AAAAAAA\n4.AAAAAAA\n5.AAAAAAA\n6.AAAAAAA\n7.AAAAAAA\n"
        return live
    }
    
    
    static var blankLive: Live {
        let live = Live()
        live.artist = "ALIVE"
        live.name = "次のライブの予定はありません"
        live.date = Date()
        live.venue = "ー"
        live.type = .oneman
        return live
    }
}
