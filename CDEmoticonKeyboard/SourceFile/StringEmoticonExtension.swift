//
//  StringEmoticonExtension.swift
//  CDEmoticonKeyboard
//
//  Created by dong cheng on 2018/3/17.
//  Copyright © 2018年 dong cheng. All rights reserved.
//

import UIKit

extension String{
    
    func emoticonAttributeString(font : UIFont) -> NSMutableAttributedString? {
        let pattern = "\\[.*?\\]"
        if let regular = try? NSRegularExpression(pattern: pattern, options: []) {
            let results = regular.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
            let attrMstr = NSMutableAttributedString(string: self)
            for result in ReverseSequence(array: results) {
                print(result)
                let subString = (self as NSString).substring(with: result.range)
                for package in EmoticonManager().packages {
                    for emoticon in package.emoticons {
                        if emoticon.chs == subString {
                            let attachment = NSTextAttachment()
                            attachment.image = UIImage(contentsOfFile: emoticon.pngPath!)
                            attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
                            let subAttrString = NSAttributedString(attachment: attachment)
                            attrMstr.replaceCharacters(in: result.range, with: subAttrString)
                        }
                    }
                }
            }
            return attrMstr
        }
        return nil
    }
    
}
