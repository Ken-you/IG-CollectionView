//
//  webViewViewController.swift
//  photoCollection
//
//  Created by yousun on 2021/5/22.
//

import UIKit
import WebKit

class webViewViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    // 點選主頁使用者自我介紹的網址，顯示網頁
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URLRequest(url: URL(string: "https://devilcase.net/Neneko")!)
        
        webView.load(url)
        
        
    }
    

    
}
