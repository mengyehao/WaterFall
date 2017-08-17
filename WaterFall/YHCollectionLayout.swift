//
//  YHCollectionLayout.swift
//  WaterFlow
//
//  Created by meng on 2017/8/17.
//  Copyright © 2017年 meng. All rights reserved.
//

import UIKit


protocol YHCollectionLayoutDelegate {
    func layoutHeight(at index : IndexPath, width:CGFloat) -> CGFloat
}

class YHCollectionLayout: UICollectionViewLayout {
    
    var arrList = [UICollectionViewLayoutAttributes]() //存储所有item的Attribute
    var dict = [Float:Float]()                         //存储每列的长度
    var sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
    var columnSpace : CGFloat = 0
    var rowSpace : CGFloat = 0
    var column : Int  //几列 
    var delegate : YHCollectionLayoutDelegate?
    
    init(column : Int) {
        self.column = column
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        for i in 0..<self.column{
           dict[Float(i)] = 0
        }
        self.arrList.removeAll()
        let count  = self.collectionView?.numberOfItems(inSection: 0)
        
        if let count = count {
            for i in 0..<count{
                let atrr = self.layoutAttributesForItem(at: IndexPath(row: i, section: 0))
                if atrr != nil {
                    self.arrList.append(atrr!)
                }
            }
        }
       
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.arrList
    }
    
    override var collectionViewContentSize: CGSize{
        var sizeHeight : Float = 0
        self.dict.forEach { (_ : Float, value: Float) in
            sizeHeight = max(sizeHeight, value)
        }
        return CGSize(width: self.collectionView!.frame.size.width, height: CGFloat(sizeHeight) + self.sectionInset.bottom)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let layout = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)

        let collectionViewWidth = self.collectionView!.frame.size.width;
        

        let width = (collectionViewWidth - self.sectionInset.left - self.sectionInset.right - (CGFloat(self.column - 1)) * self.columnSpace) / CGFloat(self.column);
        
        var  height : CGFloat = 0;
        
        if self.delegate != nil {
            height = self.delegate!.layoutHeight(at: indexPath, width: width)
        }
        
        var minKey:Float = 0
        dict.forEach { (key: Float, value: Float) in
            if key != minKey && value < dict[minKey]!{
                minKey = key
            }
        }
  
        let frameX = self.sectionInset.left + (self.columnSpace + width) * CGFloat(minKey);
        let frameY =  CGFloat(self.dict[minKey]!) + self.rowSpace;
        layout.frame = CGRect.init(x: frameX, y: frameY, width: width, height: height);
        
        dict[minKey] = Float(layout.frame.maxY)
        
        return layout
    }
}
