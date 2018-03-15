//
//  EmoticonPackage.swift
//  CDEmoticonKeyboard
//
//  Created by dong cheng on 2018/3/15.
//  Copyright © 2018年 dong cheng. All rights reserved.
//

import UIKit

class EmoticonPackage: NSObject {
    var emoticons : [Emoticon] = [Emoticon]()
    init(identifier : String) {
        super.init()
        let filePath = Bundle.main.path(forResource: "\(identifier)/info.plist", ofType: nil, inDirectory: "Emoticons.bundle")
        if let filePath = filePath, let arr = NSArray(contentsOfFile: filePath) as? Array<[String : String]> {
            for dict in arr {
                emoticons.append(Emoticon(dict: dict, identifier: identifier))
            }
        }
    }
}
