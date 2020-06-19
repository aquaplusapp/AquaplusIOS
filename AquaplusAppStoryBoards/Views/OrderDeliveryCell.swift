//
//  DeliveryCell.swift
//  AquaplusAppStoryBoards
//
//  Created by David Mendes Da Silva on 29/04/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import Foundation
import WebKit
import Alamofire

class OrderDeliveryCell: UITableViewCell {
    
    var optionsButtonDidTap: ((_ order: Order) -> Void)?
    
    private var order: Order?
    
    @IBOutlet weak var accountName: UILabel!
    //@IBOutlet weak var optionsButton: UIButton!
    @IBOutlet weak var quantityBottles: UILabel!
    
    @IBOutlet weak var postCodeLabel: UILabel!
    //weak var delegate: PostCellOptionsDelegate?
    
    @IBAction func optionsButton(_ sender: Any) {
        //print(order)
        guard let order = self.order else {fatalError("Order is missing")}
        optionsButtonDidTap?(order)
        
        //delegate?.handlePostOptions(cell: self)
       // handlePostOptions

    }
    
//    @objc func optionsButton(){
//        guard let order = self.order else {fatalError("Order is missing")}
//        optionsButtonDidTap?(order)
//    }
    
    func configure(with order: Order) {
        self.order = order
        accountName.text = order.customers.accountNumber
        quantityBottles.text = String(order.quantityBottles)
        postCodeLabel.text = order.customers.postCode
        
    }
}
//protocol PostCellOptionsDelegate: class {
//    func handlePostOptions(cell: DeliveryCell)
//}
//
//extension HomeController: PostCellOptionsDelegate {
//    func handlePostOptions(cell: DeliveryCell) {
//        guard let indexPath = tableView.indexPath(for: cell) else { return }
//        let del = self.orders[indexPath.row]
//
//        let alertController = UIAlertController(title: "Options", message: nil, preferredStyle: .actionSheet)
//        alertController.addAction(.init(title: "Delete post", style: .destructive, handler: { (_) in
//
//            let url = "\(Service.shared.baseUrl)/delivery/\(del.id)"
//            AF.request(url, method: .delete)
//                .validate(statusCode: 200..<300)
//                .response { (dataResp) in
//                    if let err = dataResp.error {
//                        print("failed to delete", err)
//                        return
//                    }
//                    self.orders.remove(at: indexPath.row)
//                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
//            }
//
//        }))
//        alertController.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
//
//        self.present(alertController, animated: true)
//    }
//}
