//
//  ResultViewController.swift
//  JampingGame
//
//  Created by Juri Ohto on 2021/06/14.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBAction func ShareButtonTapped(_ sender: Any) {
        
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0.0)//スクリーンショットを撮る座標と縦横幅を指定
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let screenShotImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!  //スリーンショットがUIImage型で取得できる
        UIGraphicsEndImageContext()
        
        
        let activityViewController = UIActivityViewController(activityItems: ["Turtle swimで遊んだよ！", screenShotImage], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
//    @IBAction func twitterButtonTapped(_ sender: Any) {
//        shareOnTwitter()
////        shortClickSoundPlayer.stop()
////        backGroundSoundPlayer1.stop()
//    }
    
    @IBAction func backToTopButton(_ sender: Any) {
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
        buttonTappedSoundPlay()
//        self.dismiss(animated: true, completion: nil)//dismissメソッドにより画面を閉じる
        
    }
    
    @IBAction func retryButtonTapped(_ sender: Any) {
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "PlayViewController") as! PlayViewController
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
        buttonTappedSoundPlay()


    }
    
    
    
    
    
    
    
//    let playViewClass = PlayViewController()
//    playViewClass.score =
    
    @IBOutlet weak var currentScoreLabel: UILabel!
    
    @IBOutlet weak var backHomeButton: UIButton!
    
    @IBOutlet weak var retryButton: UIButton!
    //    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    
//MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        twitterButton.layer.cornerRadius = 20
        
        retryButton.layer.cornerRadius = 45
        backHomeButton.layer.cornerRadius = 45
        shareButton.layer.cornerRadius = 45
        backGroundRandamColor()
        
        
//        currentScoreLabel.text = String(playViewScore)

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
    
    
    
    
}
                

