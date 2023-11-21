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
        lives = Array(result)
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
}
