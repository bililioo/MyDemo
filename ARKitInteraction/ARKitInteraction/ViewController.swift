//
//  ViewController.swift
//  ARKitInteraction
//
//  Created by Bin on 2017/12/11.
//  Copyright © 2017年 Orz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var sceneView: VirtualObjectARView!
    
    var focusSquare = FocusSquare()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

