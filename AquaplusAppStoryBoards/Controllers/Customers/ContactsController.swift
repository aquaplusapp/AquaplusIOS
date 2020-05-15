//
//  ContactsController.swift
//  AquaplusAppStoryBoards
//
//  Created by David Mendes Da Silva on 29/04/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import JGProgressHUD

class ContactsController: UITableViewController {
    
//    let custId: String
//
//    init(custId: String) {
//        self.custId = custId
//        super.init()
//    }
    @IBOutlet var contactsTableView: UITableView!
    
    override func viewDidLoad() {
    super.viewDidLoad()
        fetchContacts()
        contactsTableView.delegate = self
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(fetchContacts), for: .valueChanged)
        self.tableView.refreshControl = rc
    }
    @objc func fetchContacts() {
        //        let url = "http://localhost:1337/customer"
        //        AF.request(url)
        //            .validate(statusCode: 200..<300)
        //            .responseData { (dataResp) in
        //                if let err = dataResp.error {
        //                    print("Failed to fetch posts:", err)
        //                    return
        //                }
        //
        //                guard let data = dataResp.data else { return }
        //                do {
        //                    let customers = try JSONDecoder().decode([Customers].self, from: data)
        //                    self.customers = customers
        //                    self.tableView.reloadData()
        //                 print(customers)
        //                } catch {
        //                    print(error)
        //                }
        //        }
        
        Service.shared.fetchContacts { (res) in
            self.tableView.refreshControl?.endRefreshing()
            switch res {
            case .failure(let err):
                print("Failed to fetch posts:", err)
            case .success(let customers):
                //                self.customers = customers
                //                self.tableView.reloadData()
                self.customers = customers
                self.tableView.reloadData()
                
            }
        }
    }
    

    
    var customers = [Customers]()
    
//    var nameText = ""
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customers.count
    }
    //let cellReuseIdentifier = "cell"
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contactCell = self.tableView.dequeueReusableCell(withIdentifier: "ContactCell") as! ContactCell
        //
        let cust = customers[indexPath.row]
        contactCell.accountNumber.text = cust.accountNumber
//        cell.textLabel?.font = .boldSystemFont(ofSize: 14)
        contactCell.fullName.text = cust.fullName
        //self.nameText = contactCell.accountNumber.text!
        //cell.detailTextLabel?.numberOfLines = 0
        return contactCell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)

        let cust = customers[indexPath.row]
        let controller = storyboard?.instantiateViewController(withIdentifier : "CustomerProfileControllerTest") as! CustomerProfileControllerTest
        controller.account = cust.accountNumber //here is the customer you need to pass to next viewcontroller
        controller.custId = cust.id
        print(cust.accountNumber)
        self.navigationController?.pushViewController(controller, animated: true)
        

    }
 
    // MARK: - Navigation
    
//     In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        // Get the new view controller using segue.destination.
////        // Pass the selected object to the new view controller.
////        var vc = segue.destination as! CustomerProfileController
////        vc.accName = self.nameText
//        // Create a variable that you want to send
//
//       // var newProgramVar = Customers(id: id, accountNumber: "", fullName: "")
//
//        // Create a new variable to store the instance of PlayerTableViewController
//        let destinationVC = segue.destination as! CustomerProfileController
//        destinationVC.accName =
//
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
//MARK: - IBActions
extension ContactsController {
    //function to cancel AddNewContactController
    @IBAction func cancelToContactsController(_ segue: UIStoryboardSegue){
        fetchContacts()
        
    }
}
