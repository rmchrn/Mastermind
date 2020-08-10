//
//  ViewController.swift
//  Mastermind
//
//  Created by Ramcharan Reddy Gaddam on 10/08/20.
//  Copyright © 2020 Ramcharan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - outlets
    @IBOutlet weak var letter1Background: UIView!
    @IBOutlet weak var letter1input: UITextField!
    @IBOutlet weak var letter2Background: UIView!
    @IBOutlet weak var letter2input: UITextField!
    @IBOutlet weak var letter3Background: UIView!
    @IBOutlet weak var letter3input: UITextField!
    @IBOutlet weak var letter4Background: UIView!
    @IBOutlet weak var letter4input: UITextField!
    @IBOutlet weak var validationStatusLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    //MARK: - properties
    var randomString: String?
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        validationStatusLabel.isHidden = true
        initialSetupForTextfields()
        checkButton.setTitle("Check", for: UIControl.State.normal)
        checkButton.setTitle("Replay", for: UIControl.State.selected)
        
        randomString = String.generateRandomWord(ofLength: 4)
        
        debugPrint(randomString ?? "random string has not generated")
    }
    
    private func initialSetupForTextfields() {
        letter1input.delegate = self
        letter2input.delegate = self
        letter3input.delegate = self
        letter4input.delegate = self
        letter1input.becomeFirstResponder()
        
        letter1input.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControl.Event.editingChanged)
        letter2input.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControl.Event.editingChanged)
        letter3input.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControl.Event.editingChanged)
        letter4input.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(sender: UITextField) {
        switch sender {
        case letter1input:
            letter2input.becomeFirstResponder()
        case letter2input:
            letter3input.becomeFirstResponder()
        case letter3input:
            letter4input.becomeFirstResponder()
        default:
            break
        }
    }

    @IBAction func checkAction(_ sender: Any) {
        if checkButton.isSelected {
            replayAction()
            return
        }
        guard let letter1 = letter1input.text, let letter2 = letter2input.text, let letter3 = letter3input.text, let letter4 = letter4input.text, (letter1.count == 1 && letter2.count == 1 && letter3.count == 1 && letter4.count == 1) else {
            self.validationStatusLabel.text = "Please make sure you filled all the boxes"
            self.validationStatusLabel.isHidden = false
            return
        }
        validationStatusLabel.isHidden = true
        if randomString!.charAt(index: 0) == letter1.uppercased().first! {
            letter1Background.backgroundColor = UIColor.green
        } else if randomString!.contains(letter1.uppercased()) {
            letter1Background.backgroundColor = UIColor.orange
        } else {
            letter1Background.backgroundColor = UIColor.red
        }
        
        if randomString!.charAt(index: 1) == letter2.uppercased().first! {
            letter2Background.backgroundColor = UIColor.green
        } else if randomString!.contains(letter2.uppercased()) {
            letter2Background.backgroundColor = UIColor.orange
        } else {
            letter2Background.backgroundColor = UIColor.red
        }
        
        if randomString!.charAt(index: 2) == letter3.uppercased().first! {
            letter3Background.backgroundColor = UIColor.green
        } else if randomString!.contains(letter3.uppercased()) {
            letter3Background.backgroundColor = UIColor.orange
        } else {
            letter3Background.backgroundColor = UIColor.red
        }
        
        if randomString!.charAt(index: 3) == letter4.uppercased().first! {
            letter4Background.backgroundColor = UIColor.green
        } else if randomString!.contains(letter4.uppercased()) {
            letter4Background.backgroundColor = UIColor.orange
        } else {
            letter4Background.backgroundColor = UIColor.red
        }
        
        checkButton.isSelected = !checkButton.isSelected
    }
    
    func replayAction() {
        randomString = String.generateRandomWord(ofLength: 4)
        debugPrint(randomString ?? "random string has not generated")
        
        letter1Background.backgroundColor = .white
        letter2Background.backgroundColor = .white
        letter3Background.backgroundColor = .white
        letter4Background.backgroundColor = .white
        
        letter1input.text = ""
        letter2input.text = ""
        letter3input.text = ""
        letter4input.text = ""
        
        letter1input.becomeFirstResponder()
        checkButton.isSelected = !checkButton.isSelected
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
