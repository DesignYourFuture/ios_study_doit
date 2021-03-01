//
//  ViewController.swift
//  imageView
//
//  Created by Hamlit Jason on 2021/02/18.
//

import UIKit

class ViewController: UIViewController {
    
    var isZoom = false
    var imgOn : UIImage?
    var imgOff : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        imgOn = UIImage(named: "lamp_on.png")
        imgOff = UIImage(named: "lamp_off.png")
        
        imgView.image = imgOn
    }

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var btnResize: UIButton!
    
    @IBAction func switchImageOnOff(_ sender: UISwitch) {
        if sender.isOn {
            imgView.image = imgOn
        } else {
            imgView.image = imgOff
        }
    }
    @IBAction func btnResizeImage(_ sender: UIButton) {
        let scale:CGFloat = 2.0 // 배율값 설정
        var newWidth:CGFloat, newHeight:CGFloat
    
        if (isZoom) {
            newWidth = imgView.frame.width/scale
            newHeight = imgView.frame.height/scale
            btnResize.setTitle("sizeUp", for: .normal)
        } else {
            newWidth = imgView.frame.width * scale
            newHeight = imgView.frame.height * scale
            btnResize.setTitle("sizeDown", for: .normal)
        }
        isZoom = !isZoom
        imgView.frame.size = CGSize(width: newWidth, height: newHeight)
    }
}


