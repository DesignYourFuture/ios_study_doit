//
//  ViewController.swift
//  Web
//
//  Created by Hamlit Jason on 2021/02/21.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myWebView.navigationDelegate = self // 웹뷰가 로딩중인지 살펴보기 위한 델리게이션
        loadWebPage("https://2sam.net")
    }

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        // 로딩중인지 확인
        myActivityIndicator.startAnimating()
        myActivityIndicator.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // 로딩이 완료되었을 때 동작
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        // 로딩 실패시
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
    }
    
    func loadWebPage(_ url : String){
        let myUrl = URL(string: url)
        let myRequest = URLRequest(url: myUrl!)
        myWebView.load(myRequest)
    }
    
    @IBOutlet var txtUrl: UITextField!
    
    @IBOutlet var myWebView: WKWebView!

    @IBOutlet var myActivityIndicator: UIActivityIndicatorView!
    
    func checkUrl (_ url : String) -> String {
        var strUrl = url
        let flag = strUrl.hasPrefix("http://")
        if !flag {
            strUrl = "http://" + strUrl
        }
        return strUrl
    }
    
    @IBAction func btnGotoUrl(_ sender: UIButton) {
        let myUrl = checkUrl(txtUrl.text!)
        txtUrl.text = ""
        loadWebPage(myUrl)
    }
    
    @IBAction func btnGoSite1(_ sender: UIButton) {
        loadWebPage("https://fallinmac.tistory.com")
    }
    
    @IBAction func btnGoSite2(_ sender: UIButton) {
        loadWebPage("https://blog.2sam.net")
    }
    
    @IBAction func btnLoadHtmlString(_ sender: UIButton) {
        let htmlString = "<h1> HTML STRING </h1><p> String 변수를 이용한 웹 페이지</p> <p><a href = \"http://2sam.net\">2sam</a>으로 이동</p>"
        myWebView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    @IBAction func btnLoadHtmlFile(_ sender: UIButton) {
        let filepath = Bundle.main.path(forResource: "htmlView", ofType: "html") // htmlView.html 파일에 ㄷ한 패스 변수 생성
        let myUrl = URL(fileURLWithPath: filepath!) // 패스 변수를 이용하여 URL 변수를 생성
        let myRequest = URLRequest(url: myUrl) // 피퀘스트
        myWebView.load(myRequest) // 로드
    }
    
    @IBAction func btnStop(_ sender: UIBarButtonItem) {
        myWebView.stopLoading()
    }
    
    @IBAction func btnReload(_ sender: UIBarButtonItem) {
        myWebView.reload()
    }
    
    @IBAction func btnGoBack(_ sender: UIBarButtonItem) {
        myWebView.goBack()
    }

    @IBAction func btnGoForward(_ sender: UIBarButtonItem) {
        myWebView.goForward()
    }
    
}

