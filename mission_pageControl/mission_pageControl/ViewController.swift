//
//  ViewController.swift
//  mission_pageControl
//
//  Created by Hamlit Jason on 2021/02/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var lableText: UILabel!
    @IBOutlet var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lableText.text = String(1)
        
        pageControl.numberOfPages = 10
        pageControl.pageIndicatorTintColor = UIColor.red
    }

    @IBAction func pageChange(_ sender: UIPageControl) {
        lableText.text = String(pageControl.currentPage + 1)
    
    }
    
}

