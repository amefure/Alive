//
//  RealmRepository.swift
//  AliveWatch Watch App
//
//  Created by t&a on 2023/12/08.
//

import WatchKit
import RealmSwift

class RealmRepository {
    
    init() {
//        let config = Realm.Configuration(schemaVersion: 1)
//        Realm.Configuration.defaultConfiguration = config
        realm = try! Realm()
    }

    // MARK: - private property
    private let realm: Realm

    // MARK: - Live
    public func createLive(newLive: Live) {
        try! realm.write {
            let live = Live()
            live.id = newLive.id
            live.artist = newLive.artist
            live.name = newLive.name
            live.date = newLive.date
            live.openingTime = newLive.openingTime
            live.performanceTime = newLive.performanceTime
            live.closingTime = newLive.closingTime
            live.venue = newLive.venue
            live.price = newLive.price
            live.type = newLive.type
            live.memo = newLive.memo
            live.imagePath = newLive.imagePath
            realm.add(live)
        }
    }
    
    
    public func readAllLive() -> Results<Live> {
        try! realm.write {
            let Lives = realm.objects(Live.self)
            // Deleteでクラッシュするため凍結させる
            return Lives.freeze().sorted(byKeyPath: "id", ascending: true)
        }
    }
    
    public func deleteAllLive() {
        try! realm.write {
            realm.deleteAll()
        }
    }

}
