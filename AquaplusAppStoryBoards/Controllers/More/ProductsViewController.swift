//
//  ProductsViewController.swift
//  AquaplusAppStoryBoards
//
//  Created by Edson Mendes da silva on 28/08/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import UIKit

class ProductsViewController: UITableViewController {
    
    var products = [Product]()

    //var products = SampleData.generateProductsData()
    
    @IBAction func refreshProducts(_ sender: Any) {
        print("Refershing Products")
        fetchProducts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProducts()
    }
    
    @objc func fetchProducts() {
        Service.shared.fetchProducts { (res) in
            self.tableView.refreshControl?.endRefreshing()
            switch res {
            case .failure(let err):
                print("Failed to fetch products:", err)
            case .success(let products):
                self.products = products
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return products.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        let product = products[indexPath.row]
        cell.configure(with: product)
        return cell
 
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
//MARK: - IBActions
extension ProductsViewController {
    //function to cancel delivery note
    @IBAction func cancelToProductsController(_ segue: UIStoryboardSegue){
        
    }
}
