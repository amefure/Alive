//
//  LiveType.swift
//  Alive
//
//  Created by t&a on 2023/11/20.
//

import UIKit
import RealmSwift
import SwiftUI

enum LiveType: Int, PersistableEnum, Identifiable, CaseIterable, Codable {
    var id:String{self.value}
    
    case oneman
    case battleBands
    case festival
    case unknown
    
    public var value: String {
        return switch self {
        case .oneman:
            L10n.liveTypeOneman
        case .battleBands:
            L10n.liveTypeBattleBands
        case .festival:
            L10n.liveTypeFestival
        case .unknown:
            L10n.liveTypeUnknown
        }
    }
    
    public var color: Color {
        return switch self {
        case .oneman:
                .themaRed
        case .battleBands:
                .themaPurple
        case .festival:
                .themaBlue
        case .unknown:
                .themaYellow
        }
    }
}
