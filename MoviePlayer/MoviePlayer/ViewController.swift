//
//  ViewController.swift
//  MoviePlayer
//
//  Created by Hamlit Jason on 2021/02/27.
//

import UIKit
import AVKit
/*
 오토 레이아웃 연습하기.....
 레이아웃... 넘모 어렵다....
 */
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func btnPlayInternalMovie(_ sender: UIButton) {
        let filePath: String? = Bundle.main.path(forResource: "FastTyping", ofType: "mp4")
       
        let url = NSURL(fileURLWithPath: filePath!)
        /*
        let playerController = AVPlayerViewController()
        
        let player = AVPlayer(url: url as URL)
        playerController.player = player
    
        self.present(playerController, animated: true) {
            player.play()
        }
        */
        playVideo(url: url)
    }
    
    
    @IBAction func btnPlayExternalMovie(_ sender: Any) {
        let url = NSURL(string: "https://dl.dropboxusercontent.com/s/e38auz050w2mvud/Fireworks.mps")!
        
        /*
         let playerController = AVPlayerViewController()
        
        let player = AVPlayer(url: url as URL)
        playerController.player = player
    
        self.present(playerController, animated: true) {
            player.play()
        }
         */
        
        playVideo(url: url)
        
    }
    private func playVideo(url:NSURL) {
        let playerController = AVPlayerViewController()
            
        let player = AVPlayer(url: url as URL)
        playerController.player = player
        
        self.present(playerController, animated: true) {
        player.play()
        }
    }
}
