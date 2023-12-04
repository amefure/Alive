//
//  WatchConnectViewModel.swift
//  Alive
//
//  Created by t&a on 2023/11/30.
//

//
//  WatchConnectViewModel.swift
//  Stock
//
//  Created by t&a on 2023/11/02.
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
    
    private func jsonConverter(lives: [Live]) -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let jsonData = try? encoder.encode(lives) {
            if let json = String(data: jsonData , encoding: .utf8) {
                // 文字コードUTF8のData型に変換
                return json
            }
        }
        // エンコード失敗
        return ""
    }
    
    public func send(lives: [Live]) {
        guard isReachable == true else { return }
        let json = jsonConverter(lives: lives)
        let stockDic: [String: String] = ["stocks": json]
        self.session.sendMessage(stockDic) { error in
            print(error)
        }
    }
}


extension WatchConnectViewModel: WCSessionDelegate {
    
    /// セッションのアクティベート状態が変化した際に呼ばれる
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("Watch コネクトエラー" + error.localizedDescription)
        } else {
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
        // watchOSからデータを取得
        // ["CheckItemNotify":"stockID,itemID,Flag(Bool)"]
        guard let value = message["CheckItemNotify"] as? String else { return }

        let array = value.components(separatedBy: ",")
        let stockId = array[safe: 0] ?? ""
        let itemId = array[safe:1] ?? ""
        let flag = array[safe: 2] ?? "true" == "true"
        guard let stockObjId = try? ObjectId(string: stockId) else { return }
        guard let itemObjId = try? ObjectId(string: itemId) else { return }
        
        /// 少しタイミングをずらしてwatch側も更新
        DispatchQueue.main.asyncAfter( deadline: DispatchTime.now() + 0.01) { [weak self] in
            self?.send(lives: self?.repository.lives ?? [])
        }
   }

    func sessionDidBecomeInactive(_ session: WCSession) { }

    func sessionDidDeactivate(_ session: WCSession) { }
}
