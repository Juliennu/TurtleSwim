//
//  PlayViewController.swift
//  JampingGame
//
//  Created by Juri Ohto on 2021/06/14.
// App ID: ca-app-pub-4434300298107671~8714990315
// Unit ID: ca-app-pub-4434300298107671/2257393176
// Test Unit ID: ca-app-pub-3940256099942544/4411468910


import UIKit
import GoogleMobileAds

class PlayViewController: UIViewController {
    
    private var interstitial: GADInterstitialAd?
    
    var screenWidth: CGFloat!//画面の幅
    var screenHeight: CGFloat!//画面の高さ
    
    var frameTimer: Timer!
    
    var score = 0
    var scoreCount = 0//得点が入るまでカウントするのに使う
    let scroreInteval = 60//得点が入るまでの間隔
    
    var enemyCount = 0//滴が出現するまでカウントされる
    var enemyInterval = 60//敵が出現する間隔
    var enemyArray = [Enemy]()//敵を格納する配列
    

    @IBOutlet var userCharactorImage: Fish!
    @IBOutlet var scoreLabel: UILabel!
    

//MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpInterstitialAd()

        setUpViewController()
        frameTimer = Timer.scheduledTimer(withTimeInterval: 1.0/60, repeats: true, block: { (timer) in//1.0/60 = 1秒間に60回処理を実行する = iPhone画面と同じ処理頻度
            self.frameAction()
        })
        userCharacterAnimation()
        backGroundColorGradation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {//画面に指を置いた際に実行される
        userCharactorImage.jump()
        buttonTappedSoundPlay()
    }
    
//MARK: - Functions
    
