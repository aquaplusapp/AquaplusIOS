//
//  AddProductViewController.swift
//  
//
//  Created by Edson Mendes da silva on 27/08/2020.
//

import UIKit

class AddProductViewController: UIViewController {

    
    @IBOutlet weak var productCodeText: UITextField!
    @IBOutlet weak var productText: UITextField!
    @IBOutlet weak var priceText: UITextField!
    @IBOutlet weak var depositText: UITextField!
    @IBOutlet weak var productTypeText: UITextField!
    @IBOutlet weak var nominalText: UITextField!
    @IBOutlet weak var taxCodeText: UITextField!
    
    @IBAction func saveProduct(_ sender: Any) {
        print("Save Product")
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
