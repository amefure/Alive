//
//  RootEnvironment.swift
//  Alive
//
//  Created by t&a on 2023/12/09.
//

import UIKit
import Combine

class RootEnvironment: ObservableObject {
    
    // エラーダイアログ表示
    @Published var isPresentError: Bool = false
    // エラーダイアログタイトル
    @Published private(set) var errorTitle: String = ""
    // エラーダイアログメッセージ
    @Published private(set) var errorMessage: String = ""
    
    private var cancellables: Set<AnyCancellable> = []
    
    // エラービュー表示
    public func presentErrorView(error: AliveError) {
        isPresentError = true
        errorTitle = error.title
        errorMessage = error.message
    }
    
    private let sessionManager: SessionManager
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
        subscribeSession()
    }
    
    
    private func subscribeSession() {
        sessionManager.errorPublisher.sink { [weak self] error in
            guard let self = self else { return }
            if let connectError = error as? ConnectError,
                connectError == ConnectError.noSupported {
#if DEBUG
                print("Apple Watch非サポート")
#endif
                return
            }
            self.presentErrorView(error: error)
        }.store(in: &cancellables)
    }
    
}
