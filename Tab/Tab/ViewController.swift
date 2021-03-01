//
//  ViewController.swift
//  Tab
//
//  Created by Hamlit Jason on 2021/02/23.
//

import UIKit

class ViewController: UIViewController {

 
    @IBAction func btnMoveImageView(_ sender: Any) {
        tabBarController?.selectedIndex = 1
    }
    
    @IBAction func btnMoveDatePickerVIew(_ sender: Any) {
        tabBarController?.selectedIndex = 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

