//
//  LiveType.swift
//  Alive
//
//  Created by t&a on 2023/11/20.
//

import UIKit
import RealmSwift
import SwiftUI

enum LiveType: Int, PersistableEnum, Identifiable, CaseIterable {
    var id:String{self.value}
    
    case oneman 
    case battleBands
    case festival
    case unknown
    
    public var value: String {
        switch self {
        case .oneman:
            return L10n.liveTypeOneman
        case .battleBands:
            return L10n.liveTypeBattleBands
        case .festival:
            return L10n.liveTypeFestival
        case .unknown:
            return L10n.liveTypeUnknown
        }
    }
    
    public var color: Color {
        switch self {
        case .oneman:
            return .themaBlue
        case .battleBands:
            return .themaRed
        case .festival:
            return .themaYellow
        case .unknown:
            return .foundation
        }
    }
}
