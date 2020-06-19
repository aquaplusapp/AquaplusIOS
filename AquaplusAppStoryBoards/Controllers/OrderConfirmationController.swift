//
//  OrderConfirmationController.swift
//  AquaplusAppStoryBoards
//
//  Created by David Mendes Da Silva on 17/06/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import UIKit

class OrderConfirmationController: UIViewController {
    
    @IBOutlet weak var accountNumber: UILabel!
    @IBOutlet weak var accountName: UILabel!
    
    @IBOutlet weak var fullBottles: UITextField!
    @IBOutlet weak var emptyBottles: UITextField!
    

    @IBOutlet weak var orderNumber: UILabel!
    
    var order: Order?
    
    weak var delegate: OrderTVCDelegate?
    
    private var emailManager = EmailManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    @IBAction func sendEmail(_ sender: Any) {
        //delegate?.showOrderConfirmationStatus(isSuccessful: true)
        
        guard let order = self.order else {fatalError("order missing")}
        let orderConfirmation = OrderConfirmation(order: order)
        emailManager.send(orderConfirmation: orderConfirmation) { [unowned self] (result) in
            DispatchQueue.main.async {
                self.delegate?.showOrderConfirmationStatus(result: result)
            }
            
        }
    }
    
    
    private func setupViews() {
        accountNumber.text = order?.customers.accountNumber
        accountName.text = order?.customers.accountName
        orderNumber.text = order?.id
        fullBottles.text = "\(order?.quantityBottles ?? 0)"
        emptyBottles.text = "\(order?.emptyBottles ?? 0)"
    }
}
