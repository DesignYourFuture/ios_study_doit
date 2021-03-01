//
//  ImageViewController.swift
//  PinchGesture
//
//  Created by Hamlit Jason on 2021/03/01.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet var imgPinch: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    
    var imgNameFile = ["01.png","02.png","03.png","04.png","05.png","06.png"]
    var imgNum = 1
    
    var initialFontSize : CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageControl.currentPage = 0
        pageControl.numberOfPages = imgNameFile.count
        NSLog(String(imgNameFile.count))
        pageControl.pageIndicatorTintColor = UIColor.green
        pageControl.currentPageIndicatorTintColor = UIColor.red
        
        
        
        imgPinch.image = UIImage(named: imgNameFile[0])
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.doPinch(_:))) // 클래스 상수 핀치 선언해서 액션 인수는 핀치 제스쳐가 인식 되었을 떄 실행할 메서드
        self.view.addGestureRecognizer(pinch) // 뷰 객체의 메서드를 사용해 핀치 제스처를 등록
        
        
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ImageViewController.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        //swipeLeft.numberOfTouchesRequired = numOfTouchs
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ImageViewController.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        //swipeRight.numberOfTouchesRequired = numOfTouchs
        self.view.addGestureRecognizer(swipeRight)
        
    }
    
    @objc func respondToSwipeGesture(_ gesture : UIGestureRecognizer) {
        // 액션메서드 구현하기 인수는 스와이프 제스처를 행했을 때 실행할 메서드를 의미합니다. 그럼 스와이프 제스처를 행했을 때 실행할 액션 메서드를 구현해 보자!!
        //NSLog("asd")
        if let swipeGesture = gesture as? UISwipeGestureRecognizer { // 만일 제스처가 있다면

        
            
            // 스위치 문을 사용해 제스처의 방향에 따라 해당 방향의 이미지를 빨간색 이미지로 변경합니다.
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                if imgNum > 1 {
                    imgNum -= 1
                    pageControl.currentPage = imgNum - 1
                    NSLog("asdd")
                }
                NSLog("asddd")
                imgPinch.image = UIImage(named: "0" + String(imgNum) + ".png")
                
            case UISwipeGestureRecognizer.Direction.right:
                if imgNum < imgNameFile.count {
                    imgNum += 1
                    pageControl.currentPage = imgNum - 1
                    NSLog("asd")
                }
                NSLog("asddd")
                imgPinch.image = UIImage(named: "0" + String(imgNum) + ".png")
            default:
                break
            }
        }
    }

    @objc func doPinch(_ pinch : UIPinchGestureRecognizer){
        imgPinch.transform = imgPinch.transform.scaledBy(x: pinch.scale, y: pinch.scale) // 이미지를 스케일에 맞게 변환한다
        pinch.scale = 1 // 다음 변환을 위하여 핀치의 스케일 속성을 1로 설정한다
    }

    @IBAction func changeControl(_ sender: Any) {
        imgPinch.image = UIImage(named: imgNameFile[pageControl.currentPage])
    }
}
