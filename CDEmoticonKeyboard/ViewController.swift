//
//  ViewController.swift
//  CDEmoticonKeyboard
//
//  Created by dong cheng on 2018/1/20.
//  Copyright © 2018年 dong cheng. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    private let cellIdentifier = "cellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "图文混排表情键盘Demo"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func releaseItemClick(_ sender: UIBarButtonItem) {
        let controller = ReleaseViewController(nibName: nil, bundle: nil)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataBaseManager.shared.queryTable().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        cell?.textLabel?.attributedText = DataBaseManager.shared.queryTable()[indexPath.row].emoticonAttributeString(font: (cell?.textLabel?.font)!)
        return cell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

