//
//  LoginView.swift
//  Poland
//
//  Created by DaWoon Jeong on 2022/04/06.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase




class LoginView: UIViewController{

    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    var delegate: Mydelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.layer.borderColor = UIColor.PlColor?.cgColor
        emailTextField.layer.borderWidth = 1
        emailTextField.clipsToBounds = true
        emailTextField.layer.cornerRadius = 10
        emailTextField.keyboardType = .emailAddress
        
        passwordTextField.layer.borderColor = UIColor.PlColor?.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.clipsToBounds = true
        passwordTextField.layer.cornerRadius = 10
        
        loginBtn.setTitleColor(UIColor.PlColor, for: .normal)
        loginBtn.clipsToBounds = true
        loginBtn.layer.borderColor = UIColor.PlColor?.cgColor
        loginBtn.layer.cornerRadius = 5
        loginBtn.layer.borderWidth = 1
        
        

        
        self.emailTextField.becomeFirstResponder()
        
    }
//
//    override func viewWillAppear(_ animated: Bool){  // 회원 중복 확인
//        super.viewWillAppear(animated)
//
//        if let user = Auth.auth().currentUser{
//
//
//
//        }
//
//
//    }
//
    
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { user, error in
            if user != nil {
                self.delegate?.loginData()
                self.navigationController?.popViewController(animated: true)                
                print("로그인 성공")
                
                
 
            }else{
                print("로그인 실패")
             
                let sheet = UIAlertController(title: "로그인 실패", message: "이메일과 비밀번호를 확인해주세요", preferredStyle: .alert)
                sheet.addAction(UIAlertAction(title: "확인", style: .destructive, handler: nil))
                self.present(sheet, animated: true, completion: nil)
            }
        }
        
    }
    

    
    
    
    //    private func LoginCompleteController(){
    //        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    //        let LoginCompleteController = storyboard.instantiateViewController(identifier: "LoginCompleteController")
    //        LoginCompleteController.modalPresentationStyle = .fullScreen
    //        self.navigationController?.show(LoginCompleteController, sender: nil)
    //
    //    }
    
}


extension LoginView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
