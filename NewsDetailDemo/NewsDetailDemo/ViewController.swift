//
//  ViewController.swift
//  NewsDetailDemo
//
//  Created by Bin on 2017/7/17.
//  Copyright © 2017年 Urun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var a = String()
        do {
            a = try String(contentsOf: URL.init(string: "https://www.baidu.com")!, encoding: String.Encoding.utf8)
        } catch  {
//            print($0)
        }
        
        let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        self.view.addSubview(webView)
        
//        webView.loadHTMLString(a, baseURL: nil)
        webView.loadRequest(URLRequest(url: URL(string: "https://www.baidu.com")!))
        

        let request = URLRequest(url: URL(string: "https://stackoverflow.com/questions/39089259/stringcontentsofurl-in-swift-3")!)
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if (error == nil) {
                print(String.init(data: data!, encoding: String.Encoding.utf8)!)
            }
            
        }).resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

