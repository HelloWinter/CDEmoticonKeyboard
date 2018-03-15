//
//  EmoticonManager.swift
//  CDEmoticonKeyboard
//
//  Created by dong cheng on 2018/3/15.
//  Copyright © 2018年 dong cheng. All rights reserved.
//

import UIKit

class EmoticonManager: NSObject {
    var packages : [EmoticonPackage] = [EmoticonPackage]()
    
    override init() {
        super.init()
        packages.append(EmoticonPackage(identifier: ""))
        packages.append(EmoticonPackage(identifier: "com.sina.default"))
        packages.append(EmoticonPackage(identifier: "com.apple.emoji"))
        packages.append(EmoticonPackage(identifier: "com.sina.lxh"))
    }
    
}
