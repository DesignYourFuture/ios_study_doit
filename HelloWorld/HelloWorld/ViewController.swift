//
//  ViewController.swift
//  HelloWorld
//
//  Created by Hamlit Jason on 2021/02/18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBOutlet var txtName: UITextField!
    
    @IBOutlet var lblHello: UILabel!
    
    @IBAction func btnSend(_ sender: UIButton) {
        lblHello.text = "Hello, " + txtName.text!
    }
}

