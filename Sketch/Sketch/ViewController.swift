//
//  ViewController.swift
//  Sketch
//
//  Created by Hamlit Jason on 2021/02/28.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imgView: UIImageView!
    
    var lastPoint : CGPoint! // 바로 전에 터치하거나 이동한 위치
    var lineSize :CGFloat = 2.0 // 선의 두께
    var lineColor = UIColor.red.cgColor // 선의 색상
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func clearImageView(_ sender: UIButton) {
        imgView.image = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        
        lastPoint = touch.location(in: imgView)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round) // 라인의 끝 모양을 둥근 모양으로 설정합니다.
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        
        let touch = touches.first! as UITouch // 현재 발생한 터치 이벤트를 가져옵니다.
        let currPoint = touch.location(in: imgView) // 터치된 위치를 currPoint로 가져옵니다.
        
        imgView.image?.draw(in: CGRect(x:0, y:0, width: imgView.frame.size.width, height: imgView.frame.size.height)) // 현재 이미지뷰에 있는 이미지를 이미지 뷰의 크기로 그립니다. - 이 코드가 없으면 그려지지 않는다.
        
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y)) // 이전에 이동된 위치인 lastPoint로 시작 위치를 이동시킵니다.
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currPoint.x, y: currPoint.y)) // 라스트포인트에서 현재위치인 컬포인트까지 선을 추가합니다.
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        lastPoint = currPoint // 마지막 위치에 현재 포인트 할당
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round) // 라인의 끝 모양을 둥근 모양으로 설정합니다.
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height))
        
        
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y)) // 이전에 이동된 위치인 lastPoint로 시작 위치를 이동시킵니다.
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: lastPoint.x, y: lastPoint.y)) // 이 부분이 무브랑 다른 부분이다.
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake { // 시뮬레이터에서 컨트롤 커멘트 지
            imgView.image = nil // 흔들면 지운다
        }
    }
    
    
    @IBAction func btn_black(_ sender: UIButton) {
        lineColor = UIColor.black.cgColor
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
    }
    
    @IBAction func btn_red(_ sender: UIButton) {
        lineColor = UIColor.red.cgColor
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
    }
    
    @IBAction func btn_green(_ sender: UIButton) {
        lineColor = UIColor.green.cgColor
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
    }
    
    @IBAction func btn_blue(_ sender: UIButton) {
        lineColor = UIColor.blue.cgColor
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
    }
    
  
    @IBOutlet var txtLineSize: UITextField!

    
    @IBAction func txtEditChanged(_ sender: UITextField) {
        if txtLineSize.text != "" {
            lineSize = CGFloat(Int(txtLineSize.text!)!)
        }
    }
    
    @IBAction func txtDidEndOnExit(_ sender: UITextField) {
        lineSize = CGFloat(Int(txtLineSize.text!)!)
    }

    
    @IBAction func txtTouchDown(_ sender: UITextField) {
        txtLineSize.selectAll(UITextField.self)
    }
}

