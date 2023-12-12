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
    public func presentErrorView(title: String, messege: String) {
        isPresentError = true
        errorTitle = title
        errorMessage = messege
    }
    
    
}
