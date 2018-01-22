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
//        let controller = CDEmoticonKeyboardController()
        textView.inputView = inputView
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        print(textView.inputView?.bounds)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func keyboardWillShow(notification : Notification) {
        
        
//        320/7
//        320,253 5s
//        375,258  6
//        375,275
//        414,226
//        414,271
//        print(notification.userInfo!["UIKeyboardBoundsUserInfoKey"])
    }


}

