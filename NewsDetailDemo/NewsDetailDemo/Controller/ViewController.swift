//
//  ViewController.swift
//  NewsDetailDemo
//
//  Created by Bin on 2017/7/17.
//  Copyright © 2017年 Urun. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints {
            $0.bottom.left.right.equalTo(self.view)
            $0.top.equalTo(self.view).offset(20)
        }
        mainScrollView.contentSize = CGSize(width: 0, height: 3000)
        
        mainScrollView.addSubview(newsDetailWebView)
        newsDetailWebView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1)
        
        let model = NewsDetail.init()
        let width = UIScreen.main.bounds.width
        var tempHtml = try? String(contentsOf: Bundle.main.url(forResource: "ArticleDetail", withExtension: "html")!, encoding: String.Encoding.utf8)
        
        var bodyStr = "<body style=\"font-size:\(25)px;color:\("#4f4f4f");letter-spacing:0px;word-spacing:2px;text-align:justify;overflow:hidden;margin:10px 15px;width=\(width)px;word-break:break-all\">"
        
        bodyStr += "<p><div class='content'>\(model.content)</div></p>"
        bodyStr += "</body>"
        
        tempHtml = tempHtml?.replacingOccurrences(of: "<body><mainView></body>", with: bodyStr)
        
        self.view.addSubview(newsDetailWebView)
        newsDetailWebView.loadHTMLString(tempHtml!, baseURL: Bundle.main.bundleURL)
        
//        let h = newsDetailWebView.stringByEvaluatingJavaScript(from: "document.body.scrollHeight")
        
//        let height = Int(h!)
//        let height = Float(h!)
//        mainScrollView.contentSize = CGSize(width: 0, height: Int(height!))
        
    
        
//        newsDetailWebView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 667)
//        newsDetailWebView.snp.makeConstraints {
//            $0.left.right.top.equalTo(self.view)
//            $0.height.equalTo(height!)
//        }
        
//        self.view.addSubview(newsDetailWebView)
//        newsDetailWebView.snp.makeConstraints {
//            $0.edges.equalTo(self.view)
//        }
        
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let tempSize = change?[NSKeyValueChangeKey.newKey] as? CGSize else {
            return
        }
        print(tempSize)
        
        if tempSize.height > 1 {
            let height = CGFloat(Double(newsDetailWebView.stringByEvaluatingJavaScript(from: "document.body.offsetHeight") ?? "1")!) + 20
            newsDetailWebView.frame.size.height = height
            mainScrollView.contentSize = CGSize(width: self.view.bounds.size.width, height: newsDetailWebView.frame.size.height + 50)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate lazy var newsDetailWebView: UIWebView = {
        let webView = UIWebView()
        webView.scrollView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        webView.scrollView.isScrollEnabled = false
        return webView
    }()

    fileprivate lazy var mainScrollView: UIScrollView = {
        let tempScrollView = UIScrollView()
        tempScrollView.backgroundColor = .red
        tempScrollView.showsVerticalScrollIndicator = true
        tempScrollView.showsHorizontalScrollIndicator = false
//        tempScrollView.contentSize = CGSize(width: 1500, height: 1500)
        return tempScrollView
    }()
    
}

