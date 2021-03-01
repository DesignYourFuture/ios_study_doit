//
//  ViewController.swift
//  PinchGesture
//
//  Created by Hamlit Jason on 2021/03/01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var txtPinch: UILabel!
    
    var initialFontSize : CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.doPinch(_:))) // 클래스 상수 핀치 선언해서 액션 인수는 핀치 제스쳐가 인식 되었을 떄 실행할 메서드
        self.view.addGestureRecognizer(pinch) // 뷰 객체의 메서드를 사용해 핀치 제스처를 등록
    }

    @objc func doPinch(_ pinch : UIPinchGestureRecognizer){
        if(pinch.state == UIPinchGestureRecognizer.State.began) { // 우선 핀치 제스처의 상태를 스테이트 속성을 사용하여 확인한다.
            initialFontSize = txtPinch.font.pointSize // 핀치 제스처의 상태가 시작이면 앞에서 선언한 변수에 넣는다
        } else {
            txtPinch.font = txtPinch.font.withSize(initialFontSize * pinch.scale) // 만일 핀치 제스처의 상태가 시작이 아니라면 핀치 제스처가 계속 진행되고 있는 상태이므로 변수에 저장해 둔 글자 크기 값에 스케일 속성을 곱하여 텍스트의 글자 크기에 반영한다.
        }
    }

}

