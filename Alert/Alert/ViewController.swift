//
//  ViewController.swift
//  Alert
//
//  Created by Hamlit Jason on 2021/02/21.
//

import UIKit

class ViewController: UIViewController {

    let imgOn = UIImage(named: "lamp-on.png")
    let imgOff = UIImage(named: "lamp-off.png")
    let imgRemove = UIImage(named: "lamp-Remove.png")
    
    var isLampOn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lambImg.image = imgOn
    }

    @IBOutlet var lambImg: UIImageView!
    
    @IBAction func lambOn(_ sender: UIButton) {
        if (isLampOn == true) {
            let lampOnAlert = UIAlertController(title: "경고", message: "현재 on 상태입니다.", preferredStyle: .alert)
            let onAction = UIAlertAction(title: "네 알겠습니다.", style: UIAlertAction.Style.default, handler: nil)
            lampOnAlert.addAction(onAction)
            present(lampOnAlert, animated: true, completion: nil)
        } else {
            lambImg.image = imgOn
            isLampOn = true
        }
    }
    
    @IBAction func lambOff(_ sender: UIButton) {
        if (isLampOn == true) {
            let lampOnAlert = UIAlertController(title: "램프 끄기", message: "전구를 끄시겠습니까?", preferredStyle: .alert)
            let offAction = UIAlertAction(title: "네 알겠습니다.", style: UIAlertAction.Style.default, handler : { ACTION in
                self.lambImg.image = self.imgOff
                self.isLampOn = false
            })
                
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
            
            lampOnAlert.addAction(offAction)
            lampOnAlert.addAction(cancelAction)
            present(lampOnAlert, animated: true, completion: nil)
            
            
            
        } else {
            let lampOffAlert = UIAlertController(title: "경고", message: "현재 off 상태입니다.", preferredStyle: .alert)
            let offAction = UIAlertAction(title: "네 알겠습니다.", style: UIAlertAction.Style.default, handler: nil)
            lampOffAlert.addAction(offAction)
            present(lampOffAlert, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func LampRemove(_ sender: UIButton) {
        let lampRemoveAlert = UIAlertController(title: "경고", message: "램프를 정말 제거하시겠습니까?.", preferredStyle: .alert)
        
        let onAction = UIAlertAction(title: "킬래요.", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
            self.lambImg.image = self.imgOn
            self.isLampOn = true
        })
        
        let offAction = UIAlertAction(title: "끌래요.", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
            self.lambImg.image = self.imgOff
            self.isLampOn = false
        })
        
        let RemoveAction = UIAlertAction(title: "삭제할래요.", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
            self.lambImg.image = self.imgRemove
            self.isLampOn = false
        })
        
        
        lampRemoveAlert.addAction(onAction)
        lampRemoveAlert.addAction(offAction)
        lampRemoveAlert.addAction(RemoveAction)
        present(lampRemoveAlert, animated: true, completion: nil)
    }
}

