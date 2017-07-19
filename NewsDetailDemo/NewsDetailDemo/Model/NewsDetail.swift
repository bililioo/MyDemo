//
//  NewsDetail.swift
//  NewsDetailDemo
//
//  Created by Bin on 2017/7/18.
//  Copyright © 2017年 Urun. All rights reserved.
//

import Foundation
import SwiftyJSON

struct NewsDetail {
    
    /// 标题
    var title: String = ""
    
    /// 内容
    var content: String = ""
    
    /// 图片数组
    var imageArr: Array<NewsImage> = []
    
    /// 发表时间戳
    var addonStamp: TimeInterval = 0
    
    /// 发表时间
    var foStringTime: String = ""
    
    /// 来源
    var groupName: String = ""
    
    init() {
        
        self.imageArr = Array()
        
        let jsonPath = Bundle.main.path(forResource: "NewsDetail", ofType: "json")
        let json = (try? String.init(contentsOfFile: jsonPath!, encoding: String.Encoding.utf8)) ?? ""
        
        if json.isEmpty {
            return
        }
        
        let data = json.data(using: String.Encoding.utf8)
        
        let dic: [String: Any] = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : Any]
        
    
        let dic1: [String: Any] = dic["data"] as! [String : Any]
        
        let dic2: [String: Any] = dic1["thumbnailImage"] as! [String: Any]
        let arr: [[String: Any]] = dic2["data"] as! [[String: Any]]
        
        
        for dic: [String: Any] in arr {
            print(dic)
            var imgModel = NewsImage()
            imgModel.thumbnailPath = dic["contentThumbnail"] as! String
            imgModel.originalPath = dic["originalPath"] as! String
            imgModel.width = dic["width"] as! Int
            imgModel.height = dic["height"] as! Int
            imgModel.ref = dic["tag"] as! String
            
            self.imageArr.append(imgModel)
        }
        
        self.addonStamp = dic1["time"]! as! TimeInterval
        self.content = dic1["content"] as! String
        self.title = dic1["title"] as! String
        self.groupName = dic1["siteName"] as! String
    }
}

struct NewsImage {
    
    /// 图片占位符
    var ref: String = ""
    
    /// 宽
    var width: Int = 0
    
    /// 高
    var height: Int = 0
    
    /// 原图路径
    var originalPath: String = ""
    
    /// 缩略图路径
    var thumbnailPath: String = ""
    
    init() {
        
    }
}
