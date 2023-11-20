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
    }
    
    public func createLive(artist: String, date: Date, venue: String, price: Int, memo: String) {
        repository.createLive(artist: artist, date: date, venue: venue, price: price, memo: memo)
        self.readAllLive()
    }
    
    public func updateLive(id: ObjectId, artist: String, date: Date, venue: String, price: Int, memo: String) {
        repository.updateLive(id: id, artist: artist, date: date, venue: venue, price: price, memo: memo)
        self.readAllLive()
    }
    
    public func deleteLive(id: ObjectId) {
        repository.deleteLive(id: id)
        self.readAllLive()
    }
}
