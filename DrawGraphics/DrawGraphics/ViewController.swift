//
//  ViewController.swift
//  DrawGraphics
//
//  Created by Hamlit Jason on 2021/02/27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnDrawLine(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imgView.frame.size) // 콘텍스트를 이미지 뷰의 크기와 같게 생성한다
        let context = UIGraphicsGetCurrentContext()! // 생성한 콘텍스트의 정보를 가져온다
        
        context.setLineWidth(2.0) // 이제 콘텍스트에 대한 여러 가지 설정을 한다.
        context.setStrokeColor(UIColor.red.cgColor) // 선 색상
        
        context.move(to: CGPoint(x: 70, y: 50)) // 시작위치
        context.addLine(to: CGPoint(x: 270, y: 250)) // 움직이는 위치
        
        context.strokePath() // 추가한 경로에 컨텍스트 그리기
        
        
        context.setLineWidth(4.0)
        context.setStrokeColor(UIColor.blue.cgColor)
        
        context.move(to: CGPoint(x: 170, y: 200))
        context.addLine(to: CGPoint(x : 270, y: 350))
        context.addLine(to: CGPoint(x: 70, y: 350))
        context.addLine(to: CGPoint(x: 170, y: 200))
        context.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext() // 현재 콘텍스트에 그려진 이미지를 가지고 와서 이미지 뷰에 나타낸다
        UIGraphicsEndImageContext() // 그림 그리기를 끝낸다.
    }
    
    @IBAction func btnDrawRect(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imgView.frame.size) // 콘텍스트를 이미지 뷰의 크기와 같게 생성한다
        let context = UIGraphicsGetCurrentContext()! // 생성한 콘텍스트의 정보를 가져온다
        
        
        context.setLineWidth(2.0) // 이제 콘텍스트에 대한 여러 가지 설정을 한다.
        context.setStrokeColor(UIColor.red.cgColor) // 선 색상
        
        context.addRect(CGRect(x: 70, y: 100, width: 200, height: 200))
        context.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    @IBAction func btnDrawCircle(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imgView.frame.size) // 콘텍스트를 이미지 뷰의 크기와 같게 생성한다
        let context = UIGraphicsGetCurrentContext()! // 생성한 콘텍스트의 정보를 가져온다
        
        
        context.setLineWidth(5.0) // 이제 콘텍스트에 대한 여러 가지 설정을 한다.
        context.setStrokeColor(UIColor.red.cgColor) // 선 색상
        
        context.addEllipse(in: CGRect(x: 70, y: 50, width: 200, height: 100)) // 아래 설명과 같은데 얘는 타원으로 그려짐
        context.strokePath()
        
        context.setLineWidth(2.0) // 이제 콘텍스트에 대한 여러 가지 설정을 한다.
        context.setStrokeColor(UIColor.green.cgColor) // 선 색상
        
        context.addEllipse(in: CGRect(x: 70, y: 200, width: 200, height: 100)) // xy좌표에서 시작하고 폭이 200 높이가 100픽셀인 사각형 안에 내접하는 원을 그린다.
        context.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    @IBAction func btnDrawArc(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imgView.frame.size) // 콘텍스트를 이미지 뷰의 크기와 같게 생성한다
        let context = UIGraphicsGetCurrentContext()! // 생성한 콘텍스트의 정보를 가져온다
        
        
        context.setLineWidth(5.0) // 이제 콘텍스트에 대한 여러 가지 설정을 한다.
        context.setStrokeColor(UIColor.red.cgColor) // 선 색상
        
        context.move(to: CGPoint(x: 50, y: 50))
        context.addArc(tangent1End: CGPoint(x: 250, y: 50), tangent2End: CGPoint(x: 250, y: 200), radius: CGFloat(50)) // 현재 위치에서 두 개의 접점 사이에 내접한 반지름이 50인 호를 그리겠다는 뜻입니다. 자세한 설명은 책 599 페이지 참고.
        context.addLine(to: CGPoint(x: 100, y: 400))
        
        context.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    @IBAction func btnDrawFill(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imgView.frame.size) // 콘텍스트를 이미지 뷰의 크기와 같게 생성한다
        let context = UIGraphicsGetCurrentContext()! // 생성한 콘텍스트의 정보를 가져온다
        
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.red.cgColor)
        context.setFillColor(UIColor.red.cgColor)
        
        let rectangle = CGRect(x: 70, y: 200, width: 200, height: 100)
        context.addRect(rectangle)
        context.fill(rectangle)
        context.strokePath()
        
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.blue.cgColor)
        context.setFillColor(UIColor.blue.cgColor)
        
        let circle = CGRect(x: 70, y: 50, width: 200, height: 100)
        context.addEllipse(in: circle)
        context.fillEllipse(in: circle)
        context.strokePath()
        
        context.setLineWidth(4.0)
        context.setStrokeColor(UIColor.green.cgColor)
        context.setFillColor(UIColor.green.cgColor)
        
        context.move(to: CGPoint(x: 170, y: 350))
        context.addLine(to: CGPoint(x : 270, y: 450))
        context.addLine(to: CGPoint(x: 70, y: 450))
        context.addLine(to: CGPoint(x: 170, y: 350))
        context.fillPath()
        context.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext() // 현재 콘텍스트에 그려진 이미지를 가지고 와서 이미지 뷰에 나타낸다
        UIGraphicsEndImageContext() // 그림 그리기를 끝낸다.
    }
}

