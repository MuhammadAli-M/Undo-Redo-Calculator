//
//  ViewController+UITextField.swift
//  UndoRedoCalculator
//
//  Created by Muhammad Adam on 4/6/19.
//  Copyright © 2019 Muhammad Adam. All rights reserved.
//

import UIKit

extension CalculatorViewController:UITextFieldDelegate{
    
    func setupTextView() {
        secondOperandTextField.delegate = self
        secondOperandTextField.keyboardType = .numberPad
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "-.0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
