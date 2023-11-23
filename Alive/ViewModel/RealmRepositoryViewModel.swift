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
    
    public func readAllLive() {
        lives.removeAll()
        let result = repository.readAllLive()
        lives = Array(result).sorted(by: { $0.date > $1.date })
    }
    
    public func createLive(newLive: Live) {
        repository.createLive(newLive: newLive)
        self.readAllLive()
    }
    
    public func updateLive(id: ObjectId, newLive: Live) {
        repository.updateLive(id: id, newLive: newLive)
        self.readAllLive()
    }
    
    public func deleteLive(id: ObjectId) {
        repository.deleteLive(id: id)
        self.readAllLive()
    }
    
    public var generateAvailability: [Bool] {
        // 日付とその日付が30日前までに存在するかどうかの真偽値を保持する配列を作成
        var availabilityArray: [Bool] = []
        
        for index in 0...29 {
            let minusIndex = index * -1
            let theday = Calendar.current.date(byAdding: .day, value: minusIndex, to: Date())!
            availabilityArray.append(lives.contains(where: { Calendar.current.isDate($0.date, inSameDayAs: theday) }))
        }

        return availabilityArray.reversed()
    }
}
