//
//  AddWordViewController.swift
//  TDL0308
//
//  Created by DaWoon Jeong on 2022/03/10.
//

import Foundation
import UIKit

protocol AddWordViewDelegate: AnyObject {
    func didSelectRegister(word: Word)
}


extension UIColor{
    class var PlColor: UIColor? {return UIColor(named:"plcolor")}
}


class AddWordViewController: UIViewController, UITextFieldDelegate {
    
    

    @IBOutlet weak var doneBtn: UIButton!
    
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var meaningTextFIeld: UITextField!
    
    weak var delegate: AddWordViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.doneBtn.setTitleColor(UIColor.PlColor, for: .normal)
        self.doneBtn.setTitle("저장", for: .normal)
        self.doneBtn.isEnabled = false
        configureInputField()
        wordTextField.becomeFirstResponder()
        
    }
    

    @IBAction func doneBtnTapped(_ sender: UIButton!) {
        guard let word = self .wordTextField.text else {return}
        guard let meaning = self.meaningTextFIeld.text else {return}
        let words = Word(word: word, meaning: meaning)
        self.delegate?.didSelectRegister(word: words)
        self.dismiss(animated: true, completion: nil)
        
                
    }
    
    
    func showKeyboard() {

        wordTextField.becomeFirstResponder()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func configureInputField() {
        self.wordTextField.delegate = self
        self.meaningTextFIeld.addTarget(self, action: #selector(wordTextFieldDidChanged(_:)), for: .editingChanged)
        self.wordTextField.addTarget(self, action: #selector(meaningTextFieldDidChanged), for: .editingChanged)
        
    }
    
    
    @objc private func wordTextFieldDidChanged(_ textField: UITextField ) {
        self .validateInputField()
    }
    
    @objc private func meaningTextFieldDidChanged(_ textField: UITextField) {
        self.validateInputField()
    }
    
    private func validateInputField() {
        self.doneBtn.isEnabled = !(self.wordTextField.text?.isEmpty ?? true) &&
        !(self.meaningTextFIeld.text?.isEmpty ?? true)

    }
    
}

extension AddWordViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.validateInputField()
        
    }
    
}
