//
//  ImageError.swift
//  Alive
//
//  Created by t&a on 2023/11/30.
//

import UIKit

enum ImageError: Error {
    case saveFailed
    case deleteFailed
    case castFailed
    
    public var message: String {
        switch self {
        case .saveFailed:
            return ""
        case .deleteFailed:
            return ""
        case .castFailed:
            return ""
        }
    }
}
