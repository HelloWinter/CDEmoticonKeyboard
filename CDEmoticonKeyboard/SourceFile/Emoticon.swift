//
//  Emoticon.swift
//  CDEmoticonKeyboard
//
//  Created by dong cheng on 2018/3/15.
//  Copyright © 2018年 dong cheng. All rights reserved.
//

import UIKit

enum EmoticonTypes {
    ///普通表情
    case Normal
    ///删除按钮
    case Delete
    ///空表情
    case Empty
}

class Emoticon: NSObject {
    ///这里在使用KVC赋值时，在swift4下会出现赋值都为空的情况，这是因为：
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
    
    private(set) var deletePngPath : String?
    
    private(set) var emoticonType : EmoticonTypes = .Normal
    
    ///正常表情
    init(_ emoticonType : EmoticonTypes,_ dict : [String : String]? = nil,_ identifier : String? = nil) {
        super.init()
        self.emoticonType = emoticonType
        switch emoticonType {
        case .Normal:
            if let dict = dict,let iden = identifier {
                self.identifier = iden
                setValuesForKeys(dict)
            }
        case .Delete:
            deletePngPath = "Emoticons.bundle/compose_emotion_delete"
        default:
            break
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    override var description: String {
        return "code : \(String(describing: code)),chs : \(String(describing: chs)),pngPath : \(String(describing: pngPath)),emojiCode : \(String(describing: emojiCode))"
    }
}
