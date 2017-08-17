//
//  MyViewController.swift
//  WaterFlow
//
//  Created by meng on 2017/8/17.
//  Copyright © 2017年 meng. All rights reserved.
//

import UIKit


struct DataModel {
    var title : String
    var imageUrl : String
    var height : Float
}

class MyViewController: UIViewController,YHCollectionLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    
    let cellId = "MyCollectionViewCell"
    
    var collectionView : UICollectionView?
    var layout : YHCollectionLayout?

    var data = [DataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "信息流测试"
        
        self.layout = YHCollectionLayout(column: 2)
        self.layout?.columnSpace = 10
        self.layout?.rowSpace = 10
        self.layout?.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        self.layout?.delegate = self
        

        
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: self.layout!)
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        view.addSubview(self.collectionView!)
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView?.register(UINib.init(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
        
        getData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MyCollectionViewCell
        let  model = data[indexPath.row]
        cell.titleLabel.text = model.title
        
        return cell
    }
    
    //MARK: YHCollectionLayoutDelegate
    
    func layoutHeight(at index: IndexPath, width: CGFloat) -> CGFloat {
        if index.row >= data.count {
            return 0
        }
        
        let  model = data[index.row]
        
        return CGFloat(model.height)
        
    }
    
    
    func getData()  {
        
  
        for i in 0..<100{
            let height = Float(arc4random() % 200 + 80)

            let model = DataModel(title:"title" + String(i)  , imageUrl: "", height: height)
            self.data.append(model)
        }
        self.collectionView?.reloadData()

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
