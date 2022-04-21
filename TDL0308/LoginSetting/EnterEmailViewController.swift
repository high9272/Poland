//
//  EnterEmailViewController.swift
//  Poland
//
//  Created by DaWoon Jeong on 2022/04/05.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase


class EnterEmailViewController: UIViewController{
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var createBtn: UIButton!


    
    var delegate: Mydelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.emailTextField.delegate = self
        //        self.passwordTextField.delegate = self
        
        emailTextField.layer.borderColor = UIColor.PlColor?.cgColor
        emailTextField.layer.borderWidth = 1
        emailTextField.clipsToBounds = true
        emailTextField.layer.cornerRadius = 10
        emailTextField.keyboardType = .emailAddress
        self.emailTextField.becomeFirstResponder()
        
        passwordTextField.layer.borderColor = UIColor.PlColor?.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.clipsToBounds = true
        passwordTextField.layer.cornerRadius = 10
        
        createBtn.setTitleColor(.PlColor, for: .normal)
        createBtn.setTitleColor(UIColor.PlColor, for: .normal)
        createBtn.clipsToBounds = true
        createBtn.layer.borderColor = UIColor.PlColor?.cgColor
        createBtn.layer.cornerRadius = 5
        createBtn.layer.borderWidth = 1
        
        
        
        //emailTextField.becomeFirstResponder()
        
        
        //self.nextBtn.isEnabled = false
        
        self.navigationController?.navigationBar.tintColor = .PlColor
        
        
        
    }
    
//
//    override func viewWillAppear(_ animated: Bool){  // 회원 중복 확인
//        super.viewWillAppear(animated)
//
//        if let user = Auth.auth().currentUser{
//            emailTextField.placeholder = "이미 로그인이 되어있습니다"
//            passwordTextField.placeholder = "이미 로그인이 되어있습니다"
//        }
//
//
//    }
    
    
    @IBAction func createBtnTapped(_ sender: UIButton) {
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password:passwordTextField.text!) { user, error in
            if user != nil {
                self.delegate?.loginData()

                let alert = UIAlertController(title: "회원가입 완료!", message: nil, preferredStyle: .alert)

                
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { (alert:UIAlertAction!) in
                    self.navigationController?.popViewController(animated: true)
                }))
                
                self.present(alert, animated: true)
                
                
                
                }
       
            else {
                print("회원가입 실패")
                let alert = UIAlertController(title: "알림", message: "회원가입 실패", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler:    nil))
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        
        
    }
    
    
    
    
    
    
}


//extension EnterEmailViewController: UITextFieldDelegate {
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.view.endEditing(true)
//        return false
//
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        let isEmailEmpty = self.emailTextField.text == ""
//        let isPasswordEmpty = self.passwordTextField.text == ""
//        self.nextBtn.isEnabled = !isEmailEmpty && !isPasswordEmpty
//    }
//
//}
