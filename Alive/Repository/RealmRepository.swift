//
//  RealmRepository.swift
//  Alive
//
//  Created by t&a on 2023/11/20.
//

import UIKit
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
    public func createLive(artist: String, date: Date, venue: String, price: Int, memo: String) {
        try! realm.write {
            let live = Live()
            live.artist = artist
            live.date = date
            live.venue = venue
            live.price = price
            live.memo = memo
            realm.add(live)
            print("成功")
        }
    }
    
    public func updateLive(id: ObjectId, artist: String, date: Date, venue: String, price: Int, memo: String) {
        try! realm.write {
            let lives = realm.objects(Live.self)
            if let live = lives.where({ $0.id == id }).first {
                live.artist = artist
                live.date = date
                live.venue = venue
                live.price = price
                live.memo = memo
            }
        }
    }
    
    
    private func readSingleLive(id: ObjectId) -> Live? {
        if let Live = realm.objects(Live.self).where({ $0.id == id }).first {
            return Live
        }
        return nil
    }
    
    public func readAllLive() -> Results<Live> {
        try! realm.write {
            let Lives = realm.objects(Live.self)
            // Deleteでクラッシュするため凍結させる
            return Lives.freeze().sorted(byKeyPath: "id", ascending: true)
        }
    }
    
    public func deleteLive(id: ObjectId) {
        try! self.realm.write{
            if let result = readSingleLive(id: id) {
                self.realm.delete(result)
            }
        }
    }
}

