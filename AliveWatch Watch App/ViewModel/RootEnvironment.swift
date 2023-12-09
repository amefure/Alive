//
//  RootEnvironment.swift
//  AliveWatch Watch App
//
//  Created by t&a on 2023/12/08.
//

import UIKit
import Combine

class RootEnvironment: ObservableObject {
    
    // エラーダイアログ表示
    @Published var isPresentErrorDialog: Bool = false
    
    private let sessionManager: SessionManager
    
    private var repositoryViewModel: RepositoryViewModel
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(sessionManager: SessionManager, repositoryViewModel: RepositoryViewModel) {
        self.sessionManager = sessionManager
        self.repositoryViewModel = repositoryViewModel
        
        do {
            try sessionManager.activateSession()
        } catch {
            isPresentErrorDialog = true
        }
        
        subscribeSession()
    }
    
    private func subscribeSession() {
        
        sessionManager.sessionPublisher.sink { [weak self] error in
            guard let self = self else { return }
            print("\(error)")
            self.isPresentErrorDialog = true
        } receiveValue: { lives in
            DispatchQueue.main.async { [weak self] in
                self?.repositoryViewModel.setAllLive(lives: lives)
            }
        }.store(in: &cancellables)
    }
    
}
