//
//  ErrorProtocol.swift
//  Alive
//
//  Created by t&a on 2023/12/12.
//

import UIKit

// Aliveエラーの基底プロトコル
protocol AliveError: Error {
    var title: String { get }
    var message: String { get }
}

// Apple Watchエラーの基底プロトコル
protocol WatchError: Error, AliveError { }
