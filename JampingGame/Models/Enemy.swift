//
//  Enemy.swift
//  JampingGame
//
//  Created by Juri Ohto on 2021/06/14.
//

//敵の制御

import UIKit

enum EnemyType {
    case starfish
    case squid
    case jellyfish
}

class Enemy: UIImageView {

    var bottom: CGFloat = 0 // 表示位置の下限のy座標
    var top: CGFloat = 0 // 表示位置の上限のy座標

    var enemyType: EnemyType!

    var hSpeed: CGFloat = 0 // 水平方向の速度
    var vSpeed: CGFloat = 0 // 垂直方向の速度
    
    override func didMoveToSuperview() {
        
        let imageNames = ["plasticShoppingBag.png", "shark2.png", "shape1.png"]//imagNames[0] = "enemy1.png" = starfish
        let rand = Int(arc4random_uniform(3))//3種類(0-2)の乱数を取得する
        self.image = UIImage(named: imageNames[rand])
        
        switch rand {
        case 0:
            enemyType = .starfish
            hSpeed = 2.0
            vSpeed = 0.5
        case 1:
            enemyType = .squid
            hSpeed = 5.0
            vSpeed = 5.0
        case 2:
            enemyType = .jellyfish
            hSpeed = 2.0
            vSpeed = 2.0
        default:
            break
        }
        
        if arc4random_uniform(2) == 0 {//2種類(0-1)の乱数を取得し、0の場合 = 1/2の確率で
            vSpeed *= -1//上向きに移動する
        }
    }
    
    func move(){
        self.center = CGPoint(x: self.center.x - hSpeed, y: self.center.y + vSpeed)
        if self.center.y > bottom {
            vSpeed = -abs(vSpeed)
        }else if self.center.y < top {
            vSpeed = abs(vSpeed)//absは絶対値
        }
    }

}
