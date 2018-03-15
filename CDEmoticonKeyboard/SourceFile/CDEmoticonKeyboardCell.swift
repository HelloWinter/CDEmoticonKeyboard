//
//  CDEmoticonKeyboardCell.swift
//  CDEmoticonKeyboard
//
//  Created by dong cheng on 2018/3/15.
//  Copyright © 2018年 dong cheng. All rights reserved.
//

import UIKit

class CDEmoticonKeyboardCell: UICollectionViewCell {
    
    private lazy var btn : UIButton = {
        let btn = UIButton()
        btn.isUserInteractionEnabled = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(btn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellData(emoticon : Emoticon?) -> Void {
        guard let emoticon = emoticon  else {
            return
        }
        btn.setImage(UIImage(contentsOfFile: emoticon.pngPath ?? ""), for: .normal)
        btn.setTitle(emoticon.emojiCode ?? "", for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btn.frame = contentView.bounds
    }
}
