//
//  ViewController.swift
//  mission_imgViewer
//
//  Created by Hamlit Jason on 2021/02/18.
//

import UIKit

class ViewController: UIViewController {

    var idx = 1
    var img : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        img = UIImage(named: String(idx) + ".png")
        imgView.image = img
        
    }

    @IBOutlet var imgView: UIImageView!
    
    
    
    @IBAction func btnPrev(_ sender: Any) {
        if idx == 1 {
            idx = 6
        } else {
            idx = idx - 1
        }
        img = UIImage(named: String(idx) + ".png")
        imgView.image = img
    }
    
    @IBAction func btnNext(_ sender: Any) {
        if idx == 6 {
            idx = 1
        } else {
            idx = idx + 1
        }
        img = UIImage(named: String(idx) + ".png")
        imgView.image = img
        
        NSLog("\(idx)")
    
    }
}

