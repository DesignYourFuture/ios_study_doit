//
//  ViewController.swift
//  Navigation
//
//  Created by Hamlit Jason on 2021/02/23.
//

import UIKit

class ViewController: UIViewController, EditDelegate {
   
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgView.image = imgOn
    }
    
    
    let imgOn = UIImage(named: "lamp_on.png")
    let imgOff = UIImage(named: "lamp_off.png")
    
    var isOn = true
    var orgZoom = false
    var isZoom = false
    
    @IBOutlet var txMessage: UITextField!
    @IBOutlet var imgView: UIImageView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let editViewController = segue.destination as! EditViewController // 다른 뷰 컨트롤러에 정보를 전달하기 위해서 이렇게 사용해야 한다.
        
        if segue.identifier == "editButton" {
            editViewController.textWayValue = "segue : use button"
            
        } else if segue.identifier == "editBarButton" {
            editViewController.textWayValue = "segue : use Bar button"
        }
        
        editViewController.textMessage = txMessage.text! // 메인에서 수정으로 전달하는 코드
        editViewController.delegate = self // 수정에서 메인으로 텍스트 전달받는 코드
        editViewController.isOn = isOn // 스위치 상태 전달하기 위해서
        editViewController.isZoom = isZoom
    }

    func didMessageEditDone(_ controller: EditViewController, message: String) {
        // 에디트 뷰 컨트롤러에서 함수를 호출하며 메시지를 전달해 주는데, 이 메시지의 스트링 값을 메인화면의 텍스트 필드에 텍스트로 보여준다. 즉, 수정화면의 데이터를 메인화면에 전달하여 보여주는 것이다.
        txMessage.text = message
    }
    
    func didImageOnOffDone(_ cotroller: EditViewController, isOn: Bool) {
        if isOn {
            imgView.image = imgOn
            self.isOn = true
        } else {
            imgView.image = imgOff
            self.isOn = false
        }
    }
    

    func didImageZoomDone(_ controller: EditViewController, isZoom: Bool) {
        let scale:CGFloat = 2.0
        var newWidth:CGFloat, newHeight:CGFloat
        
        if isZoom {
            if orgZoom {
                
            } else {
                self.isZoom = false
                self.orgZoom = true
                newWidth = imgView.frame.width*scale
                newHeight = imgView.frame.height*scale
                imgView.frame.size = CGSize(width: newWidth, height: newHeight)
            }
            
            print("Zoom: true")
        } else {
            if orgZoom  {
                self.isZoom = true
                self.orgZoom = false
                newWidth = imgView.frame.width/scale
                newHeight = imgView.frame.height/scale
                imgView.frame.size = CGSize(width: newWidth, height: newHeight)
            } else {
                
            }
            
            print("Zoom: false")
        }
    }
    
}

