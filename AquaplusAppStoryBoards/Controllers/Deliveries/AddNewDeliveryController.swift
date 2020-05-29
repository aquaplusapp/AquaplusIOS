//
//  AddNewDeliveryViewController.swift
//  AquaApp
//
//  Created by Edson Mendes da silva on 10/04/2020.
//  Copyright © 2020 Edson Mendes da silva. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD

protocol AddNewDeliveryControllerDelegate {
    func addNewDeliveryControllerDidAddNewDelivery(_ addNewDeliveryController: AddNewDeliveryController)
}

class AddNewDeliveryController: UITableViewController {
    var delegate: AddNewDeliveryControllerDelegate?
    var account = "Customer Name"
    var custid = "ID"
    var VChome = HomeController()
    
    var driver: String = "" {
      didSet {
        driverLabel.text = driver
      }
    }
    
    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var driverLabel: UILabel!
    
    @IBOutlet weak var dateDueLabel: UILabel!
    
    @IBOutlet weak var toggle: UISwitch!
    
    @IBOutlet weak var waterLabel: UILabel!
    @IBOutlet weak var waterStepper: UIStepper!
    @IBAction func waterStepper(_ sender: UIStepper) {
        waterLabel.text = Int(sender.value).description
    }
    @IBOutlet weak var notesText: UITextView!
    
    @IBAction func saveDel(_ sender: UIBarButtonItem) {
       let date = Date()
       let formatter = DateFormatter()
       formatter.dateFormat = "dd.MM.yyyy"
       let result = formatter.string(from: date)
       print(result)
        
        handleSend()
       
        //delegate?.addNewDeliveryControllerDidAddNewDelivery(self)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customerLabel.text = account
        idLabel.text = custid
        //fetchCustomerProfile()

        waterStepper.wraps = true
        waterStepper.autorepeat = true
        waterStepper.maximumValue = 1000

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
        
    @objc func handleSend() {
        //print(customInputView.textView.text ?? "")

        //guard let dateDue = date.text else {return}
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMyyyy"
        let result = formatter.string(from: date)
        print(result)
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Submitting..."
        hud.show(in: view)

        let params = ["quantityBottles": waterLabel.text ?? "", "notes": notesText.text ?? "", "dateOrdered": result, "dateDue": dateDueLabel.text ?? ""]
        let url = "\(Service.shared.baseUrl)/delivery/customer/\(custid)"
        AF.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData { (dataResp) in

                hud.dismiss()
                self.waterLabel.text = nil
                self.waterLabel.isHidden = false

                self.dismiss(animated: false, completion: nil)

                //self.fetchCustomerProfile()

        }
    }
    //MARK: - IBActions
    @IBAction func toggleValueChange(_ sender: UISwitch) {
        tableView.reloadData()
    }
   
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyy"
        //dateFormatter.timeStyle = DateFormatter.Style.medium
        let dateDue = dateFormatter.string(from: sender.date)
        dateDueLabel.text = dateDue
        
        
//        let date = Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd.MM.yyyy"
//        let result = formatter.string(from: date)
    }
    
//    @IBAction func unwindWithSelectedAccount(segue: UIStoryboardSegue) {
//      if let customerPickerViewController = segue.source as? CustomerPickerViewController,
//        let selectedAccount = customerPickerViewController.selectedAccount {
//          account = selectedAccount
//      }
//    }
    
    @IBAction func unwindWithSelectedDriver(segue: UIStoryboardSegue) {
      if let driverPickerViewController = segue.source as? DriverPickerController,
        let selectedDriver = driverPickerViewController.selectedDriver {
          driver = selectedDriver
      }
    }
    

   
    // MARK: - Table view data source
    
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */
    
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

    
    // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
         
//           if segue.identifier == "PickCustomer",
//             let customerPickerController = segue.destination as? CustomerPickerController {
//             customerPickerController.selectedAccount = account
//           }
            if segue.identifier == "PickDriver",
              let driverPickerViewController = segue.destination as? DriverPickerController {
              driverPickerViewController.selectedDriver = driver
            }
        
       }
   
    
}


