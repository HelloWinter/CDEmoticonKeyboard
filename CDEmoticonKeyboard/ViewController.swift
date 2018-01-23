//
//  ViewController.swift
//  CDEmoticonKeyboard
//
//  Created by dong cheng on 2018/1/20.
//  Copyright © 2018年 dong cheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var textView : UITextView = {
        let textView = UITextView()
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textView)
        textView.frame = self.view.bounds
        let inputView = CDEmoticonKeyboardInputView()//
        textView.inputView = inputView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

