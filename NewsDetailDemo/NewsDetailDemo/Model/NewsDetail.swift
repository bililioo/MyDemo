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
    var imageArr: Array<String> = []
    
    /// 发表时间戳
    var addonStamp: TimeInterval = 0
    
    /// 发表时间
    var foStringTime: String = ""
    
    /// 来源
    var groupName: String = ""
    
    /// 图片JSON字符串
    var originalPath: [String: String] = [:]
    
    init() {
        
        let jsonPath = Bundle.main.path(forResource: "NewsDetail", ofType: "json")
        var json = (try? String.init(contentsOfFile: jsonPath!, encoding: String.Encoding.utf8)) ?? ""
        
        guard json == "" else {
            return
        }
        json = "temp"
        
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
    
    init(_ json: JSON) {
        
    }
}
