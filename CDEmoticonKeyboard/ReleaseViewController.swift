//
//  ReleaseViewController.swift
//  CDEmoticonKeyboard
//
//  Created by dong cheng on 2018/3/16.
//  Copyright © 2018年 dong cheng. All rights reserved.
//

import UIKit


class ReleaseViewController: UIViewController {
    
    private lazy var textView : UITextView = {
        let textView = UITextView()
        textView.text = "点一下屏幕试试"
        textView.font = UIFont.systemFont(ofSize: 25)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textView)
        textView.frame = self.view.bounds
        let inputView = CDEmoticonKeyboardInputView()//
        inputView.emoticonClosure = {[weak self] (emoticon : Emoticon) in
            self?.textView.insertEmoticon(emoticon)
        }
        textView.inputView = inputView
        setupNavigationItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupNavigationItem() -> Void {
        let barButtonItem = UIBarButtonItem(title: "发布", style: .plain, target: self, action: #selector(releaseText))
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc private func releaseText(){
        print(textView.extractEmoticonString())
        do {
            try DataBaseManager.shared.insertTable(content: textView.extractEmoticonString())
            navigationController?.popViewController(animated: true)
        } catch {
            print("INSERT TABLE ERROR : \(error.localizedDescription)")
            DataBaseManager.shared.closeDataBase()
        }
//        let str = textView.extractEmoticonString().emoticonAttributeString(font: textView.font!)
        
    }

}
