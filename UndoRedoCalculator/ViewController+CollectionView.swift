//
//  ViewController+CollectionView.swift
//  UndoRedoCalculator
//
//  Created by Muhammad Adam on 4/6/19.
//  Copyright © 2019 Muhammad Adam. All rights reserved.
//


import UIKit

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout{
            //            let width = historyCollectionView.frame.size.width
            //            let numberOfColumns: CGFloat = 2
            let xInset: CGFloat = 5
            let yInset: CGFloat = 5
            let cellSpacing: CGFloat = 5
            let lineSpacing: CGFloat = 5
            layout.minimumInteritemSpacing = cellSpacing
            layout.minimumLineSpacing = lineSpacing
            layout.sectionInset = UIEdgeInsets(top: yInset, left: xInset, bottom: yInset, right: xInset)
            //            let cellWidth: CGFloat = (width - cellSpacing * (numberOfColumns-1) - xInset * 2 ) / numberOfColumns
            //
            //            return CGSize(width: cellWidth, height: cellWidth * 1.5)
            //        }
            //        return CGSize(width: 0, height: 0)
            
            
        }
        
        
        //        let fixedWidth = textView.frame.size.width
        //        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        //        textView.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        
        //        let label = UILabel(frame: CGRect.zero)
        //        label.text = "\\5"
        //        label.sizeToFit()
        //        return CGSize(width: label.frame.width + 60, height: 100)
        //
        let textSize = operationsHistoryList[indexPath.row].description.size(withAttributes:[
            NSAttributedStringKey.font : OperationCollectionViewCell.labelFont])
        return CGSize(width: textSize.width + 30, height: 50)
    }
}


extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return operationsHistoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OperationCollectionViewCell.identifier, for: indexPath) as! OperationCollectionViewCell
        cell.operationLabel.text = operationsHistoryList[indexPath.row].description
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var operation = operationsHistoryList[indexPath.row].reverse()
        operation.first = appResult
        calculator.doOperation(operation: &operation)
        appResult = calculator.result
        print("result: \(appResult)")
        operationsHistoryList.remove(at: indexPath.row)
        collectionView.reloadData()
    }
    
    func setupCollectionView(){
        historyCollectionView.delegate = self
        historyCollectionView.dataSource = self
        historyCollectionView.register(UINib(nibName: OperationCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: OperationCollectionViewCell.identifier)
    }
}
