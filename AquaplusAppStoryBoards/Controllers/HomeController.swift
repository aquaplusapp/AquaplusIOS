//
//  HomeController.swift
//  AquaplusAppStoryBoards
//
//  Created by David Mendes Da Silva on 29/04/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//


import WebKit
import Alamofire


class HomeController: UITableViewController {
    
    override func viewDidLoad() {
    super.viewDidLoad()
        fetchOrders()
        
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(fetchOrders), for: .valueChanged)
        self.tableView.refreshControl = rc
        
    }

//    @IBAction func addDelivery(_ sender: Any) {
//        print("add")
//    }
    
    @objc fileprivate func fetchOrders() {
//        let url = "http://localhost:1337/delivery"
//        AF.request(url)
//            .validate(statusCode: 200..<300)
//            .responseData { (dataResp) in
//                self.tableView.refreshControl?.endRefreshing()
//                if let err = dataResp.error {
//                    print("Failed to fetch posts:", err)
//                    return
//                }
//
//                guard let data = dataResp.data else { return }
//                do {
//                    let orders = try JSONDecoder().decode([Order].self, from: data)
//                    self.orders = orders
//                    self.tableView.reloadData()
//                 print(orders)
//                } catch {
//                    print(error)
//                }
//        }
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
    
    //@IBAction func fetchPosts(_ sender: Any) {

//        let url = "http://localhost:1337/delivery"
//               AF.request(url)
//                   .validate(statusCode: 200..<300)
//                   .responseData { (dataResp) in
//                       if let err = dataResp.error {
//                           print("Failed to fetch posts:", err)
//                           return
//                       }
//
//                       guard let data = dataResp.data else { return }
//                       do {
//                           let orders = try JSONDecoder().decode([Order].self, from: data)
//                           self.orders = orders
//                           self.tableView.reloadData()
//                        print(orders)
//                       } catch {
//                           print(error)
//                       }
//               }
    //}
    
    
    
    var orders = [Order]()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    //let cellReuseIdentifier = "cell"
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let deliveryCell = self.tableView.dequeueReusableCell(withIdentifier: "DeliveryCell") as! DeliveryCell
        //
        let order = orders[indexPath.row]
        deliveryCell.accountName.text = order.customers.accountNumber
//        cell.textLabel?.font = .boldSystemFont(ofSize: 14)
       deliveryCell.quantityBottles.text = order.quantityBottles
        //cell.detailTextLabel?.numberOfLines = 0
        return deliveryCell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
           print("Row \(indexPath.row)selected")
           
           let vc = storyboard?.instantiateViewController(withIdentifier : "OrderViewController") as? OrderViewController
           
           let order = orders[indexPath.row]
           vc?.account = order.customers.accountNumber
           vc?.name = order.customers.fullName
           vc?.water = order.quantityBottles
               //vc?.water = customer.water!
           
           self.navigationController?.pushViewController(vc!, animated: true)

       }

}

//MARK: - IBActions
extension HomeController {
    //function to cancel delivery note
    @IBAction func cancelToHomeController(_ segue: UIStoryboardSegue){
        fetchOrders()

    }
}
