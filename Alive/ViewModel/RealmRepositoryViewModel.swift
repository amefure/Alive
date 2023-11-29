//
//  RealmRepositoryViewModel.swift
//  Alive
//
//  Created by t&a on 2023/11/20.
//
import UIKit
import RealmSwift


class RealmRepositoryViewModel: ObservableObject {
    
    static let shared = RealmRepositoryViewModel()
    private let repository = RealmRepository()
    
    @Published var lives: Array<Live> = []
    @Published var artists: Array<String> = []
    
    public func readAllLive() {
        lives.removeAll()
        let result = repository.readAllLive()
        lives = Array(result).sorted(by: { $0.date > $1.date })
        artists = Array(Set(lives.filter({ $0.artist != "" }).map({ $0.artist }))).sorted()
    }
    
    public func searchFilteringLive(search: String) {
        lives.removeAll()
        let result = repository.readAllLive()
        lives = Array(result).sorted(by: { $0.date > $1.date }).filter( {$0.artist.contains(search) || $0.name.contains(search) })
    }
    
    public func createLive(newLive: Live) {
        repository.createLive(newLive: newLive)
        self.readAllLive()
    }
    
    public func updateLive(id: ObjectId, newLive: Live) {
        repository.updateLive(id: id, newLive: newLive)
        self.readAllLive()
    }
    
    public func addTimeTable(id: ObjectId, newTimeTable: TimeTable) {
        repository.addTimeTable(id: id, newTimeTable: newTimeTable)
        self.readAllLive()
    }
    
    
    public func deleteTimeTable(id: ObjectId, timeTable: TimeTable) {
        repository.deleteTimeTable(id: id, timeTable: timeTable)
        self.readAllLive()
    }
    
    public func deleteLive(id: ObjectId) {
        repository.deleteLive(id: id)
        self.readAllLive()
    }
    
    public var getMonthLiveHistory: [ObjectId?] {
        // 開催日が本日より30日前までに存在するかどうか
        var availabilityArray: [ObjectId?] = []
        
        for index in 0...29 {
            let minusIndex = index * -1
            let theday = Calendar.current.date(byAdding: .day, value: minusIndex, to: Date())!
            if let index = lives.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: theday) }) {
                availabilityArray.append(lives[safe: index]?.id ?? nil)
            } else {
                availabilityArray.append(nil)
            }
        }
        return availabilityArray.reversed()
    }
    
    /// 順番を保持したいため配列で返す
    public var getArtistCounts: Array<(key: String, value: Int)> {
        
        var artistCounts: [String: Int] = [:]

        for live in lives {
            if let count = artistCounts[live.artist] {
                artistCounts[live.artist] = count + 1
            } else {
                artistCounts[live.artist] = 1
            }
        }

        return artistCounts.sorted(by: { $0.key > $1.key }).sorted(by: { $0.value > $1.value })
    }
}
