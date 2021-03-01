//
//  ViewController.swift
//  SwipeGesture
//
//  Created by Hamlit Jason on 2021/02/28.
//

import UIKit

class ViewController: UIViewController {

    let numOfTouchs = 2 // 멀티 터치 스와이프 제스처 인식하기 - 옵션키 같이 눌러야 하며, 두개의 동그라미가 서로 반대방향으로 움직인다 그러나 같은 방향으로 움직이려면 옵션 시프트를 같이 누르면 된다
    
    @IBOutlet var imgViewUp: UIImageView!
    @IBOutlet var imgViewDown: UIImageView!
    @IBOutlet var imgViewLeft: UIImageView!
    @IBOutlet var imgViewRight: UIImageView!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    
    var imgNameFile = ["01.png", "02.png", "03.png", "04.png", "05.png", "06.png"]
    var imgNum = 1
    
    
    var imgLeft = [UIImage]()
    var imgRight = [UIImage]()
    var imgUp = [UIImage]()
    var imgDown = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgUp.append(UIImage(named: "arrow-up-black.png")!)
        imgUp.append(UIImage(named: "arrow-up-red.png")!)
        imgUp.append(UIImage(named: "arrow-up-green.png")!)
        imgDown.append(UIImage(named: "arrow-down-black.png")!)
        imgDown.append(UIImage(named: "arrow-down-red.png")!)
        imgDown.append(UIImage(named: "arrow-down-green.png")!)
        imgLeft.append(UIImage(named: "arrow-left-black.png")!)
        imgLeft.append(UIImage(named: "arrow-left-red.png")!)
        imgLeft.append(UIImage(named: "arrow-left-green.png")!)
        imgRight.append(UIImage(named: "arrow-right-black.png")!)
        imgRight.append(UIImage(named: "arrow-right-red.png")!)
        imgRight.append(UIImage(named: "arrow-right-green.png")!)
        
        imgViewUp.image = imgUp[0]
        imgViewDown.image = imgDown[0]
        imgViewLeft.image = imgLeft[0]
        imgViewRight.image = imgRight[0]

        pageControl.numberOfPages = imgNameFile.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.green
        pageControl.currentPageIndicatorTintColor = UIColor.red
        
        imgView.image = UIImage(named: imgNameFile[0])
        
