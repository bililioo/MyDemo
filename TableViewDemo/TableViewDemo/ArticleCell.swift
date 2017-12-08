//
//  ArticleCell.swift
//  TableViewDemo
//
//  Created by Bin on 2017/9/12.
//  Copyright © 2017年 Urun. All rights reserved.
//

import UIKit
import SnapKit
import CoreText

class ArticleCell: UITableViewCell {
    
    var title: String {
        get {
            return self.title
        }
        set {
            titleLayer.string = newValue
        }
    }
    
    private lazy var height: CGFloat = self.frame.height
    private lazy var width: CGFloat = self.frame.width
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
//        self.addSubview(titleLabel)
//        titleLabel.snp.makeConstraints {
//            $0.edges.equalTo(self)
//        }
        
        self.layer.addSublayer(lineLayer)
        lineLayer.frame = CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 1)
        
//        self.layer.addSublayer(titleLayer)
//        titleLayer.frame = CGRect(x: 7, y: 7, width: 120 - 14, height: height - 14)
        
        titleView.layer.addSublayer(titleLayer)
        self.addSubview(titleView)
        titleView.snp.makeConstraints {
            $0.left.top.equalTo(self).offset(7)
            $0.right.bottom.equalTo(self).offset(-7)
        }
    }
    
    override func layoutIfNeeded() {
        titleLayer.frame = titleView.bounds
    }
    
    override func setNeedsLayout() {
        titleLayer.frame = titleView.bounds
    }
    
    override func setNeedsDisplay() {
        titleLayer.frame = titleView.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    lazy var titleLayer: CATextLayer = {
        let titleLayer = CATextLayer()
        titleLayer.contentsScale = UIScreen.main.scale
        titleLayer.foregroundColor = UIColor.black.cgColor
        titleLayer.backgroundColor = UIColor.red.cgColor
        titleLayer.alignmentMode = kCAAlignmentJustified
        titleLayer.isWrapped = true
        
        let font16 = UIFont.systemFont(ofSize: 11.0)
        let fontName: CFString = font16.fontName as CFString
        let fontRef: CGFont = CGFont(fontName)!
        titleLayer.font = fontRef
        titleLayer.fontSize = font16.pointSize
        return titleLayer
    }()
    
    private lazy var lineLayer: CAShapeLayer = {
        let grayColor = UIColor(red: 236.0/255.0, green: 239.0/255.0, blue: 243.0/255.0, alpha: 1).cgColor
        
        let lineLayer = CAShapeLayer()
        lineLayer.backgroundColor = grayColor
        return lineLayer
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    
    lazy var titleView: UIView = {
        let tempView = UIView()
        tempView.backgroundColor = .white
        return tempView
    }()
}
