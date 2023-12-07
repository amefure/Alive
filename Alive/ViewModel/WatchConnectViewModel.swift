//
//  WatchConnectViewModel.swift
//  Alive
//
//  Created by t&a on 2023/11/30.
//


import UIKit
import Combine
import WatchConnectivity
import RealmSwift

class WatchConnectViewModel: NSObject, ObservableObject {
    
    static var shared = WatchConnectViewModel()
    
    private var repository = RealmRepositoryViewModel.shared
    
    @Published var isReachable = false
    
    private var session: WCSession
    
    override init() {
        self.session = .default
        super.init()
        if WCSession.isSupported() {
            self.session.delegate = self
            self.session.activate()
        }
    }
    
    /// [Live] をJSON形式に変換する
    public func jsonConverter(lives: [Live]) throws -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let jsonData = try? encoder.encode(lives) {
            if let json = String(data: jsonData , encoding: .utf8) {
                // 文字コードUTF8のData型に変換
                return json
            }
        }
        // エンコード失敗
        throw WatchError.jsonConversionFailure
    }
    
    public func send(lives: [Live]) {
        guard isReachable == true else { return }
        do {

            let json = try jsonConverter(lives: lives)
            let liveDic: [String: String] = [WatchHeaderKey.LIVES: json]
            self.session.sendMessage(liveDic) { error in
                print(error)
            }
        } catch {
            
        }
    }
}


extension WatchConnectViewModel: WCSessionDelegate {
    
    /// セッションのアクティベート状態が変化した際に呼ばれる
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("Watch コネクトエラー" + error.localizedDescription)
        } else {
            print("Watch セッション：アクティベート")
            isReachable = session.isReachable
        }
    }
    
    /// Watchアプリ通信可能状態が変化した際に呼ばれる
    func sessionReachabilityDidChange(_ session: WCSession) {
        isReachable = session.isReachable
        if isReachable {
            // 未接続状態から接続された時にも情報を送信
            send(lives: repository.lives)
        }
    }
    
    /// sendMessageメソッドで送信されたデータを受け取るデリゲートメソッド
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        print("リクエストを受けたよ")
        guard let result = message[WatchHeaderKey.REQUEST_DATA] as? Bool else { return }
        if result {
            print("データを送信したよ")
            send(lives: repository.lives)
        }
        
   }

    func sessionDidBecomeInactive(_ session: WCSession) { }

    func sessionDidDeactivate(_ session: WCSession) { }
}
