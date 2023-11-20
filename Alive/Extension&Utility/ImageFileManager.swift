//
//  ImageFileManager.swift
//  Alive
//
//  Created by t&a on 2023/11/20.
//

import UIKit
import SwiftUI

/// アプリからデバイス内(Docmentsフォルダ)へ画像を保存するクラス
class ImageFileManager {
    
    private var fileManager = FileManager.default
    
    private var suffix = ".jpg"
    
    // DocmentsフォルダまでのURLを取得
    private func getDocmentsUrl(_ fileName:String) -> URL? {
        do {
            let docsUrl = try fileManager.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false)
            // URLを構築
            let url = docsUrl.appendingPathComponent(fileName)
            return url
        } catch {
            return nil
        }
    }
    
    public func loadImage(name: String) -> UIImage? {
        /// 名前がないなら終了
        guard name != "" else { return nil }
        
        guard let path = getDocmentsUrl("\(name + suffix)")?.path  else { return nil }
        
        if fileManager.fileExists(atPath: path) {
            if let image = UIImage(contentsOfFile: path) {
                return image
            } else {
                return nil
            }
        }
        return nil
    }
    
    /// 画像保存処理
    public func saveImage(name: String, image: UIImage) -> Bool {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return false }
        guard let path = getDocmentsUrl("\(name + suffix)") else { return false }
        do {
            try imageData.write(to: path)
            return true
        } catch {
            print("保存失敗")
            return false
        }
    }
    
    /// 画像削除処理
    public func deleteImage(name: String) {
        guard let path = getDocmentsUrl("\(name + suffix)") else { return }
        do {
            try fileManager.removeItem(at: path)
        } catch {
            print("削除失敗")
        }
    }
}
