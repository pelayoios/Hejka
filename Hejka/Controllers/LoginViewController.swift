//
//  LoginViewController.swift
//  Hejka
//
//  Created by Miguel Pelayo Mercado Caram on 3/29/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailView: UIView!

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var passwordView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailView.layer.cornerRadius = 10
        emailView.clipsToBounds = true
        
        passwordView.layer.cornerRadius = 10
        passwordView.clipsToBounds = true
 
    }
    

    @IBAction func loginBtnPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: "loginToChat", sender: self)
                }
            }
        }
    }
    

}
