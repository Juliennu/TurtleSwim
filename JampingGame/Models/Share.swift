//
//  TwitterShare.swift
//  JampingGame
//
//  Created by Juri Ohto on 2021/06/14.
//

import UIKit

func shareOnTwitter() {
    
    //シェアするテキストを作成
    let text = "海底探索を遊びました！"
    let hashTag = "#海底探索"
    let appStoreURL = "https://appstoreconnect.apple.com/apps/1571307333/appstore/ios/version/deliverable"//※要変更！私のApp Storeのページに遷移するようにする
    
    let completedText = text + "\n" + hashTag + "\n" + appStoreURL
    
    //作成したテキストをエンコード
    let encodedText = completedText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    
    //エンコードしたテキストをURLに繋げ、URLを開いてツイート画面を表示させる
    if let encodedText = encodedText,
       let url = URL(string: "https://twitter.com/intent/tweet?text=\(encodedText)") {
        UIApplication.shared.open(url)
    }
}


