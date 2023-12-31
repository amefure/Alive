//
//  SessionManager.swift
//  Alive
//
//  Created by t&a on 2023/12/09.
//

import Combine
import WatchConnectivity

class SessionManager: NSObject {
    
    private var session: WCSession = .default
    
    private var repository = RealmRepositoryViewModel.shared

    // Errorを外部へ公開する
    public var errorPublisher: AnyPublisher<WatchError, Never> {
        _errorPublisher.eraseToAnyPublisher()
    }
    
    // Mutation
    private let _errorPublisher = PassthroughSubject<WatchError, Never>()
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            self.session.delegate = self
            self.session.activate()
        } else {
            _errorPublisher.send(ConnectError.noSupported)
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
        throw SessionDataError.jsonConversionFailed
    }
    
    public func send(lives: [Live]) {
        guard session.isReachable == true else { return }
        do {
            let json = try jsonConverter(lives: lives)
            let liveDic: [String: String] = [WatchHeaderKey.LIVES: json]
            self.session.sendMessage(liveDic) { [weak self] error in
                guard let self = self else { return }
                self._errorPublisher.send(SessionDataError.sendFailed)
            }
        } catch {
            _errorPublisher.send(error as? SessionDataError ?? SessionDataError.unidentified)
        }
    }
}


extension SessionManager: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if error != nil {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self._errorPublisher.send(ConnectError.activateFailed)
            }
        } else {
#if DEBUG
            print("Watch セッション：アクティベート")
#endif
        }
    }
    
    /// iOSアプリ通信可能状態が変化した際に呼ばれる
    func sessionReachabilityDidChange(_ session: WCSession) {
#if DEBUG
        print("通信状態が変化：\(session.isReachable)")
#endif
    }
    
    /// sendMessageメソッドで送信されたデータを受け取るデリゲートメソッド(使用されていない)
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
#if DEBUG
        print("Watch データ受信：\(message)")
#endif
    }
    
    /// transferUserInfoメソッドで送信されたデータを受け取るデリゲートメソッド(バックグラウンドでもキューとして残る)
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        guard let result = userInfo[WatchHeaderKey.REQUEST_DATA] as? Bool else {
            _errorPublisher.send(SessionDataError.notExistHeader)
            return
        }
        if result {
            send(lives: repository.lives)
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) { }
    
    func sessionDidDeactivate(_ session: WCSession) { }
    
}

