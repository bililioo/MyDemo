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
        
        let model = NewsDetail.init()
        print(model.imageArr[0].originalPath)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

