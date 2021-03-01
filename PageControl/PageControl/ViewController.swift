//
//  ViewController.swift
//  PageControl
//
//  Created by Hamlit Jason on 2021/02/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pageControl.numberOfPages = images.count // 전체 페이지 수
        pageControl.currentPage = 0 // 현재 페이지
        pageControl.pageIndicatorTintColor = UIColor.green // 페이지를 표시하는 부분의 색상을 의미 즉 페이지를 표시하는 페이지 컨트롤러의 색이 초록색으로 보인다.
        imgView.image = UIImage(named: images[0]) // 초기세팅은 0번째 이미지 보이도록 
    }

    @IBOutlet var imgView: UIImageView!
    
    @IBOutlet var pageControl: UIPageControl!
    
    var images = ["01.png", "02.png", "03.png", "04.png", "05.png", "06.png"]
    
    @IBAction func pageChange(_ sender: UIPageControl) {
        imgView.image = UIImage(named: images[pageControl.currentPage]) // 페이지 컨트롤의 상세정보를 가져와서 이미지 뷰에 보여줌
    }
}

