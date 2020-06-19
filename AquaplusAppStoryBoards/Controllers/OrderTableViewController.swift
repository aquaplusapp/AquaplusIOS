//
//  OrderTableViewController.swift
//  AquaplusAppStoryBoards
//
//  Created by David Mendes Da Silva on 16/06/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import UIKit
import Loaf

protocol OrderTVCDelegate: class {
    func showOrderConfirmationStatus(result: Result<OrderConfirmation, Error>)
}

class OrderTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchOrders()
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @objc func fetchOrders() {
        Service.shared.fetchOrders { (res) in
            self.tableView.refreshControl?.endRefreshing()
            switch res {
            case .failure(let err):
                print("Failed to fetch posts:", err)
            case .success(let orders):
                self.orders = orders
                self.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - Table view data source
    private var orders = [Order]()
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
    
    
    
    
    
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
    private func handleOptionsButton(order: Order) {
    
        performSegue(withIdentifier: "showOrderConfirmation", sender: order)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOrderConfirmation", let orderConfirmationController = segue.destination as? OrderConfirmationController, let order = sender as? Order {
            orderConfirmationController.delegate = self
            orderConfirmationController.order = order
            
        }
    }
}

extension OrderTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orders.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! OrderDeliveryCell
        let order = orders[indexPath.item]
        cell.optionsButtonDidTap = { [unowned self] order in
            self.handleOptionsButton(order: order)
            print(order)
            
        }
        cell.configure(with: order)
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let order = orders[indexPath.item]
//        self.handleOptionsButton(order: order)
//        print(order.customers.accountNumber)
//        performSegue(withIdentifier: "showOrderConfirmation", sender: order)
        handleOptionsButton(order: order)
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
extension OrderTableViewController: OrderTVCDelegate {
    func showOrderConfirmationStatus(result: Result<OrderConfirmation, Error>) {
        switch result {
        case .success(let orderConfirmation):
            Loaf("order \(orderConfirmation.order.id) of \(orderConfirmation.order.quantityBottles) has been sent by email", state: .success,location: .top, sender: self).show()
        case .failure(let error):
            Loaf(error.localizedDescription, state: .error, sender: self).show()
        }
    }
}
