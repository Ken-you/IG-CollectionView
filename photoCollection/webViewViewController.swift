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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URLRequest(url: URL(string: "https://devilcase.net/Neneko")!)
        
        webView.load(url)
        
        
    }
    

    
}
