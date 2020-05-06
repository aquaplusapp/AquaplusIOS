//
//  CustomerProfileControllerTest.swift
//  AquaplusAppStoryBoards
//
//  Created by David Mendes Da Silva on 03/05/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import UIKit
import Alamofire

private let reuseIdentifier = "Cell"

class CustomerProfileControllerTest: UICollectionViewController {
var cellColor = true
    var account = "Customer Name"
    var custId = "ID"
    //var count = ""
    var customerOrderCell = CustomerOrderCell()
    
    @IBOutlet weak var setupActivityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCustomerProfile()
        
        setupActivityIndicatorView.startAnimating()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        //customerOrderCell.accountNameLabel?.text = account
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)


        // Do any additional setup after loading the view.
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    var cust: Customers?
    
    fileprivate func fetchCustomerProfile() {
        //let custId = "5e8dfae61eaa7315b6cc05ba"
        let url = "\(Service.shared.baseUrl)/customer/\(custId)"
        AF.request(url)
            .validate(statusCode: 200..<300)
            .responseData { (dataResp) in
                self.setupActivityIndicatorView.stopAnimating()
                
                
                if let err = dataResp.error {
                    print("Failed to fetch customer profile:", err)
                    return
                }
                
                let data = dataResp.data ?? Data()
                do {
                    let customer = try JSONDecoder().decode(Customers.self, from: data)
                    
//                    self.cust = customer
//                    print(customer)
                    self.orders = customer.orders ?? []
                    self.collectionView.reloadData()
                } catch {
                    print("Failed to decode user:", error)
                }
        }
        
    }
    // MARK: UICollectionViewDataSource
    //var item: Order!
    var orders = [Order]()
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return orders.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomerOrderCell", for: indexPath) as! CustomerOrderCell
    let cust = orders[indexPath.row]
        // Configure the cell
//    cell.backgroundColor = cellColor ? UIColor.red : UIColor.blue
//    cellColor = !cellColor
        cell.accountNameLabel?.text = cust.customers.accountNumber
        cell.quantityBottlesLabel?.text = cust.quantityBottles
        return cell
    }

  
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CustomerHeader", for: indexPath) as! CustomerHeader
//        switch kind {
//        case UICollectionView.elementKindSectionHeader:
//            if indexPath.section == 0 {
//                //Your Code Here
//            } else {
//            }
//            return headerView
//
//        default:
//            assert(false, "Unexpected element kind")
//        }
//
//        return headerView
//    }
    var customer: Customers!
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
          //let cust = orders[indexPath.row]
          let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CustomerHeader", for: indexPath) as! CustomerHeader
        //let cust = customers[indexPath.row]
        header.label.text = custId
        header.accountNameLabel.text = account
        header.orderCountLabel?.text = "\(orders.count )"
        //header.orderCountLabel?.text = customer.orders?.count ?? 0
        return header
        
      }
      
      
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
          
          return CGSize(width: collectionView.bounds.width, height: 200)
      }
    
}
extension CustomerProfileControllerTest: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
