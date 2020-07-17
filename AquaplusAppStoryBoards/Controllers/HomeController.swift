//
//  HomeController.swift
//  AquaplusAppStoryBoards
//
//  Created by David Mendes Da Silva on 29/04/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//


import WebKit
import Alamofire
import Loaf

protocol HomeControllerDelegate: class {
    func showOrderConfirmationStatus(result: Result<OrderConfirmation, Error>)
}

class HomeController: UITableViewController {
    
    var selectedSegment = 1
    var array1 = ["one", "two"]

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
        fetchCompletedOrders()
        
        
        //navigationController?.navigationBar.tintColor = .black
        if selectedSegment == 1{
            
            let rc = UIRefreshControl()
            rc.addTarget(self, action: #selector(fetchOrders), for: .valueChanged)
            self.tableView.refreshControl = rc
        }else{
            let rc = UIRefreshControl()
            rc.addTarget(self, action: #selector(fetchCompletedOrders), for: .valueChanged)
            self.tableView.refreshControl = rc
        }
        
    }
    
    //func to reload tableview when VC appears
    override func viewWillAppear(_ animated: Bool) {
        if selectedSegment == 1{
            fetchOrders()
        }else{
            fetchCompletedOrders()
        }
    }
    
    @IBAction func refreshBtn(_ sender: UIBarButtonItem) {
        if selectedSegment == 1 {
            print("1")
            fetchOrders()
        }else{
            print("2")
            fetchCompletedOrders()
        }
    }
    
   
    
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
    
    @objc func fetchCompletedOrders() {
        
        Service.shared.fetchCompletedOrders { (res) in
            self.tableView.refreshControl?.endRefreshing()
            switch res {
            case .failure(let err):
                Loaf("Not Signed In", state: .error, location: .top, sender: self).show()
                
                print("Failed to fetch posts:", err)
            case .success(let completedOrders):
                self.completedOrders = completedOrders
                self.tableView.reloadData()
                //print(completedOrders)
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
    
    
    // MARK: - Table view data source
    var orders = [Order]()
    var completedOrders = [Order]()
    
    // MARK: - Navigation
    private func handleOptionsButton(order: Order) {

           performSegue(withIdentifier: "showOrderConfirmationOne", sender: order)
       }
       
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           //        guard
           //            segue.identifier == "addNewDeliveryController",
           //            let navigationController = segue.destination as? UINavigationController,
           //            let addNewDeliveryController = navigationController.viewControllers.first as? AddNewDeliveryController
           //            else { return }
           //        addNewDeliveryController.delegate = self
//           if segue.identifier == "addNewDeliveryController",
//               let addNewDeliveryController = segue.destination as? AddNewDeliveryController {
//               addNewDeliveryController.delegate = self
//           } else {
               if segue.identifier == "showOrderConfirmationOne",
                   let orderViewController = segue.destination as? OrderViewController, let order = sender as? Order {
                   orderViewController.delegate = self
                   orderViewController.order = order
                   
               }
           }
//       }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedSegment == 1{
            return orders.count
        } else {
            return completedOrders.count
        }
    }
   
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if selectedSegment == 1{
            let deliveryCell = tableView.dequeueReusableCell(withIdentifier: "DeliveryCell", for: indexPath) as! DeliveryCell
                   let order = orders[indexPath.item]
                  
                   deliveryCell.optionsButtonDidTap = { [unowned self] order in
                       self.handleOptionsButton(order: order)
                       print(order)
                   }
                   deliveryCell.configure(with: order)
                   return deliveryCell
            /*
            let order = orders[indexPath.row]
            //        let myInteger = order.quantityBottles
            //        let myString = "\(myInteger)"
            deliveryCell.postCodeLabel.text = order.customers.postCode
            deliveryCell.accountName.text = order.customers.accountNumber
            //        cell.textLabel?.font = .boldSystemFont(ofSize: 14)
            //deliveryCell.quantityBottles.text = myString
            deliveryCell.quantityBottles.text = String(order.quantityBottles)
            //cell.detailTextLabel?.numberOfLines = 0
            return deliveryCell
 */
         
        }else{
            let deliveryCompletedCell = self.tableView.dequeueReusableCell(withIdentifier: "DeliveryCompletedCell") as! DeliveryCompletedCell
            let completedOrder = completedOrders[indexPath.row]
            deliveryCompletedCell.accountName1.text = completedOrder.customers.accountNumber
            deliveryCompletedCell.quantityBottles1.text = String(completedOrder.quantityBottles)
            deliveryCompletedCell.emtpyBottles.text = String(completedOrder.emptyBottles)
            return deliveryCompletedCell
            
            //            Cell1.textLabel?.text = array1[indexPath.row]
            //            return Cell1
        }
 
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        
//        let order = orders[indexPath.item]
//        handleOptionsButton(order: order)
        
        //performSegue(withIdentifier: "showOrderConfirmationOne", sender: order)
        /*
        print("Row \(indexPath.row)selected")
        
        let vc = storyboard?.instantiateViewController(withIdentifier : "OrderViewController") as? OrderViewController
        */
        if selectedSegment == 1 {
            
            
            let order = orders[indexPath.row]
            handleOptionsButton(order: order)
            /*
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
            vc?.emptyBottle = String(order.emptyBottles)
            
            self.navigationController?.pushViewController(vc!, animated: true)
            
            */
        } else {
            
            let completedOrder = completedOrders[indexPath.row]
            handleOptionsButton(order: completedOrder)
            /*
            vc?.account = completedOrder.customers.accountNumber
            vc?.name = completedOrder.customers.fullName
            vc?.water = String(completedOrder.quantityBottles)
            vc?.customerID = completedOrder.id
            vc?.dateOrder = completedOrder.createdAt
            vc?.delNoId = completedOrder.id
            vc?.notes = completedOrder.notes
            vc?.emptyBottle = String(completedOrder.emptyBottles)
            self.navigationController?.pushViewController(vc!, animated: true)
            print("Row \(completedOrder)selected")
            */
            
            
        }
        
        
        
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
extension HomeController: HomeControllerDelegate {
    func showOrderConfirmationStatus(result: Result<OrderConfirmation, Error>) {
        switch result {
        case .success(let orderConfirmation):
            Loaf("order \(orderConfirmation.order.id) of \(orderConfirmation.order.quantityBottles) has been sent by email", state: .success,location: .top, sender: self).show()
        case .failure(let error):
            Loaf(error.localizedDescription, state: .error, sender: self).show()
        }
    }
}
