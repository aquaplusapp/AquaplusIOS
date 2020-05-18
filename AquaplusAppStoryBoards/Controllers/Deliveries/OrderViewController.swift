//
//  OrderViewController.swift
//  AquaApp
//
//  Created by Edson Mendes da silva on 02/05/2020.
//  Copyright © 2020 Edson Mendes da silva. All rights reserved.
//

import UIKit
import JGProgressHUD
import Alamofire

class OrderViewController: UITableViewController {
    
    var delNoId = ""
    var account = ""
    var customerID = ""
    var name = ""
    var water = ""
    var emptyBottle = ""
    var dateOrder = Int()
    //var dateOrder = Date()
    let dateFormatter = DateFormatter()
    
    
    
    @IBOutlet weak var accountNumber: UILabel!
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var numberBottles: UILabel!
    @IBOutlet weak var custID: UILabel!
    @IBOutlet weak var emptyBottlesText: UITextField!
    @IBOutlet weak var orderedDate: UILabel!
    @IBOutlet weak var emptyBottles: UILabel!
    
    @objc func handleCompleteOrder() {
        print("Save")
         let hud = JGProgressHUD(style: .dark)
         hud.textLabel.text = "Updating"
         hud.show(in: view)
         
         guard let eb = emptyBottlesText.text else {return}
         let params = ["emptyBottles": eb]
         let url = "\(Service.shared.baseUrl)/delivery/\(delNoId)"
         
        AF.request(url, method: .post, parameters: params)
             .validate(statusCode: 200..<300)
             .responseData { (dataResp) in

                 hud.dismiss()
                 self.accountNumber.text = nil
                 self.accountNumber.isHidden = false
                 self.reloadInputViews()
                 
         }
    }
    @IBAction func completeOrder(_ sender: UIBarButtonItem) {
        handleCompleteOrder()
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss dd/MM/yyyy"
        let result = formatter.string(from: date)
        print(result)
    }
    
    
    var orders: Order!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountNumber.text = account
        accountName.text = name
        numberBottles.text = water
        custID.text = customerID
        emptyBottles.text = emptyBottle
        //orderedDate.text = orders.fromnow
        
        //orderedDate.text = dateOrder
        //dateFormatter.dateStyle = DateFormatter.Style.medium
        //orderedDate.text = DateFormatter.localizedString(from: dateOrder, dateStyle: DateFormatter.Style.short, timeStyle: DateFormatter.Style.short)
        orderedDate.text = String(dateOrder)
        
        //        dateFormatter.dateFormat = "dd.MM.yy"
        //        let result = dateFormatter.string(from: dateOrder)
        //        orderedDate.text = result
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    @IBAction func sendEmail(_ sender: Any) {
        
    }
    
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete implementation, return the number of rows
    //        return 0
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
