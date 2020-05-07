//
//  RegisterController.swift
//  AquaplusAppStoryBoards
//
//  Created by David Mendes Da Silva on 29/04/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import Foundation
import UIKit
import JGProgressHUD
import Alamofire

class RegisterController: UIViewController{
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func handleSignup(_ sender: Any) {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Registering"
        hud.show(in: view)
        
        guard let fullName = fullNameTextField.text else { return }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Service.shared.signUp(fullName: fullName, emailAddress: email, password: password) { (res) in
            
            hud.dismiss(animated: true)
            
            switch res {
            case .failure(let err):
                print("Failed to sign up:", err)
                self.errorLabel.isHidden = false
            case .success:
                print("Successfully signed up")
                self.dismiss(animated: true)
            }
        }
    }
    override func viewDidLoad() {
    super.viewDidLoad()
        errorLabel.isHidden = true
    }
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
