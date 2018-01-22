//
//  CDEmoticonKeyboardController.swift
//  CDEmoticonKeyboard
//
//  Created by dong cheng on 2018/1/20.
//  Copyright © 2018年 dong cheng. All rights reserved.
//

import UIKit

private let CDEmoticonKeyboardCellIdentifier = "CDEmoticonKeyboardCellIdentifier"

class CDEmoticonKeyboardController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    private lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = UIColor.purple
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CDEmoticonKeyboardCellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
//        let top_bottom_margin =
//        collectionView.contentInset = UIEdgeInsets(top: <#T##CGFloat#>, left: <#T##CGFloat#>, bottom: <#T##CGFloat#>, right: <#T##CGFloat#>)
        return collectionView
    }()
    
    private lazy var toolBar : UIToolbar = {
        let toolBar = UIToolbar()
        return toolBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        view.addSubview(toolBar)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        let views : [String : Any] = ["toolbar" : toolBar,"collectionview" : collectionView]
        var cons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[toolbar]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        cons += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[collectionview]-0-[toolbar]-0-|", options: [.alignAllLeft,.alignAllRight], metrics: nil, views: views)
        view.addConstraints(cons)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

}

extension CDEmoticonKeyboardController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CDEmoticonKeyboardCellIdentifier, for: indexPath)
        //        cell.contentView.backgroundColor = indexPath.row % 2 == 0 ? UIColor.red : UIColor.blue
        cell.backgroundColor = UIColor.white
        return cell
    }
}

//class CDEmoticonKeyboardFlowLayout : UICollectionViewFlowLayout {
//
//    override func prepare() {
//        super.prepare()
//        let item_W_H = UIScreen.main.bounds.width / 7.0
//        itemSize = CGSize(width: item_W_H, height: item_W_H)
//        minimumInteritemSpacing = 0
//        minimumLineSpacing = 0
//        scrollDirection = .horizontal
//    }
//
//    override init() {
//        super.init()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}

