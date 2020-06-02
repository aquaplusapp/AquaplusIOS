//
//  feedbackViewController.swift
//  AquaplusAppStoryBoards
//
//  Created by David Mendes Da Silva on 01/06/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {
    
    @IBOutlet weak var catergoryTextField: UITextField!
    @IBOutlet weak var commentTextView: UITextView!
    
    private var feedbackCategory: FeedbackCategory?
    
    lazy var pickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.delegate = self
        pv.dataSource = self
        return pv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .yellow
        
        setupTextField()
        addDoneButton()
    }
    private func setupTextField(){
        catergoryTextField.delegate = self
        catergoryTextField.inputView = pickerView
    }
    
    private func addDoneButton() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPickerView))
        
        toolbar.setItems([flexButton, doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        catergoryTextField.inputAccessoryView = toolbar
    }
    
    @objc private func dismissPickerView() {
        catergoryTextField.endEditing(true)
    }
    @IBAction func submitButtonTap(_ sender: Any) {
        print("text")
    }
    
    
}
extension FeedbackViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return FeedbackCategory.allCases.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return FeedbackCategory.allCases[row].rawValue
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let category = FeedbackCategory.allCases[row]
        feedbackCategory = category
        catergoryTextField.text = category.rawValue
    }
}

extension FeedbackViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if feedbackCategory == nil {
            let firstItem = FeedbackCategory.allCases.first
            feedbackCategory = firstItem
            catergoryTextField.text = firstItem?.rawValue
        }
    }
}




