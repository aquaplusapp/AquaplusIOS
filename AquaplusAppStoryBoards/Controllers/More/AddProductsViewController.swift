//
//  AddProductsViewController.swift
//  AquaplusAppStoryBoards
//
//  Created by Edson Mendes da silva on 28/08/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//
import UIKit
import Alamofire
import JGProgressHUD
import Combine

class AddProductsViewController: UIViewController {

    
    @IBOutlet weak var productCode: UITextField!
    @IBOutlet weak var product: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var deposit: UITextField!
    @IBOutlet weak var productType: UITextField!
    @IBOutlet weak var nominal: UITextField!
    @IBOutlet weak var taxCode: UITextField!
    
    @IBAction func saveProduct(_ sender: Any) {
        print("Saving Product")
        saveProduct()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

        @objc func saveProduct() {
            
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = "Submitting..."
            hud.show(in: view)

            guard let productCode = productCode.text else {return}
            guard let product = product.text else {return}
            guard let price = price.text else {return}
            guard let productType = productType.text else {return}
            guard let nominal = nominal.text else {return}
            guard let taxCode = taxCode.text else {return}
            guard let deposit = deposit.text else {return}
            
            
            let params = ["productCode": productCode, "product": product, "price": price, "productType": productType, "nominal": nominal, "taxCode": taxCode, "deposit": deposit]
            
            let url = "\(Service.shared.baseUrl)/product"
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
