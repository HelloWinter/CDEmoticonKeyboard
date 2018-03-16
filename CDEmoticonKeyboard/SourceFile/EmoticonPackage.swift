//
//  EmoticonPackage.swift
//  CDEmoticonKeyboard
//
//  Created by dong cheng on 2018/3/15.
//  Copyright © 2018年 dong cheng. All rights reserved.
//

import UIKit
///单页列数
let single_page_Column : Int = 7
//单页行数
let single_page_Row : Int = 3

class EmoticonPackage: NSObject {
    
    var emoticons : [Emoticon] = [Emoticon]()
    
    init(identifier : String) {
        super.init()
        if identifier.count == 0 {
            addEmptyEmoticon(isRecently: true)
            return
        }
        let filePath = Bundle.main.path(forResource: "\(identifier)/info.plist", ofType: nil, inDirectory: "Emoticons.bundle")
        if let filePath = filePath, let arr = NSArray(contentsOfFile: filePath) as? Array<[String : String]> {
            var index : Int = 0
            for dict in arr {
                emoticons.append(Emoticon.init(.Normal,dict,identifier))
                index = index + 1
                if index == single_page_Column * single_page_Row - 1 {
                    emoticons.append(Emoticon.init(.Delete))//添加删除按钮
                    index = 0
                }
            }
            //添加空白表情
            addEmptyEmoticon(isRecently: false)
        }
    }
    
    private func addEmptyEmoticon(isRecently : Bool){
        let remain = emoticons.count % (single_page_Column * single_page_Row)
        if remain == 0 && !isRecently {
            return
        }
        for _ in remain..<(single_page_Column * single_page_Row - 1) {
            emoticons.append(Emoticon.init(.Empty))
        }
        emoticons.append(Emoticon.init(.Delete))
    }
}
