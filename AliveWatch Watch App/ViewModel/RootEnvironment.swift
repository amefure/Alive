//
//  RootEnvironment.swift
//  AliveWatch Watch App
//
//  Created by t&a on 2023/12/08.
//

import UIKit
import Combine

class RootEnvironment: ObservableObject {
    
    // iOSと接続中
    @Published var isReachable: Bool = false
    // エラーダイアログ表示
    @Published var isPresentErrorDialog: Bool = false
    
    private let sessionManager: SessionManager
    
    var cancellables: Set<AnyCancellable> = []
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
        
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
            print("データが取れたよ")
            print(lives)
        }.store(in: &cancellables)
        
        
        sessionManager.reachablePublisher.sink { [weak self] error in
            guard let self = self else { return }
            print("\(error)")
            self.isPresentErrorDialog = true
        } receiveValue: { [weak self] isReachable in
            guard let self = self else { return }
            self.isReachable = isReachable
        }.store(in: &cancellables)

    }
    
    public func requestLivesData() {
        sessionManager.requestLivesData()
    }
}
