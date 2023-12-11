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
        // 1：「Live」に「URL」の追加
        let config = Realm.Configuration(schemaVersion: 1)
        Realm.Configuration.defaultConfiguration = config
        realm = try! Realm()
    }

    // MARK: - private property
    private let realm: Realm
    
    // MARK: - Live
    public func createLive(newLive: Live) {
        try! realm.write {
            let live = Live()
            live.artist = newLive.artist
            live.name = newLive.name
            live.date = newLive.date
            live.openingTime = newLive.openingTime
            live.performanceTime = newLive.performanceTime
            live.closingTime = newLive.closingTime
            live.venue = newLive.venue
            live.price = newLive.price
            live.type = newLive.type
            live.url = newLive.url
            live.memo = newLive.memo
            live.imagePath = newLive.imagePath
            realm.add(live)
        }
    }
    
    public func updateLive(id: ObjectId, newLive: Live) {
        try! realm.write {
            let lives = realm.objects(Live.self)
            if let live = lives.where({ $0.id == id }).first {
                live.artist = newLive.artist
                live.name = newLive.name
                live.date = newLive.date
                live.openingTime = newLive.openingTime
                live.performanceTime = newLive.performanceTime
                live.closingTime = newLive.closingTime
                live.venue = newLive.venue
                live.price = newLive.price
                live.type = newLive.type
                live.url = newLive.url
                live.memo = newLive.memo
                live.imagePath = newLive.imagePath
                live.setList = newLive.setList
            }
        }
    }
    
    public func addTimeTable(id: ObjectId, newTimeTable: TimeTable) {
        try! realm.write {
            let lives = realm.objects(Live.self)
            if let live = lives.where({ $0.id == id }).first {
                live.timeTable.append(newTimeTable)
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
    
    public func deleteTimeTable(id: ObjectId, timeTable: TimeTable) {
        try! self.realm.write{
            if let result = readSingleLive(id: id) {
                if let time = result.timeTable.filter({ $0.id == timeTable.id }).first {
                    if let index = result.timeTable.firstIndex(of: time) {
                        result.timeTable.remove(at: index)
                    }
                }
            }
        }
    }
}

