//
//  ViewController.swift
//  UndoRedoCalculator
//
//  Created by Muhammad Adam on 4/5/19.
//  Copyright © 2019 Muhammad Adam. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var secondOperandTextField: UITextField!
    @IBOutlet weak var historyCollectionView: UICollectionView!
    
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var redoButton: UIButton!
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var divisionButton: UIButton!
    
    @IBOutlet weak var equalButton: UIButton!
    
    var calculator = Calculator()
    var operationsHistoryList = SafeArray<Operation>() 
    
    var appResult = SafeFloat(0)
    
    var mathOperator:MathOperator?
    var operatorButtons:[UIButton]{
        get{
            return [plusButton, minusButton, multiplyButton, divisionButton]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculator.delegate = self
        setupResultLabel()
        setupTextView()
        setupCollectionView()
        updateUndoRedoButtonStates()
        updateEqualButtonState()
    }
    
    @IBAction func mathOperatorDidTapped(_ sender: UIButton) {
        if let mathOp =  MathOperator.from(stringOperator: sender.titleLabel?.text ?? ""){
            self.mathOperator = mathOp
        }
        print("Operator \(mathOperator?.description ?? "") did tapped")
        deselectAllOperator(except: sender.titleLabel?.text)
        updateEqualButtonState()
    }
    
    private func deselectAllOperator(except buttonText: String? = ""){
        
        operatorButtons.forEach { (button) in
            if button.titleLabel?.text != buttonText{
                button.isSelected = false
            }else{
                button.isSelected = true
            }
        }
    }
    
    func updateEqualButtonState(){
        let isAnyOpetatorButtonSelected = operatorButtons.contains { $0.isSelected == true}
        if secondOperandTextField.text != "" && isAnyOpetatorButtonSelected{
            equalButton.isEnabled = true
        }else{
            equalButton.isEnabled = false
        }
    }
    
    @IBAction func secondTextFieldEditingChanged(_ sender: Any) {
        updateEqualButtonState()
    }
    
    @IBAction func equalButtonDidTapped(_ sender: UIButton) {
        guard let numberString = secondOperandTextField.text,
            let number = Float(numberString),
            let mathOperator = mathOperator
            else{return}
        
        var operation = Operation(first: appResult.get(), second: number, mathOp: mathOperator)
        calculator.doOperation(operation: &operation)

        operationsHistoryList.insert(operation, at: 0)
        historyCollectionView.reloadData()
    }
    
    @IBAction func undoButtonDidTapped(_ sender: UIButton) {
        calculator.undo()
    }
    
    @IBAction func redoButtonDidTapped(_ sender: UIButton) {
        calculator.redo()
    }
    
    func updateUndoRedoButtonStates(){
        redoButton.isEnabled = calculator.canRedo()
        undoButton.isEnabled = calculator.canUndo()
    }
}


extension CalculatorViewController:SafeFloatDelegate{
    
    func setupResultLabel(){
        appResult.delegate = self
    }
    func safeFloatValueDidSet() {
        resultLabel.text = appResult.get().getCleanString
    }
}


extension CalculatorViewController : CalculatorDelegate{
    
    func operationDidDone(operation: Operation) {
        appResult.set(calculator.result ?? Float.nan) // TODO:Needs to be handled
        print("result:  \(appResult.get())")
        
        secondOperandTextField.text = ""
        deselectAllOperator()
        updateUndoRedoButtonStates()
        equalButton.isEnabled = false
    }
    
    func operationDidUndone(operation: Operation) {
        appResult.set(calculator.result ?? Float.nan) // TODO:Needs to be handled
        print("result:  \(appResult.get())")
        updateUndoRedoButtonStates()
    }
    
    func operationDidRedone(operation: Operation) {
        appResult.set(calculator.result ?? Float.nan) // TODO:Needs to be handled
        print("result:  \(appResult.get())")
        updateUndoRedoButtonStates()
    }
    
    
}
