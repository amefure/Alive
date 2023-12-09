//
//  RepositoryViewModel.swift
//  AliveWatch Watch App
//
//  Created by t&a on 2023/12/08.
//

import WatchKit
import RealmSwift

class RepositoryViewModel: ObservableObject {
    
    static let shared = RepositoryViewModel()
    
    private let repository = RealmRepository()
    
    @Published var lives: Array<Live> = []
    
    // MARK: - Stock
    public func readAllLive() {
        lives.removeAll()
        let result = repository.readAllLive()
        lives = Array(result).sorted(by: { $0.date > $1.date })
    }
        
    public func createLive(newLive: Live) {
        repository.createLive(newLive: newLive)
        self.readAllLive()
    }
    
    public func setAllLive(lives: Array<Live>) {
        guard lives.count != 0 else { return }
        deleteAllLive()
        self.lives.removeAll()
        self.lives = lives
        for live in lives {
            createLive(newLive: live)
        }
    }
    
    public func deleteAllLive() {
        repository.deleteAllLive()
    }
    
}
