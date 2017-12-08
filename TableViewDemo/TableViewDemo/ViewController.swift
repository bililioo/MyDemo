//
//  ViewController.swift
//  TableViewDemo
//
//  Created by Bin on 2017/9/12.
//  Copyright © 2017年 Urun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "ArticleList"
        self.view.backgroundColor = .white
        self.view.addSubview(articleTableView)
        articleTableView.snp.makeConstraints {
            $0.edges.equalTo(self.view)
        }

        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    lazy var articleTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    }()

    lazy var list: Array<cellModel> = {
        let model1 = cellModel.init(title: "i am title", id: 1)
        let model2 = cellModel.init(title: "我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题", id: 2)
        let arr = [model1, model2, model1, model2, model1, model2, model1, model2, model1, model2, model1, model2, model1, model2, model1, model2]
        return arr
    }()
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let id = "NoPic"
        var cell: ArticleCell? = tableView.dequeueReusableCell(withIdentifier: id) as? ArticleCell
        if cell == nil {
            cell = ArticleCell(style: .default, reuseIdentifier: id)
        }
//        cell?.titleLabel.text = list[indexPath.row].title
        cell?.title = list[indexPath.row].title
        
        return cell!
    }
    
}
