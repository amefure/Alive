//
//  iOSConnectViewModel.swift
//  AliveWatch Watch App
//
//  Created by t&a on 2023/12/02.
//

import Combine
import WatchConnectivity

class SessionManager: NSObject {
    
    private var session: WCSession = .default
    
    // iOSから送信されたデータを外部へ公開する
    public var sessionPublisher: AnyPublisher<[Live], SessionError> {
        _sessionPublisher.eraseToAnyPublisher()
    }
    
    // Mutation
    private let _sessionPublisher = PassthroughSubject<[Live], SessionError>()
    
    // iOSとのコネクト状況を外部へ公開する
    public var reachablePublisher: AnyPublisher<Bool, ConnectError> {
        _reachablePublisher.eraseToAnyPublisher()
    }
    
    // Mutation
    private let _reachablePublisher = CurrentValueSubject<Bool, ConnectError>(false)
    
    public func activateSession() throws {
        if WCSession.isSupported() {
            self.session.delegate = self
            self.session.activate()
        } else {
            throw ConnectError.noSupported
        }
    }
    
    // iOS側のデータ要求
    public func requestLivesData() {
        guard session.isReachable == true else { return }
        let requestDic: [String: Bool] = [WatchHeaderKey.REQUEST_DATA: true]
        self.session.sendMessage(requestDic) { error in
            print(error)
        }
    }
}


extension SessionManager: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        } else {
#if DEBUG
            print("Watch セッション：アクティベート")
#endif
            requestLivesData()
        }
    }
    
    /// iOSアプリ通信可能状態が変化した際に呼ばれる
    func sessionReachabilityDidChange(_ session: WCSession) {
#if DEBUG
        print("通信状態が変化：\(session.isReachable)")
#endif
        _reachablePublisher.send(session.isReachable)
    }
    
    /// sendMessageメソッドで送信されたデータを受け取るデリゲートメソッド
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
#if DEBUG
        print("Watch データ受信：\(message)")
#endif
        // iOSからデータを取得
        guard let json = message[WatchHeaderKey.LIVES] as? String else {
            _sessionPublisher.send(completion: .failure(.notExistHeader))
            return
        }
        // JSONデータをString型→Data型に変換
        guard let jsonData = String(json).data(using: .utf8) else {
            _sessionPublisher.send(completion: .failure(.jsonConversionFailure))
            return
        }
        // JSONデータを構造体に準拠した形式に変換
        if let lives = try? JSONDecoder().decode([Live].self, from: jsonData) {
            _sessionPublisher.send(lives)
        } else {
            _sessionPublisher.send(completion: .failure(.jsonConversionFailure))
        }
    }
    
}
