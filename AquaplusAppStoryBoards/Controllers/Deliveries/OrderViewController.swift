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
    
    //    var delNoId = ""
    //    var account = ""
    //    var customerID = ""
    //    var name = ""
    //    var water = ""
    //    var emptyBottle = ""
    //    var dateOrder = Int()
    //    var notes = ""
    //var dateOrder = Date()
    
    
    @IBOutlet weak var accountNumber: UILabel!
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var numberBottles: UILabel!
    @IBOutlet weak var custID: UILabel!
    @IBOutlet weak var emptyBottlesText: UITextField!
    @IBOutlet weak var orderedDate: UILabel!
    @IBOutlet weak var quantityBottlesText: UITextField!
    @IBOutlet weak var orderNo: UILabel!
    @IBOutlet weak var notesText: UITextView!
    
    let dateFormatter = DateFormatter()
    
    private var emailManager = EmailManager()
    
    
    var order: Order?
    //var orders: Order!
    weak var delegate: HomeControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        /*
         accountNumber.text = account
         //accountNumber.text = orders.customers.accountNumber
         accountName.text = name
         //numberBottles.text = water
         quantityBottlesText.text = water
         custID.text = customerID
         emptyBottlesText.text = emptyBottle
         //orderedDate.text = orders.fromnow
         
         //orderedDate.text = dateOrder
         //dateFormatter.dateStyle = DateFormatter.Style.medium
         //orderedDate.text = DateFormatter.localizedString(from: dateOrder, dateStyle: DateFormatter.Style.short, timeStyle: DateFormatter.Style.short)
         orderedDate.text = String(dateOrder)
         orderNo.text = delNoId
         notesText.text = notes
         
         //        dateFormatter.dateFormat = "dd.MM.yy"
         //        let result = dateFormatter.string(from: dateOrder)
         //        orderedDate.text = result
         
         // Uncomment the following line to preserve selection between presentations
         // self.clearsSelectionOnViewWillAppear = false
         
         // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         // self.navigationItem.rightBarButtonItem = self.editButtonItem
         */
    }
    
    

    @objc func handleCompleteOrder() {
        print("Save")
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Updating"
        hud.show(in: view)
        
        guard let eb = emptyBottlesText.text else {return}
        guard let fb = quantityBottlesText.text else {return}
        guard let n = notesText.text else {return}
        
        let params = ["emptyBottles": eb, "quantityBottles": fb, "notes": n]
        
        let url = "\(Service.shared.baseUrl)/delivery/\(order?.id ?? "")"
        
        AF.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData { (dataResp) in
                
                hud.dismiss()
                self.accountNumber.text = nil
                self.accountNumber.isHidden = false
                self.reloadInputViews()
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
                
                
        }
    }
    @IBAction func completeOrder(_ sender: UIBarButtonItem) {
        
        
            handleCompleteOrder()
            sendEmail()
        //sendEmail()
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss dd/MM/yyyy"
        let result = formatter.string(from: date)
        print(result)
        
        
       // self.dismiss(animated: true, completion: nil)
//        self.dismiss(animated: true, completion: {
//                                   self.presentingViewController?.dismiss(animated: true, completion: nil)
//                               })
    }
    
    private func setupViews() {
        accountNumber.text = order?.customers.accountNumber
        accountName.text = order?.customers.accountName
        quantityBottlesText.text = String(order?.quantityBottles)
        custID.text = order?.customers.id
        
        emptyBottlesText.text = String(order?.emptyBottles)
        
        
        //orderedDate.text = String(order?.createdAt)
        orderNo.text = order?.id
        notesText.text = order?.notes
        
        let dateO = Date(timeIntervalSince1970: order!.createdAt/1000)
        print("1:", dateO)
        
        //Date().millisecondsSince1970 // 1476889390939
        print("2:", Date().millisecondsSince1970)
        
        let DateE = Date(milliseconds: Int64(order!.createdAt))
        print("3:", DateE)
        
        print("4:", Date(milliseconds: Int64(order!.createdAt)))
        
        orderedDate.text = order!.dateOrdered
        print("5:", order!.dateOrdered)
        
        print("6:", order!.createdAt)
        
        let string = String(DateE)!
        let formatter4 = DateFormatter()
        formatter4.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZZ"
        print("7:", formatter4.date(from: string) ?? "Unknown date")
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"

        let dateFormatterPrint1 = DateFormatter()
        dateFormatterPrint1.dateFormat = "dd/MM/yyyy"
        
        let dateFormatterPrint2 = DateFormatter()
        dateFormatterPrint2.dateFormat = "HH:mm"

        if let date = dateFormatterGet.date(from: order!.dateOrdered) {
            print("8:", dateFormatterPrint1.string(from: date), dateFormatterPrint2.string(from: date))
        } else {
           print("There was an error decoding the string")
        }
        
    }
    

    @objc func sendEmail() {
        guard let order = self.order else {fatalError("order missing")}
        let orderConfirmation = OrderConfirmation(order: order)
        emailManager.send(orderConfirmation: orderConfirmation) { [unowned self] (result) in
            DispatchQueue.main.async {
                self.delegate?.showOrderConfirmationStatus(result: result)
            }
            
        }
    }
    @IBAction func sendEmail(_ sender: Any) {
        guard let order = self.order else {fatalError("order missing")}
        let orderConfirmation = OrderConfirmation(order: order)
        emailManager.send(orderConfirmation: orderConfirmation) { [unowned self] (result) in
            DispatchQueue.main.async {
                self.delegate?.showOrderConfirmationStatus(result: result)
            }
            
        }
    }
    
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        print("Row \(indexPath.row)selected")
    //
    //        if indexPath.row == 0 && indexPath.section == 0 {
    //         let vc = storyboard?.instantiateViewController(withIdentifier : "contactOrderViewController") as? contactOrderViewController
    //
    //            vc?.accountID = customerID
    //
    //        self.navigationController?.pushViewController(vc!, animated: true)
    //        }
    //    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print(indexPath.row)
        
        let vc = storyboard?.instantiateViewController(withIdentifier : "contactOrderViewController") as? contactOrderViewController
        
        vc?.accountID = order?.customers.id as! String
        
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    //    func accessoryButtonTapped(sender : AnyObject){
    //        print("Tapped")
    //    }
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
extension String {
    init?<T : CustomStringConvertible>(_ value : T?) {
        guard let value = value else { return nil }
        self.init(describing: value)
    }
}
//extension DateFormatter {
//    func date(fromSwapiString dateString: String) -> Date? {
//        // SWAPI dates look like: "2014-12-10T16:44:31.486000Z"
//        self.dateFormat = "yyyy-MM-dd"
//        self.timeZone = TimeZone(abbreviation: "UTC")
//        self.locale = Locale(identifier: "en_US_POSIX")
//        return self.date(from: dateString)
//    }
//
//}

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000.0)
    }
}
