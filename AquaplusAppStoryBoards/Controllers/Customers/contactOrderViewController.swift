//
//  contactOrderViewController.swift
//  AquaplusAppStoryBoards
//
//  Created by Edson Mendes da silva on 05/06/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import UIKit
import Alamofire
import MessageUI


class contactOrderViewController: UITableViewController, MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: {
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        })
    }
    

    var accountID = ""
    
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
    @IBOutlet weak var contactNameLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountIDLabel.text = accountID
        fetchCustomerProfile()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func mobileButton(_ sender: UIButton) {
        print("calling ring ring")
        call()
    }
    
    @IBAction func mobileMButton(_ sender: Any) {
       message()
    }
    private func message(){
        let composeVC = MFMessageComposeViewController()
               composeVC.messageComposeDelegate = self

               // Configure the fields of the interface.
        composeVC.recipients = ["\(mobileLabel.text ?? "")"]
               composeVC.body = "I love Swift! From Aquaplus APP :)"

               // Present the view controller modally.
               if MFMessageComposeViewController.canSendText() {
                   self.present(composeVC, animated: true, completion: nil)
               }
    }
    
    
    private func call() {
        if let url = URL(string: "tel://\(mobileLabel.text ?? "")"), UIApplication.shared.canOpenURL(url) {
              if #available(iOS 10, *) {
                  UIApplication.shared.open(url)
              } else {
                  UIApplication.shared.openURL(url)
              }
          }
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
                    self.accountNameLabel.text = customer.accountName
                    self.accountNumberLabel.text = customer.accountNumber
                    self.eAdressLabel.text = customer.emailAddress
                    self.mobileLabel.text = customer.telephone
                    self.address1Label.text = customer.address1
                    self.address2Label.text = customer.address2
                    self.townLabel.text = customer.town
                    self.countyLabel.text = customer.county
                    self.postCodeLabel.text = customer.postCode
                    self.contactNameLabel.text = customer.fullName
                
                    
                    
                } catch {
                    print("Failed to decode user:", error)
                }
        }
        
    }
    
    @IBAction func editContact(_ sender: Any) {
        performSegue(withIdentifier: "editContact", sender: self)

    }
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//    let vc = segue.destination as! contactOrderViewController
//             //vc.test = account
//        vc.accountID = custId
//
//     }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as! EditContatctViewController
        vc.accID = accountIDLabel.text ?? ""
        vc.accNumber = accountNumberLabel.text!
        vc.accName = accountNameLabel.text!
        vc.fullName = contactNameLabel.text!
        vc.email = eAdressLabel.text!
        vc.mobileNumber = mobileLabel.text!
        vc.add1 = address1Label.text!
        vc.add2 = address2Label.text!
        vc.addTown = townLabel.text!
        vc.addCounty = countyLabel.text!
        vc.addPostCode = postCodeLabel.text!
    }
    

}
//MARK: - IBActions
extension contactOrderViewController {
    //function to cancel AddNewContactController
    @IBAction func cancelToContactController(_ segue: UIStoryboardSegue){
    
    }
}
