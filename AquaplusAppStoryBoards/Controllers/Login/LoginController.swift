//
//  ViewController.swift
//  AquaplusAppStoryBoards
//
//  Created by David Mendes Da Silva on 29/04/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import UIKit
import JGProgressHUD
import Alamofire
import Loaf

class LoginController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {
          let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = "Logging in"
                hud.show(in: view)
                
                guard let email = emailTextField.text else { return }
                guard let password = passwordTextField.text else { return }
                
                errorLabel.isHidden = true
                
                Service.shared.login(email: email, password: password) { (res) in
                    hud.dismiss()
                    
                    switch res {
                    case .failure(let error):
                        Loaf(error.localizedDescription, state: .error, sender: self).show()

                        self.errorLabel.isHidden = false
                        self.errorLabel.text = "Your credentials are not correct, please try again."
                    case .success:
                        Loaf("Signe In", state: .success, sender: self).show()

                        self.dismiss(animated: true, completion: {
                            self.presentingViewController?.dismiss(animated: true, completion: nil)
                        })        //                self.homeController?.fetchposts()
                    }
                }
//        let hud = JGProgressHUD(style: .dark)
//        hud.textLabel.text = "Logging in"
//        hud.show(in: view)
//
//        guard let email = emailTextField.text else { return }
//        guard let password = passwordTextField.text else { return }
//
//
//
//        let url = "http://localhost:1337/api/v1/entrance/login"
//        let params = ["emailAddress": email, "password": password]
//        AF.request(url, method: .put, parameters: params, encoding: URLEncoding())
//            .validate(statusCode: 200..<300)
//            .responseData { (dataResponse) in
//                hud.dismiss()
//
//                if let _ = dataResponse.error {
//                    self.errorLabel.isHidden = false
//                    self.errorLabel.text = "Your credentials are not correct, please try again."
//                    return
//                }
//
//                print("Successfully logged in.")
//                self.dismiss(animated: true)
//
//
//        }
//
    }
    
    
    
    
}

