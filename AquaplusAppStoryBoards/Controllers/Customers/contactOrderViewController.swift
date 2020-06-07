//
//  contactOrderViewController.swift
//  AquaplusAppStoryBoards
//
//  Created by Edson Mendes da silva on 05/06/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import UIKit
import Alamofire


class contactOrderViewController: UITableViewController {

    var accountID = ""
    //var accountName = "name"
    
    var customer = [Customers]()
    
   
    @IBOutlet weak var accountIDLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var eAdressLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var address1Label: UILabel!
    @IBOutlet weak var address2Label: UILabel!
    @IBOutlet weak var townLabel: UILabel!
    @IBOutlet weak var countyLabel: UILabel!
    @IBOutlet weak var postCodeLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountIDLabel.text = accountID
        fetchCustomerProfile()

        // Do any additional setup after loading the view.
    }
    
    fileprivate func fetchCustomerProfile() {
        //let custId = "5ed58522c123a90017798abf"
        let url = "\(Service.shared.baseUrl)/customer/\(accountID)"
        AF.request(url)
            .validate(statusCode: 200..<300)
            .responseData { (dataResp) in
                //self.setupActivityIndicatorView.stopAnimating()
                
                
                if let err = dataResp.error {
                    print("Failed to fetch customer profile:", err)
                    return
                }
                
                let data = dataResp.data ?? Data()
                do {
                    let customer = try JSONDecoder().decode(Customers.self, from: data)
                    
                   // self.orders = customer.orders ?? []
                    self.accountNameLabel.text = customer.fullName
                    self.accountNumberLabel.text = customer.accountNumber
                    self.eAdressLabel.text = customer.emailAddress
                    //self.mobileLabel.text = customer.telephone
                    //self.address1Label.text = customer.address1
                    //self.address2Label.text = customer.address2
                    //self.townLabel.text = customer.town
                    //self.countyLabel.text = customer.county
                    //self.postCodeLabel.text = customer.postCode
                
                    
                    
                } catch {
                    print("Failed to decode user:", error)
                }
        }
        
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}