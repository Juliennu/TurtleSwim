//
//  UserCharacter.swift
//  JampingGame
//
//  Created by Juri Ohto on 2021/06/14.
//

//主人公の制御

import UIKit

class Fish: UIImageView {
    
    var bottom: CGFloat = 0 // 表示位置の下限のy座標
    var top: CGFloat = 0 // 表示位置の上限のy座標
    
    var vSpeed: CGFloat = 0 // 垂直方向の速度

    func move(){
        vSpeed += 0.3
        self.center = CGPoint(x: self.center.x, y: self.center.y + vSpeed)
        
        if self.center.y > bottom {//画面上でのキャラクターのy座標が下限よりも低くなった場合（y座標は下に行くほど大きくなる）
            vSpeed = -8
        }else if self.center.y < top {//画面上でのキャラクターのy座標が上限よりも高くなった場合（y座標は上に行くほど小さくなる）
            self.center = CGPoint(x: self.center.x, y: top)
            vSpeed = 0
        }
    }
    
    func jump(){
        vSpeed = -5
    }
}
