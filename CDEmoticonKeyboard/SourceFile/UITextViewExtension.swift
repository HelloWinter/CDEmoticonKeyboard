//
//  UITextViewExtension.swift
//  CDEmoticonKeyboard
//
//  Created by dong cheng on 2018/3/16.
//  Copyright © 2018年 dong cheng. All rights reserved.
//

import UIKit

extension UITextView {
    
    func extractEmoticonString() -> String {
        let attrStr = NSMutableAttributedString(attributedString: self.attributedText)
        let range = NSRange(location: 0, length: attrStr.length)
        attrStr.enumerateAttribute(.attachment, in: range, options: []) {[weak attrStr] (attachment, subRange, _) in
            if let attachment = attachment as? EmoticonTextAttachment {
                attrStr?.replaceCharacters(in: subRange, with: attachment.emoticonText!)
            }
        }
        return attrStr.string
    }
    
    func insertEmoticon(_ emoticon : Emoticon){
        if emoticon.emoticonType == .Delete {
            deleteBackward()
            return
        }
        if let emoji = emoticon.emojiCode {
            replace((selectedTextRange!), withText: emoji)
            return
        }
        
        let attachment = EmoticonTextAttachment()
        attachment.emoticonText = emoticon.chs
        attachment.image = UIImage(contentsOfFile: emoticon.pngPath!)
        let font = self.font!
        attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight-5, height: font.lineHeight-5)
        let attachmentAttr = NSAttributedString(attachment: attachment)
        let attrStr = NSMutableAttributedString(attributedString: attributedText)
        let range = selectedRange
        attrStr.replaceCharacters(in: range, with: attachmentAttr)
        attributedText = attrStr
        //重置状态
        self.font = font
        selectedRange = NSRange(location: range.location + 1, length: 0)
    }
    
}
