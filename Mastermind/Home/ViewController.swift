//
//  ViewController.swift
//  Mastermind
//
//  Created by Ramcharan Reddy Gaddam on 10/08/20.
//  Copyright © 2020 Ramcharan. All rights reserved.
//

import UIKit

private enum Constants {
    static let checkButtonTitleUnSelectedState = "Check"
    static let checkButtonTitleSelectedState = "Replay"
    static let validationErrorMessage = "Please make sure you filled all the boxes"
    static let randomStringError = "random string has not generated"
}

class ViewController: UIViewController {
    
    //MARK: - outlets
    @IBOutlet weak var validationStatusLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet var letterInputs: [UITextField]!
    @IBOutlet var backgroundViews: [UIView]!
    
    //MARK: - properties
    var randomString: String?
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        validationStatusLabel.isHidden = true
        initialSetupForTextfields()
        checkButton.setTitle(Constants.checkButtonTitleUnSelectedState, for: UIControl.State.normal)
        checkButton.setTitle(Constants.checkButtonTitleSelectedState, for: UIControl.State.selected)
        
        randomString = String.generateRandomWord(ofLength: 4)
        
        debugPrint(randomString ?? Constants.randomStringError)
    }
    /**
     It will assign delegate and target to text fields
     */
    private func initialSetupForTextfields() {
        letterInputs.enumerated().forEach { (index,letterInput) in
            letterInput.delegate = self
            letterInput.tag = index+1
            letterInput.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControl.Event.editingChanged)
        }
        letterInputs.first?.becomeFirstResponder()
    }
    /**
     It is the target for textfield editing change event
     */
    @objc private func textFieldDidChange(sender: UITextField) {
        var nextInput: UITextField?
        if sender.tag < letterInputs.count {
            nextInput = letterInputs[sender.tag]
        }
        switch sender.tag {
        case 1:
            nextInput?.becomeFirstResponder()
        case 2:
            nextInput?.becomeFirstResponder()
        case 3:
            nextInput?.becomeFirstResponder()
        default:
            break
        }
    }
    /**
     check button action. it will check logic and change the corresponding background color
     */
    @IBAction func checkAction(_ sender: Any) {
        if checkButton.isSelected {
            replayAction()
            return
        }
        if !validateFields() {
            return
        }
        for i in 0..<4 {
            let enteredText = letterInputs[i].text ?? ""
            if randomString!.charAt(index: i) == enteredText.uppercased().first! {
                backgroundViews[i].backgroundColor = UIColor.green
            } else if randomString!.contains(enteredText.uppercased()) {
                backgroundViews[i].backgroundColor = UIColor.orange
            } else {
                backgroundViews[i].backgroundColor = UIColor.red
            }
        }
        checkButton.isSelected = !checkButton.isSelected
    }
    /**
     it will reset the game to play again
     */
    func replayAction() {
        randomString = String.generateRandomWord(ofLength: 4)
        debugPrint(randomString ?? Constants.randomStringError)
        
        backgroundViews.forEach { (view) in
            view.backgroundColor = .white
        }
        
        letterInputs.forEach { (letterInput) in
            letterInput.text = ""
        }
        letterInputs.first?.becomeFirstResponder()
        
        checkButton.isSelected = !checkButton.isSelected
    }
    /**
     it performs validations on text inputs
     */
    func validateFields() -> Bool {
        guard let letter1 = letterInputs[0].text, let letter2 = letterInputs[1].text, let letter3 = letterInputs[2].text, let letter4 = letterInputs[3].text, (letter1.count == 1 && letter2.count == 1 && letter3.count == 1 && letter4.count == 1) else {
            self.validationStatusLabel.text = Constants.validationErrorMessage
            self.validationStatusLabel.isHidden = false
            return false
        }
        validationStatusLabel.isHidden = true
        return true
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= 1
    }
}
