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
        self.fetchOrders()
        
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
    
     // MARK: - Navigation

    private func handleOptionsButton(order: Order) {
    
        performSegue(withIdentifier: "showOrderConfirmation", sender: order)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOrderConfirmation",
            let orderConfirmationController = segue.destination as? OrderConfirmationController, let order = sender as? Order {
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
