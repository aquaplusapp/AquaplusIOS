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
    
    var selectedSegment = 1
    
    @IBOutlet var ordersTableView: UITableView!
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            selectedSegment = 1
            
        } else {
            selectedSegment = 2
            
        }
        
        self.ordersTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchOrders()
        
        
        //navigationController?.navigationBar.tintColor = .black
        
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(fetchOrders), for: .valueChanged)
        self.tableView.refreshControl = rc
        
    }
    
    //func to reload tableview when VC appears
    override func viewWillAppear(_ animated: Bool) {
        fetchOrders()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "addNewDeliveryController",
            let navigationController = segue.destination as? UINavigationController,
            let addNewDeliveryController = navigationController.viewControllers.first as? AddNewDeliveryController
            else { return }
        addNewDeliveryController.delegate = self
    }
    
    //    @IBAction func addDelivery(_ sender: Any) {
    //        print("add")
    //    }
    
    @objc func fetchOrders() {
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
        if selectedSegment == 1{
            return orders.count
        } else {
            return 0
        }
    }
    //let cellReuseIdentifier = "cell"
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let deliveryCell = self.tableView.dequeueReusableCell(withIdentifier: "DeliveryCell") as! DeliveryCell
        //
        let order = orders[indexPath.row]
//        let myInteger = order.quantityBottles
//        let myString = "\(myInteger)"
        deliveryCell.accountName.text = order.customers.accountNumber
        //        cell.textLabel?.font = .boldSystemFont(ofSize: 14)
        //deliveryCell.quantityBottles.text = myString
        deliveryCell.quantityBottles.text = String(order.quantityBottles)
        //cell.detailTextLabel?.numberOfLines = 0
        return deliveryCell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        print("Row \(indexPath.row)selected")
        
        let vc = storyboard?.instantiateViewController(withIdentifier : "OrderViewController") as? OrderViewController
        
        let order = orders[indexPath.row]
        
//        let myInteger = order.quantityBottles
//        let myString = "\(myInteger)"
//        
//        let myInteger2 = order.emptyBottles
//        let myString2 = "\(myInteger2)"
        
        
        vc?.account = order.customers.accountNumber
        vc?.name = order.customers.fullName
        //vc?.water = myString
        vc?.water = String(order.quantityBottles)

        
        vc?.customerID = order.customers.id
        //vc?.water = customer.water!
        vc?.dateOrder = order.createdAt
        vc?.delNoId = order.id
        vc?.notes = order.notes
        //vc?.emptyBottle = myString2
        vc?.emptyBottle = String(order.emptyBottles)

        
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("Deleting")
        //        guard let indexPath = tableView.indexPath(for: DeliveryCell) else { return }
        let del = self.orders[indexPath.row]
        
        let alertController = UIAlertController(title: "Options", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(.init(title: "Delete order", style: .destructive, handler: { (_) in
            
            let url = "\(Service.shared.baseUrl)/delivery/\(del.id)"
            AF.request(url, method: .delete)
                .validate(statusCode: 200..<300)
                .response { (dataResp) in
                    if let err = dataResp.error {
                        print("failed to delete", err)
                        return
                    }
                    self.orders.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
        }))
        alertController.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alertController, animated: true)
    }
    
// MARK: - Navigation
}

extension HomeController: AddNewDeliveryControllerDelegate {
    func addNewDeliveryControllerDidAddNewDelivery(_ addNewDeliveryController: AddNewDeliveryController) {
        fetchOrders()
    }
}

//MARK: - IBActions
extension HomeController {
    //function to cancel delivery note
    @IBAction func cancelToHomeController(_ segue: UIStoryboardSegue){
        fetchOrders()
        
    }
}
