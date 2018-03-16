//
//  CDEmoticonKeyboardInputView.swift
//  CDEmoticonKeyboard
//
//  Created by dong cheng on 2018/1/21.
//  Copyright © 2018年 dong cheng. All rights reserved.
//

import UIKit

private let CDEmoticonKeyboardCellIdentifier = "CDEmoticonKeyboardCellIdentifier"
private let item_W_H = (UIScreen.main.bounds.width)/CGFloat(single_page_Column)
private let toolbar_item_base : Int = 1234

class CDEmoticonKeyboardInputView: UIView,UICollectionViewDataSource,UICollectionViewDelegate{
    
    var emoticonClosure : ((_ emoticon : Emoticon) -> ())?

    private lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CDEmoticonKeyboardFlowLayout())
        collectionView.backgroundColor = UIColor.purple
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CDEmoticonKeyboardCell.self, forCellWithReuseIdentifier: CDEmoticonKeyboardCellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var toolBar : UIToolbar = {
        let toolBar = UIToolbar()
        let titles = ["最近","默认","emoji","浪小花"]
        var barButtonItems = [UIBarButtonItem]()
        for (index,title) in titles.enumerated() {
            let titleItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(itemClick(item:)))
            titleItem.tintColor = UIColor.orange
            titleItem.tag = index + toolbar_item_base
            barButtonItems.append(titleItem)
            let flexItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            barButtonItems.append(flexItem)
        }
        barButtonItems.removeLast()
        toolBar.items = barButtonItems
        return toolBar
    }()
    
    fileprivate lazy var manager : EmoticonManager = {
        let manager = EmoticonManager()
        return manager
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: item_W_H * CGFloat(single_page_Row) + 1 + 44))
        addSubview(collectionView)
        addSubview(toolBar)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height - 44)
        toolBar.frame = CGRect(x: 0, y: collectionView.frame.maxY, width: self.frame.width, height: 44)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        toolBar.translatesAutoresizingMaskIntoConstraints = false
//        let views : [String : Any] = ["toolbar" : toolBar,"collectionview" : collectionView]
//        var cons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[toolbar]-0-|", options: [], metrics: nil, views: views)
//        cons += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[collectionview]-0-[toolbar]-0-|", options: [.alignAllLeft,.alignAllRight], metrics: nil, views: views)
//        addConstraints(cons)
    }
    
    @objc private func itemClick(item : UIBarButtonItem){
        let indexPath = IndexPath(item: 0, section: item.tag - toolbar_item_base)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func insertRecentlyEmoticon(_ emoticon : Emoticon){
        if emoticon.emoticonType != .Normal {
            return
        }
        if manager.packages.first!.emoticons.contains(emoticon) {
            manager.packages.first!.emoticons.remove(at: manager.packages.first!.emoticons.index(of: emoticon)!)
        }else{
            manager.packages.first!.emoticons.remove(at: manager.packages.first!.emoticons.count - 2)
        }
        manager.packages.first!.emoticons.insert(emoticon, at: 0)
    }
    
}

extension CDEmoticonKeyboardInputView {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.manager.packages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let package = self.manager.packages[section]
        return package.emoticons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CDEmoticonKeyboardCellIdentifier, for: indexPath) as! CDEmoticonKeyboardCell
//        cell.contentView.backgroundColor = indexPath.row % 2 == 0 ? UIColor.red : UIColor.blue
        let package = self.manager.packages[indexPath.section]
        cell.setupCellData(emoticon: package.emoticons[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let package = self.manager.packages[indexPath.section]
        let emoticon = package.emoticons[indexPath.row]
        switch emoticon.emoticonType {
        case .Normal:
            insertRecentlyEmoticon(emoticon)
            collectionView.reloadData()
            if let closure = self.emoticonClosure {
                closure(emoticon)
            }
        case .Delete:
            if let closure = self.emoticonClosure {
                closure(emoticon)
            }
        default:
            break
        }
    }
}

class CDEmoticonKeyboardFlowLayout : UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        itemSize = CGSize(width: item_W_H, height: item_W_H)
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .horizontal
    }
    
}