    //インタースティシャル広告の読み込み
    func setUpInterstitialAd() {
        
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-3940256099942544/4411468910",
                                    request: request,
                          completionHandler: { [self] ad, error in
                            if let error = error {
                              print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                              return
                            }
                            interstitial = ad
                            interstitial?.fullScreenContentDelegate = self
                          }
        )
    }
    
    
    func setUpViewController() {
        screenWidth = self.view.frame.size.width
        screenHeight = self.view.frame.size.height
        
        userCharactorImage.bottom = self.view.frame.size.height - 50
        userCharactorImage.top = 50
        
        scoreLabel.text = "0 m"
    }
    
    //主人公Fishのパラパラアニメーション
    func userCharacterAnimation() {

        userCharactorImage.animationImages = [UIImage(named:"turtleSwim1.png")!, UIImage(named:"turtleSwim2.png")!]
        userCharactorImage.animationDuration = 0.8
        userCharactorImage.startAnimating()
    }
    
    
    
    func frameAction(){
        
        userCharactorImage.move()
        
        for i in (0..<enemyArray.count).reversed() { // reversed()で逆ループ=要素の番号が変わらない
            
            let enemy = enemyArray[i]
            enemy.move()
            
            // 衝突判定
            if abs(userCharactorImage.center.x - enemy.center.x) < 50 && abs(userCharactorImage.center.y - enemy.center.y) < 50 { // 絶対値で判定
                finishGame()
                return
            }
            
            // 画面外の敵は除去
            if enemy.center.x < -enemy.frame.size.width/2 {
                enemyArray.remove(at: i)
                enemy.removeFromSuperview()
            }
        }
        
        // 敵の発生
        
        if score < 10 {
            enemyInterval = 60
            
        } else if score < 20 {
            enemyInterval = 45
            
        } else if score < 30 {
            enemyInterval = 30
            
        } else if score < 40 {
            enemyInterval = 25
            
        } else if score < 50 {
            enemyInterval = 20
            
        } else if score < 60 {
            enemyInterval = 15
            
        } else if score < 70 {
            enemyInterval = 10
            
        } else {
            enemyInterval = 5
        }
        
        
        
        
            
        if enemyCount >= enemyInterval {
            let size:CGFloat = 60
            let enemy = Enemy()
            enemy.frame = CGRect(x: 0, y: 0, width: size, height: size)
            let randY = arc4random_uniform(500)
            enemy.center = CGPoint(x: screenWidth + size/2, y: CGFloat(randY))
            enemy.bottom = self.view.frame.size.height - 40
            enemy.top = 40
            self.view.addSubview(enemy)
            enemyArray.append(enemy)
            enemyCount = 0
        } else {
            enemyCount += 1
        }
        
        
        
        
        
        // スコア
        if scoreCount >= scroreInteval {
            score += 1
            scoreLabel.text = "\(score) m"
            scoreCount = 0
        } else {
            scoreCount += 1
        }
    }
    
    
    
    func finishGame(){
        frameTimer.invalidate()//タイマーを停止
        userCharactorImage.stopAnimating()
        
        userCharactorImage.image = UIImage(named: "turtleCry.png")
        
        //プレイカウントを加算
        var playCount = UserDefaults.standard.integer(forKey: "PlayCount")//広告を表示するまでの間隔をカウントするのに使う
        playCount += 1

        // ハイスコアの保存
        let ud = UserDefaults.standard//ユーザーデフォルトのオブジェクトを取得
        let highScore = ud.integer(forKey: "HiScore") // 存在しない場合はデフォルト値0
        if score > highScore {
            ud.set(score, forKey: "HiScore")
        }
        ud.synchronize()
        
        UIView.animate(withDuration: 0.7, animations: {
            self.userCharactorImage.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        }) { (_) in
            UIView.animate(withDuration: 0.7, animations: {
                self.userCharactorImage.transform = CGAffineTransform.identity
            }) { (_) in
                
                
                //プレイが3回の時広告を表示する
                if playCount > 2 { //self.score > 10
                    if self.interstitial != nil {
                        self.interstitial!.present(fromRootViewController: self)
                        playCount = 0
                    } else {
                      print("Ad wasn't ready")
                    
                    }
                    
                } else {
                    self.performSegue(withIdentifier: "toResultView", sender: self)
                }
                
                

            }
        }

    }
    

    
    
    
    
    func backGroundColorGradation() {
        
        //ViewControllerのViewの初期設定
//        let gradientView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
//        self.view.backgroundColor = UIColor.white
        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = gradientView.bounds
        gradientLayer.frame = self.view.bounds
//
        //グラデーションさせるカラーの設定
        let color1 = UIColor(red: 44/256.0, green: 232/256.0, blue: 252/256.0, alpha: 1.0).cgColor
        let color2 = UIColor(red: 6/256.0, green: 71/256.0, blue: 161/256.0, alpha: 1.0).cgColor
        let color3 = UIColor(red: 4/256.0, green: 11/256.0, blue: 39/256.0, alpha: 1.0).cgColor
        
        //CAGradientLayerにグラデーションさせるカラーをセット
        gradientLayer.colors = [color1, color2, color3]
//        gradientLayer.colors = [UIColor.orange.cgColor, UIColor.blue.cgColor]
//        gradientView.layer.addSublayer(gradientLayer)
        
        
        //グラデーションの開始地点・終了地点の設定
        gradientLayer.startPoint = CGPoint.init(x: 1.0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1.0, y:1.0)
        
        //ViewControllerのViewレイヤーにグラデーションレイヤーを挿入する
        self.view.layer.insertSublayer(gradientLayer,at:0)
//        gradientView.layer.insertSublayer(gradientLayer, at: 0)
   
        
    }


}

extension PlayViewController: GADFullScreenContentDelegate {
    
    /// Tells the delegate that the ad failed to present full screen content.
      func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
      }

      /// Tells the delegate that the ad presented full screen content.
      func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did present full screen content.")
        backGroundSoundPlayer.pause()
      }

      /// Tells the delegate that the ad dismissed full screen content.
      func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
        setUpInterstitialAd()
        backGroundSoundPlayer.play()
        self.performSegue(withIdentifier: "toResultView", sender: self)
      }
    
}
