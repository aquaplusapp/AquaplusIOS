//
//  CustomerPickViewController.swift
//  AquaApp
//
//  Created by Edson Mendes da silva on 30/04/2020.
//  Copyright © 2020 Edson Mendes da silva. All rights reserved.
//

import UIKit
import Alamofire


class CustomerPickerController: UITableViewController {

    var customers: [Customers] = []
    let searchController = UISearchController(searchResultsController: nil)
    var filteredCustomers: [Customers] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchContacts()
        
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Search Customers"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
     
    }
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }

    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }

  func filterContentForSearchText(_ searchText: String,
                                  category: Customers? = nil) {
    filteredCustomers = customers.filter { (customer: Customers) -> Bool in
        return customer.accountNumber.lowercased().contains(searchText.lowercased())
    }
    
    tableView.reloadData()
  }

    
//    let cust = customers[indexPath.row]
//    let controller = CustomerProfileController(custId: cust.id)
    
    
    @objc fileprivate func fetchContacts() {
        Service.shared.fetchContacts { (res) in
            switch res {
            case .failure(let err):
                print("Failed to fetch contacts", err)
            case .success(let customers):
                self.customers = customers
                self.tableView.reloadData()
            }
        }
    }
    


    
    // MARK: - Table view data source
    
    //var customers = [Customers]()
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isFiltering {
            return filteredCustomers.count
        }
        return customers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerCell", for: indexPath)
        //let cell = self.tableView.dequeueReusableCell(withIdentifier: "CustomerCell") as! ContactCell
        let customer: Customers
        if isFiltering {
            customer = filteredCustomers[indexPath.row]
        } else {
            customer = customers[indexPath.row]

        }
        cell.textLabel?.text = customer.accountNumber

        // Configure the cell...
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier : "AddNewDeliveryController") as? AddNewDeliveryController
        let customer: Customers
        if isFiltering {
            customer = filteredCustomers[indexPath.row]
        } else {
            customer = customers[indexPath.row]
        }
        //let customer = customers[indexPath.row]
        vc?.account = customer.accountNumber
        vc?.custid = customer.id
        
        
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
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

extension CustomerPickerController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
  }
}
