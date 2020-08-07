//
//  EditContatctViewController.swift
//  AquaplusAppStoryBoards
//
//  Created by Edson Mendes da silva on 09/06/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD

class EditContatctViewController: UITableViewController {

    var accID = ""
    var accNumber = ""
    var accName = ""
    var fullName = ""
    var email = ""
    var landLineNum = ""
    var mobileNumber = ""
    var add1 = ""
    var add2 = ""
    var addTown = ""
    var addCounty = ""
    var addPostCode = ""
    
    var customer: Customers?
    
    @IBOutlet weak var accountNumber: UITextField!
    @IBOutlet weak var accountID: UILabel!
    @IBOutlet weak var accountName: UITextField!
    @IBOutlet weak var accountFullName: UITextField!
    @IBOutlet weak var eAddress: UITextField!
    @IBOutlet weak var landlinePhone: UITextField!
    @IBOutlet weak var mobilePhone: UITextField!
    @IBOutlet weak var address1: UITextField!
    @IBOutlet weak var address2: UITextField!
    @IBOutlet weak var addressTown: UITextField!
    @IBOutlet weak var addressCounty: UITextField!
    @IBOutlet weak var addressPostCode: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        accountID.text = accID
        accountNumber.text = accNumber
        accountName.text = accName
        accountFullName.text = fullName
        eAddress.text = email
        landlinePhone.text = landLineNum
        mobilePhone.text = mobileNumber
        address1.text = add1
        address2.text = add2
        addressTown.text = addTown
        addressCounty.text = addCounty
        addressPostCode.text = addPostCode
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    @IBAction func updateContact(_ sender: Any) {
        handleUpdate()
    }
    
    @objc func handleUpdate() {
        //print(customInputView.textView.text ?? "")

        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Updating..."
        hud.show(in: view)
        
        guard let accNum = accountNumber.text else {return}
        guard let accName = accountName.text else { return}
        guard let fullNa = accountFullName.text else { return}
        guard let eAddress = eAddress.text else { return}
        guard let tPhone = mobilePhone.text else {return}
        guard let add1 = address1.text else {return}
        guard let add2 = address2.text else { return}
        guard let addTown = addressTown.text else {return}
        guard let coun = addressCounty.text else { return}
        guard let postCo = addressPostCode.text else { return}
        
        
        let params = ["accountNumber": accNum, "accountName": accName, "fullName": fullNa, "emailAddress": eAddress, "telephone": tPhone, "address1": add1, "address2": add2, "town": addTown, "county": coun, "postCode": postCo]
        let url = "\(Service.shared.baseUrl)/customer/\(accID)"
        AF.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData { (dataResp) in

                hud.dismiss()
                self.accountNumber.text = nil
                self.accountNumber.isHidden = false
                self.reloadInputViews()
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
                //self.fetchCustomerProfile()
        }
    }
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 1
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
