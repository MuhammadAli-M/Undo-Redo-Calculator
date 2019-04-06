//
//  ViewController.swift
//  UndoRedoCalculator
//
//  Created by Muhammad Adam on 4/5/19.
//  Copyright © 2019 Muhammad Adam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
    
    var appResult = 0{ //TODO: Shared resource
        didSet{
            resultLabel.text = "\(appResult)"
        }
    }
    var mathOperator:MathOperation?
    var operatorButtons:[UIButton]{
        get{
            return [plusButton, minusButton, multiplyButton, divisionButton]
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
        updateEqualButtonState()
    }
    
    @IBAction func mathOperatorDidTapped(_ sender: UIButton) {
        print("Operator did tapped")
        if let mathOp =  MathOperation.operationForString(stringOperator: sender.titleLabel?.text ?? ""){
            self.mathOperator = mathOp
        }
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
            let number = Int(numberString),
            let mathOperator = mathOperator
            else{return}
        
        var operation = Operation(first: appResult, second: number, mathOp: mathOperator)
        calculator.doOperation(operation: &operation)
        appResult = calculator.result
        print("result:  \(appResult)")
        
        secondOperandTextField.text = ""
        deselectAllOperator()
        updateUndoRedoButtonStates()
        equalButton.isEnabled = false
    }
    
    @IBAction func undoButtonDidTapped(_ sender: UIButton) {
        if calculator.canRedo(){
        calculator.undo()
        appResult = calculator.result
        print("result:  \(appResult)")
        }
        updateUndoRedoButtonStates()
    }
    
    @IBAction func redoButtonDidTapped(_ sender: UIButton) {
        if calculator.canRedo(){
        calculator.redo()
        appResult = calculator.result
        print("result:  \(appResult)")
        }
        updateUndoRedoButtonStates()
    }
    
    func updateUndoRedoButtonStates(){
        redoButton.isEnabled = calculator.canRedo()
        undoButton.isEnabled = calculator.canUndo()
    }
}

