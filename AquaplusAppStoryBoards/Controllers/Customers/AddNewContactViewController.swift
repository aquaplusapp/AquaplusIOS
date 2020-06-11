//
//  AddNewContactViewController.swift
//  AquaplusAppStoryBoards
//
//  Created by Edson Mendes da silva on 06/05/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD
import Combine

class AddNewContactViewController: UITableViewController {


    
    @IBOutlet weak var accountNumber: UITextField!
    @IBOutlet weak var accountName: UITextField!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var telephoneNum: UITextField!
    @IBOutlet weak var addressOne: UITextField!
    @IBOutlet weak var addressTwo: UITextField!
    @IBOutlet weak var addressTown: UITextField!
    @IBOutlet weak var addressCounty: UITextField!
    @IBOutlet weak var addressPostCode: UITextField!
    @IBOutlet weak var notes: UITextView!
    @IBOutlet weak var save: UIBarButtonItem!
    
    @Published private var accNumber: String?
    @Published private var emailAdd: String?
    
    private var subscriber: AnyCancellable?
    
    @IBAction func saveContact(_ sender: UIBarButtonItem) {
        handleCreate()
        self.dismiss(animated: false, completion: nil)
        
    }
    
    lazy var toolbar: UIToolbar = {
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0)
        let tb = UIToolbar(frame: frame)
        tb.sizeToFit()
        
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        
        tb.setItems([flexButton, doneButton], animated: true)
        tb.isUserInteractionEnabled = true
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupGestures()
        setupTextField()
        observeForm()
        //setupTextView()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
//    private func setupTextView() {
//        accountNumber.delegate = self
//        emailAddress.delegate = self
//    }
    
    private func observeForm() {
        subscriber = Publishers.CombineLatest($accNumber, $emailAdd).sink { [unowned self] (an, ea) in
            let isFormCompleted = (an?.isEmpty == false && ea?.isEmpty == false)
            self.save.isEnabled = isFormCompleted
            
        }
    }
    
    
    private func setupViews(){
        save.isEnabled = false
    }
    
    @objc func handleCreate() {
        //print(customInputView.textView.text ?? "")

        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Submitting..."
        hud.show(in: view)
        
        guard let accNum = accountNumber.text else {return}
        guard let accName = accountName.text else { return}
        guard let fullNa = fullName.text else { return}
        guard let eAddress = emailAddress.text else { return}
        guard let tPhone = telephoneNum.text else {return}
        guard let add1 = addressOne.text else {return}
        guard let add2 = addressTwo.text else { return}
        guard let addTown = addressTown.text else {return}
        guard let coun = addressCounty.text else { return}
        guard let postCo = addressPostCode.text else { return}
        
        
        let params = ["accountNumber": accNum, "accountName": accName, "fullName": fullNa, "emailAddress": eAddress, "telephone": tPhone, "address1": add1, "address2": add2, "town": addTown, "county": coun, "postCode": postCo]
        let url = "\(Service.shared.baseUrl)/customer"
        AF.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData { (dataResp) in

                hud.dismiss()
                self.accountNumber.text = nil
                self.accountNumber.isHidden = false
                //self.fetchCustomerProfile()
        }
    }

    
    private func setupGestures(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard(){
        view.endEditing(true)
    }
    
    private func setupTextField(){
        
        accountNumber.inputAccessoryView = toolbar
        accountName.inputAccessoryView = toolbar
        fullName.inputAccessoryView = toolbar
        emailAddress.inputAccessoryView = toolbar
        telephoneNum.inputAccessoryView = toolbar
        addressOne.inputAccessoryView = toolbar
        addressTwo.inputAccessoryView = toolbar
        addressTown.inputAccessoryView = toolbar
        addressCounty.inputAccessoryView = toolbar
        addressPostCode.inputAccessoryView = toolbar
        notes.inputAccessoryView = toolbar
    }
    
    @IBAction func changed(_ sender: UITextField) {
        accNumber = accountNumber.text
        emailAdd = emailAddress.text
    }
    
   
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

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
//extension AddNewContactViewController: UITextFieldDelegate {
//    func textFieldDidChangeSelection(_ textField: UITextField) {
////        accNumber = textField.text
////        emailAdd = textField.text
//    }
//}
