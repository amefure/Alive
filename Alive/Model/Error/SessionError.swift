//
//  SessionError.swift
//  Alive
//
//  Created by t&a on 2023/12/09.
//

import UIKit

// Watch ↔︎ iOS 間データ送受信エラークラス
enum SessionError: Error {
    
    /// E001：JSON変換エラー
    case jsonConversionFailure
    
    /// E002：辞書Keyが存在しない
    case notExistHeader
    
    /// E003：不明
    case unidentified
    
}
