//
//  AddProductsViewController.swift
//  AquaplusAppStoryBoards
//
//  Created by Edson Mendes da silva on 28/08/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import UIKit

class AddProductsViewController: UIViewController {

    
    @IBOutlet weak var productCode: UITextField!
    @IBOutlet weak var product: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var deposit: UITextField!
    @IBOutlet weak var productType: UITextField!
    @IBOutlet weak var nominal: UITextField!
    @IBOutlet weak var taxCode: UITextField!
    
    @IBAction func saveProduct(_ sender: Any) {
        print("Saving Product")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
