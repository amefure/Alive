//
//  ImageError.swift
//  Alive
//
//  Created by t&a on 2023/11/30.
//

import UIKit

enum ImageError: AliveError {
    /// EI001：保存失敗エラー
    case saveFailed
    
    /// EI002：削除失敗エラー
    case deleteFailed
    
    /// EI003：型変換失敗エラー(公開しない)
    case castFailed
    
    public var title: String { L10n.imageErrorTitle }
    
    public var message: String {
        return switch self {
        case .saveFailed:
            L10n.imageErrorSaveFailedMessage
        case .deleteFailed:
            L10n.imageErrorDeleteFailedMessage
        case .castFailed:
            L10n.imageErrorCastFailedMessage
        }
    }
}
