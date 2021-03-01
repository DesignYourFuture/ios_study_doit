//
//  ViewController.swift
//  TapTouch
//
//  Created by Hamlit Jason on 2021/02/28.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var txtMessage: UILabel!
    @IBOutlet var txtTapCount: UILabel!
    @IBOutlet var txtTouchCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { // 터치사 시작될 때 호출된다.
        
        let touch = touches.first! as UITouch // 현재 발생한 터치 이벤트를 가져오는 코드
        
        txtMessage.text = "Touch Began"
        txtTapCount.text = String(touch.tapCount) // touches 세트 안 포함된 터치의 개수를 출력합니다. - 연속터치 횟수가 몇번이냐
        txtTouchCount.text = String(touches.count) // 터치 객체들 중 첫 번쨰 객체에서 탭의 개수를 가져와 출력합니다. - 손가락 몇개로 눌렀냐 , 이코드 사용위해서는 뷰 컨트롤러의 뷰에서 멀티플 터치 부분을 활성화 해야한다. 시뮬레이터에서는 옵션키 눌러서 활성화 가능하다
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) { // 터치된 손가락이 움직였을 때 호출된다.
        let touch = touches.first! as UITouch
        
        txtMessage.text = "Touch Moved"
        txtTapCount.text = String(touch.tapCount)
        txtTouchCount.text = String(touches.count)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) { // 화면에서 손가락을 떼었을 때 호출된다.
        let touch = touches.first! as UITouch
        
        txtMessage.text = "Touch Ended"
        txtTapCount.text = String(touch.tapCount)
        txtTouchCount.text = String(touches.count)
    }


}

