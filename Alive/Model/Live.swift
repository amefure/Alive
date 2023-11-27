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
    
    
    static var demoLives: [Live] {
        var lives: [Live] = []
        let df = DateFormatManager()
        
        let live = Live()
        live.artist = "ONE OK ROCK"
        live.name = "VS"
        live.date = df.getDate(str: "2023年11月14日")
        live.venue = "東京ドーム"
        live.type = .battleBands
        live.price = 12000
        live.openingTime = df.getDate(hour: 16, minute: 0)
        live.performanceTime = df.getDate(hour: 18, minute: 0)
        live.memo = "MY FIRST STORY"
        live.setList = """
        —-ONE OK ROCK —-

        1. The Beginning
        2. Never Let This Go
        3. Nothing Helps
        4. Make It Out Alive
        5. C.h.a.o.s.m.y.t.h.
        6. Wherever you are
        7. Renegade
        8. Deeper Deeper
        9. Right By Your Side
        10. 未完成交響曲
        11. We are
        12. 完全感覚Dreamer
        13. キミシダイ列車

        —-MY FIRST STORY —-

        1. 最終回STORY
        2. ALONE
        3. メリーゴーランド
        4. 君のいない夜を越えて
        5. アンダーグラウンド
        6. 東京ミッドナイト
        7. PARADOX
        8. 虚言NEUROSE
        9. ACCIDENT
        10. I’M A MESS
        11. MONSTER
        12. モノクロエフェクター
        13. REVIVER
        14. 不可逆リプレイス
        15. Home
        """
                
        lives.append(live)
        
        let live2 = Live()
        live2.artist = "Saucy Dog"
        live2.name = "ARENA TOUR 2023"
        live2.date = df.getDate(str: "2023年12月5日")
        live2.venue = "大阪城ホール"
        live2.type = .oneman
        
        lives.append(live2)
        
        let live3 = Live()
        live3.artist = "YOASOBI"
        live3.name = "[YOASOBI ZEPP TOUR 2024 \"POP OUT\"]"
        live3.date = df.getDate(str: "2024年1月25日")
        live3.venue = "Zepp Haneda"
        live3.type = .oneman
        live3.openingTime = df.getDate(hour: 18, minute: 0)
        live3.performanceTime = df.getDate(hour: 19, minute: 0)
        
        lives.append(live3)
        
        let live4 = Live()
        live4.artist = "YOASOBI"
        live4.name = "NEX_FEST -Extra-"
        live4.date = df.getDate(str: "2023年11月4日")
        live4.venue = "幕張メッセ"
        live4.type = .festival

//        let list = RealmSwift.List<TimeTable>()
//        list.append(objectsIn: TimeTable.demoTimeTables)
//        live4.timeTable = list
        
        lives.append(live4)
        
        let live5 = Live()
        live5.artist = "あいみょん"
        live5.name = "AIMYON TOUR 2023 - マジカル・バスルーム- "
        live5.date = df.getDate(str: "2023年11月2日")
        live5.venue = "和歌山県民文化会館大ホール"
        live5.type = .festival
        
        lives.append(live5)
        
        let live6 = Live()
        live6.artist = "マカロニえんぴつ"
        live6.name = "FM802 ROCK FESTIVAL RADIO CRAZY 2023"
        live6.date = df.getDate(str: "2023年12月27日")
        live6.venue = "インテックス大阪"
        live6.type = .festival
        live6.memo = """
TREASURE05X 2023 20th Anniersary -NEW PROMISED LAND
チケット：アプリ「FOLK-S」
"""

        lives.append(live6)
        
        let live7 = Live()
        live7.artist = "yama"
        live7.name = "yama Christmas Special Live 2023"
        live7.date = df.getDate(str: "2023年11月26日")
        live7.venue = "新川文化ホール"
        live7.type = .oneman
        
        lives.append(live7)
        

        
        
        return lives
    }
}
