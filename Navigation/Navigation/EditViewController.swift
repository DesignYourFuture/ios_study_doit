//
//  EditViewController.swift
//  Navigation
//
//  Created by Hamlit Jason on 2021/02/23.
//

import UIKit

protocol EditDelegate {
    // 프로토콜이란 특정 객체가 갖추어야 할 기능이나 속성에 대한 설계도라고 할 수 있다. 실질적으로 아무내용도 없으나, 이 프로토콜을 상속받은 객체는 아래 함수를 꼭 만들어야 한다 그렇지 않으면 에러가 발생한다.
    func didMessageEditDone(_ controller : EditViewController, message : String)
    func didImageOnOffDone(_ cotroller : EditViewController, isOn : Bool)
    func didImageZoomDone(_ controller : EditViewController, isZoom : Bool)
}

class EditViewController: UIViewController {
    
    @IBOutlet var swIsOn: UISwitch!
    var textWayValue : String = ""
    var textMessage : String = ""
    var delegate : EditDelegate? // delegate변수를 선언
    var isOn = false
    var isZoom = false
    
    
    @IBOutlet var lblWay: UILabel!
    @IBOutlet var txMessage: UITextField!
    
    @IBOutlet var btnZoomlabel: UIButton!
    
    override func viewDidLoad() {
        lblWay.text = textWayValue
        txMessage.text = textMessage
        swIsOn.isOn = isOn
        
    }
    
    @IBAction func btnDone(_ sender: UIButton) {
        if delegate != nil {
            delegate?.didMessageEditDone(self, message: txMessage.text!) // didMessageEditDone 함수를 호출하면서 수정화면의 텍스트필드 내용을 메시지 문자열로 전달한다. 다시 말해 수정화면의 텍스트 필드 내용, 즉 데이터를 메인화면으로 전달합니다.
            delegate?.didImageOnOffDone(self, isOn: isOn) // 함수 호출시 바뀐내용 전달
            
            delegate?.didImageZoomDone(self, isZoom: isZoom)
        }
        
        _ = navigationController?.popViewController(animated: true) // 액션세그를 show형태로 했기 때문에 pop형태로 해야한다 - 메인화면으로 다시 돌아가는 코드
    }
    
    @IBAction func btnSize(_ sender: UIButton) {
        if isZoom == false{
            btnZoomlabel.setTitle("축소", for: .normal)
            isZoom = true
        } else {
            btnZoomlabel.setTitle("확대", for: .normal)
            isZoom = false
        }
        
    }
    @IBAction func swImageOnOff(_ sender: UISwitch) {
        if sender.isOn {
            isOn = true
        } else {
            isOn = false
        }
    }
}
