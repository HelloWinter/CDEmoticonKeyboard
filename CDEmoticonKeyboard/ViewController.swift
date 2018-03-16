//
//  ViewController.swift
//  CDEmoticonKeyboard
//
//  Created by dong cheng on 2018/1/20.
//  Copyright © 2018年 dong cheng. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "图文混排Demo"
    }
    
    @IBAction func releaseItemClick(_ sender: UIBarButtonItem) {
        let controller = ReleaseViewController(nibName: nil, bundle: nil)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

