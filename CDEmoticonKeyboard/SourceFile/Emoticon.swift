//
//  Emoticon.swift
//  CDEmoticonKeyboard
//
//  Created by dong cheng on 2018/3/15.
//  Copyright © 2018年 dong cheng. All rights reserved.
//

import UIKit

class Emoticon: NSObject {
    ///在swift3中，编译器自动推断@objc，换句话说，它自动添加@objc
    ///在swift4中，编译器不再自动推断，你必须显式添加@objc
    @objc var type : String?
    @objc var code : String?{
        didSet{
            guard let code = code else {
                return
            }
            
            let scaner = Scanner(string: code)
            var value : UInt32 = 0
            scaner.scanHexInt32(&value)
            let c = Character.init(UnicodeScalar.init(value)!)
            emojiCode = String.init(c)
        }
    }
    @objc var chs : String?
    @objc var cht : String?
    @objc var gif : String?
    @objc var png : String?{
        didSet{
            guard let png = png else {
                return
            }
            pngPath = Bundle.main.bundlePath + "/Emoticons.bundle/" + "\(self.identifier!)/\(png)"
        }
    }
    
    private var identifier : String?
    
    private(set) var pngPath : String?
    
    private(set) var emojiCode : String?
    
    init(dict : [String : String], identifier : String) {
        super.init()
        self.identifier = identifier
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    override var description: String {
        return "code : \(String(describing: code)),chs : \(String(describing: chs)),pngPath : \(String(describing: pngPath)),emojiCode : \(String(describing: emojiCode))"
    }
}
