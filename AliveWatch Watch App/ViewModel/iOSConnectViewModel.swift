//
//  iOSConnectViewModel.swift
//  AliveWatch Watch App
//
//  Created by t&a on 2023/12/02.
//


import WatchConnectivity

class iOSConnectViewModel: NSObject, ObservableObject {
    
    static var shared = iOSConnectViewModel()
    
//    private var repositoryViewModel = RepositoryViewModel.shared
    
    @Published var isConnenct: Bool = false

    var session: WCSession
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        if WCSession.isSupported() {
            self.session.delegate = self
            self.session.activate()
        }
    }
    
    // iOS側のデータ要求
    public func requestLivesData() {
        guard isConnenct == true else { return }
        let requestDic: [String: Bool] = [WatchHeaderKey.REQUEST_DATA: true]
        print("データをください")
        self.session.sendMessage(requestDic) { error in
            print(error)
        }
    }
}


extension iOSConnectViewModel: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            print("iOS セッション：アクティベート")
            isConnenct = true
            requestLivesData()
        }
    }
    
    /// iOSアプリ通信可能状態が変化した際に呼ばれる
    func sessionReachabilityDidChange(_ session: WCSession) {
        DispatchQueue.main.async { [weak self] in
            self?.isConnenct = session.isReachable
        }
    }
    
    /// sendMessageメソッドで送信されたデータを受け取るデリゲートメソッド
   func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
       // iOSからデータを取得
       guard let json = message[WatchHeaderKey.LIVES] as? String else { return }
       // JSONデータをString型→Data型に変換
       guard let jsonData = String(json).data(using: .utf8) else { return }
       // JSONデータを構造体に準拠した形式に変換
       if let lives = try? JSONDecoder().decode([Live].self, from: jsonData) {
           print(lives)
       }
   }
    
}
