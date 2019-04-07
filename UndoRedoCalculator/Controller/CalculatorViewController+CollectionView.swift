//
//  ViewController+CollectionView.swift
//  UndoRedoCalculator
//
//  Created by Muhammad Adam on 4/6/19.
//  Copyright © 2019 Muhammad Adam. All rights reserved.
//


import UIKit

extension CalculatorViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout{
            let xInset: CGFloat = 5
            let yInset: CGFloat = 5
            let cellSpacing: CGFloat = 5
            let lineSpacing: CGFloat = 5
            layout.minimumInteritemSpacing = cellSpacing
            layout.minimumLineSpacing = lineSpacing
            layout.sectionInset = UIEdgeInsets(top: yInset, left: xInset, bottom: yInset, right: xInset)
        }
        
        let textSize = operationsHistoryList[indexPath.row]?.description.size(withAttributes:[
            NSAttributedStringKey.font : OperationCollectionViewCell.labelFont])
        return CGSize(width: (textSize?.width ?? 0) + 30, height: 50)
    }
}


extension CalculatorViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return operationsHistoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OperationCollectionViewCell.identifier, for: indexPath) as! OperationCollectionViewCell
        cell.operationLabel.text = operationsHistoryList[indexPath.row]?.description
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard var operation = operationsHistoryList[indexPath.row]?.reverse() else{return}
        operation.first = appResult.get()
        calculator.doOperation(operation: &operation)
        appResult.set(calculator.result)
        print("result: \(appResult.get())")
        operationsHistoryList.remove(at: indexPath.row)
        collectionView.reloadData()
    }
    
    func setupCollectionView(){
        historyCollectionView.delegate = self
        historyCollectionView.dataSource = self
        historyCollectionView.register(UINib(nibName: OperationCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: OperationCollectionViewCell.identifier)
    }
}