        // 스와이프 제스처 인식하기 - UISwipeGestureRecognizer 클래스에 의해서 인식된다. 즉, UISwipeGestureRecognizer 클래스 상수의 direction 속성에 원하는 바향을 설정한 후 뷰 깨체의 addGestureRecognizer 메서드를 사용해 원하는 방향의 스와이프 제스처를 등록하여 인식하게 된다.
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:))) // UISwipeGestureRecognizer 클래스 상수 swipeUp을 선언합니다. 액션 인수는 해당 스와이프 제스처를 행했을 때 실행할 메서드를 의미합니다.
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        // swipeUp.numberOfTouchesRequired = numOfTouchs // 이 코드는 있으면 멀티 제스처만 인식하게 하는 코드이다
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        //swipeDown.numberOfTouchesRequired = numOfTouchs
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        //swipeLeft.numberOfTouchesRequired = numOfTouchs
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        //swipeRight.numberOfTouchesRequired = numOfTouchs
        self.view.addGestureRecognizer(swipeRight)
        
        
        
        
        let swipeUpMulti = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGestureMulti))
        swipeUpMulti.direction = UISwipeGestureRecognizer.Direction.up
        swipeUpMulti.numberOfTouchesRequired = numOfTouchs
        self.view.addGestureRecognizer(swipeUpMulti)
        
        let swipeDownMulti = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGestureMulti))
        swipeDownMulti.direction = UISwipeGestureRecognizer.Direction.down
        swipeDownMulti.numberOfTouchesRequired = numOfTouchs
        self.view.addGestureRecognizer(swipeDownMulti)
        
        let swipeLeftMulti = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGestureMulti))
        swipeLeftMulti.direction = UISwipeGestureRecognizer.Direction.left
        swipeLeftMulti.numberOfTouchesRequired = numOfTouchs
        self.view.addGestureRecognizer(swipeLeftMulti)
        
        let swipeRightMulti = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGestureMulti))
        swipeRightMulti.direction = UISwipeGestureRecognizer.Direction.right
        swipeRightMulti.numberOfTouchesRequired = numOfTouchs
        self.view.addGestureRecognizer(swipeRightMulti)
        
        
    }
    
    @objc func respondToSwipeGestureMulti(_ gesture : UIGestureRecognizer) {
        // 액션메서드 구현하기 인수는 스와이프 제스처를 행했을 때 실행할 메서드를 의미합니다. 그럼 스와이프 제스처를 행했을 때 실행할 액션 메서드를 구현해 보자!!
        if let swipeGesture = gesture as? UISwipeGestureRecognizer { // 만일 제스처가 있다면
            
            // 우선 모든 화살표 검정색으로 초기화한다.
            imgViewUp.image = imgUp[0]
            imgViewDown.image = imgDown[0]
            imgViewLeft.image = imgLeft[0]
            imgViewRight.image = imgRight[0]
        
            
            // 스위치 문을 사용해 제스처의 방향에 따라 해당 방향의 이미지를 빨간색 이미지로 변경합니다.
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.up:
                imgViewUp.image = imgUp[2]
            case UISwipeGestureRecognizer.Direction.down:
                imgViewDown.image = imgDown[2]
            case UISwipeGestureRecognizer.Direction.left:
                imgViewLeft.image = imgLeft[2]
                if imgNum > 1 {
                    imgNum -= 1
                    pageControl.currentPage = imgNum - 1
                }
                imgView.image = UIImage(named: "0" + String(imgNum) + ".png")
            case UISwipeGestureRecognizer.Direction.right:
                if imgNum < imgNameFile.count {
                    imgNum += 1
                    pageControl.currentPage = imgNum - 1
                }
                imgView.image = UIImage(named: "0" + String(imgNum) + ".png")
                imgViewRight.image = imgRight[2]
            default:
                break
            }
        }
    }
    
    
    @objc func respondToSwipeGesture(_ gesture : UIGestureRecognizer) {
        // 액션메서드 구현하기 인수는 스와이프 제스처를 행했을 때 실행할 메서드를 의미합니다. 그럼 스와이프 제스처를 행했을 때 실행할 액션 메서드를 구현해 보자!!
        //NSLog("asd")
        if let swipeGesture = gesture as? UISwipeGestureRecognizer { // 만일 제스처가 있다면
            
            // 우선 모든 화살표 검정색으로 초기화한다.
            imgViewUp.image = imgUp[0]
            imgViewDown.image = imgDown[0]
            imgViewLeft.image = imgLeft[0]
            imgViewRight.image = imgRight[0]
        
            
            // 스위치 문을 사용해 제스처의 방향에 따라 해당 방향의 이미지를 빨간색 이미지로 변경합니다.
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.up:
                imgViewUp.image = imgUp[1]
            case UISwipeGestureRecognizer.Direction.down:
                imgViewDown.image = imgDown[1]
            case UISwipeGestureRecognizer.Direction.left:
                if imgNum > 1 {
                    imgNum -= 1
                    pageControl.currentPage = imgNum - 1
                }
                imgView.image = UIImage(named: "0" + String(imgNum) + ".png")
                imgViewLeft.image = imgLeft[1]
                
            case UISwipeGestureRecognizer.Direction.right:
                if imgNum < imgNameFile.count {
                    imgNum += 1
                    pageControl.currentPage = imgNum - 1
                }
                
                imgView.image = UIImage(named: "0" + String(imgNum) + ".png")
                imgViewRight.image = imgRight[1]
                
            default:
                break
            }
        }
    }
    
    
    @IBAction func pageChange(_ sender: UIPageControl) {
        imgView.image = UIImage(named: imgNameFile[pageControl.currentPage])
    }
    

}

