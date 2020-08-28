//
//  AddCooler.swift
//  AquaplusAppStoryBoards
//
//  Created by David Mendes Da Silva on 28/08/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD
import Combine

class AddNewCoolerViewController: UIViewController {
    
    //var custid = ""
    @IBOutlet weak var customerIdTextField: UITextField!
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var serialNumberTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var coolerTypetextField: UITextField!
    @IBOutlet weak var statusTextField: UITextField!
    @IBOutlet weak var imageTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    
    
    @IBAction func save(_ sender: Any) {
        print("saving new cooler")
        saveCooler()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //customerIdTextField.text = custid
    }
    @objc func saveCooler() {
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Submitting..."
        hud.show(in: view)

        guard let serialNumber = serialNumberTextField.text else {return}
        guard let make = makeTextField.text else {return}
        guard let notes = notesTextField.text else {return}
        guard let model = modelTextField.text else {return}
        guard let coolerType = coolerTypetextField.text else {return}
        guard let imageUrl = imageTextField.text else {return}
        guard let status = statusTextField.text else {return}
        guard let custid = customerIdTextField.text else {return}
        
        
        let params = ["serialNumber": serialNumber, "make": make, "notes": notes, "model": model, "coolerType": coolerType, "status": status, "imageURL": imageUrl]
        
        let url = "\(Service.shared.baseUrl)/cooler/customer/\(custid)"
        AF.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData { (dataResp) in

                hud.dismiss()
//                self.waterLabel.text = nil
//                self.waterLabel.isHidden = false

                self.dismiss(animated: false, completion: nil)

                //self.fetchCustomerProfile()

        }
    }
}
