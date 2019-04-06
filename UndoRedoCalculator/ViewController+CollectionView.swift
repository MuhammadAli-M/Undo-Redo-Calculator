//
//  ViewController+CollectionView.swift
//  UndoRedoCalculator
//
//  Created by Muhammad Adam on 4/6/19.
//  Copyright © 2019 Muhammad Adam. All rights reserved.
//


import UIKit

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
