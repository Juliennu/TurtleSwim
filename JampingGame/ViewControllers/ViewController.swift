//
//  ViewController.swift
//  JampingGame
//
//  Created by Juri Ohto on 2021/06/14.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func StartButtonTapped(_ sender: Any) {
        buttonTappedSoundPlay()
    }

    @IBOutlet weak var userCharactorImage: Fish!
    
    
//MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.layer.cornerRadius = 10
        backGroundSoundPlay()
        backGroundRandamColor()
        userCharacterAnimation()
        // Do any additional setup after loading the view.
    }
 
    
    override func viewWillAppear(_ animated: Bool) {
        // ハイスコアの読み込み
        let ud = UserDefaults.standard
        let highScore = ud.integer(forKey: "HiScore") // 存在しない場合は0
        highScoreLabel.text = "\(highScore) m"
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        backGroundSoundPlayer.play()
        setUpAppTrackimgTransparency()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
//MARK: - Functions
    
    func backGroundRandamColor() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds

        //グラデーションさせるカラーの設定
        let color1 = randomColor()
        let color2 = randomColor()
        let color3 = randomColor()
        
        //CAGradientLayerにグラデーションさせるカラーをセット
        gradientLayer.colors = [color1, color2, color3]
        
        //グラデーションの開始地点・終了地点の設定
        gradientLayer.startPoint = CGPoint.init(x: 1.0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1.0, y:1.0)
        
        //ViewControllerのViewレイヤーにグラデーションレイヤーを挿入する
//        self.view.layer.insertSublayer(gradientLayer,at:0)
        
        
        
        
        UIView.animate(withDuration: 5, delay: 1, options:
                        [UIView.AnimationOptions.allowUserInteraction,
                         UIView.AnimationOptions.repeat,
                         UIView.AnimationOptions.autoreverse],
                animations: {
                    
                    
                    
                    
                    self.view.layer.insertSublayer(gradientLayer,at:0)
//                    self.view.layer.backgroundColor = self.randomColor()

                }, completion:nil )
        
    }
    
    func randomColor() -> CGColor {
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return CGColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    func userCharacterAnimation() {

        userCharactorImage.animationImages = [UIImage(named:"turtleSwim1.png")!, UIImage(named:"turtleSwim2.png")!]
        userCharactorImage.animationDuration = 0.8
        userCharactorImage.startAnimating()
    }


}

