//
//  ViewController.swift
//  mission_Web
//
//  Created by Hamlit Jason on 2021/02/21.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let filepath = Bundle.main.path(forResource: "htmlView", ofType: "html")
        let myUrl = URL(fileURLWithPath: filepath!)
        let myRequest = URLRequest(url : myUrl)
        
        webView.load(myRequest)
    }

    @IBOutlet var webView: WKWebView!
    
}

