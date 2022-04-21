//
//  LoginView.swift
//  Poland
//
//  Created by DaWoon Jeong on 2022/03/31.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth


protocol Mydelegate {
    func loginData()

}


class UserView: UIViewController,Mydelegate{

    
    
    func loginData() {
        doLogin.isHidden = true
        doLogout.isHidden = false
        createUser.isHidden = true
        userName.isHidden = false
    }
    
    
    @IBOutlet weak var createUser: UIButton!
    @IBOutlet weak var doLogin: UIButton!
    @IBOutlet weak var doLogout: UIButton!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var loginUIView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        emailLogin.layer.borderWidth = 1
        //        emailLogin.layer.borderColor = UIColor.PlColor?.cgColor
        createUser.layer.cornerRadius = 7
        createUser.clipsToBounds = true
        createUser.tintColor = .PlColor
        
        self.navigationController?.navigationBar.tintColor = .PlColor
        
        
        doLogin.setTitleColor(UIColor.PlColor, for: .normal)
        doLogin.setTitle("로그인", for: .normal)
        doLogin.layer.borderWidth = 1
        doLogin.layer.borderColor = UIColor.PlColor?.cgColor
        doLogin.layer.cornerRadius = 7
        doLogin.clipsToBounds = true
        
        
        doLogout.setTitleColor(UIColor.systemRed, for: .normal)
        
        if Auth.auth().currentUser != nil {
            doLogout.isHidden = false
            doLogin.isHidden = true
            createUser.isHidden = true

            // User is signed in.
            // ...
        } else {
            doLogout.isHidden = true
            // No user is signed in.
            // ...
        }

        userName.isHidden = true
        loginUIView.layer.borderWidth = 1
        loginUIView.layer.borderColor = UIColor.PlColor?.cgColor
        loginUIView.clipsToBounds = true
        loginUIView.layer.cornerRadius = 7
    
        
       
   
    }
     
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        let displayName = Auth.auth().currentUser?.email ?? ""
//
//        //userName.text = displayName
//
//        self.userName.text = """
//        안녕하세요!😊
//        \(displayName)님
//        """
//
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let displayName = Auth.auth().currentUser?.email ?? ""
        
        //userName.text = displayName
        
        self.userName.text = """
        안녕하세요!😊
        \(displayName)님
        """
        
        
    }
    
    @IBAction func doLoginBtn(_ sender: UIButton) {
        
        guard let VC = self.storyboard?.instantiateViewController(withIdentifier: "LoginView") as? LoginView else {return}
        
        navigationController?.pushViewController(VC, animated: true)
        VC.delegate = self
        
      
    }
    
    
    @IBAction func LogoutBtn(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            
        } catch let signOutError as NSError {
            print(signOutError)
        }
        
        print("로그아웃 완료")
        let alert = UIAlertController(title: "알림", message: "로그아웃 완료", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { action in
            
        })
        self.present(alert, animated: true, completion: nil)
        doLogin.isHidden = false
        doLogout.isHidden = true
        createUser.isHidden = false
        userName.isHidden = true
        
    }
     
    @IBAction func createUserBtn(_ sender: UIButton) {
        
        guard let VC = self.storyboard?.instantiateViewController(withIdentifier: "EnterEmailViewController") as? EnterEmailViewController else {return}
        
        navigationController?.pushViewController(VC, animated: true)
        
        VC.delegate = self
       
       
        
        
    }
    
    
    
    
}


