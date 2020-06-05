//
//  feedbackViewController.swift
//  AquaplusAppStoryBoards
//
//  Created by David Mendes Da Silva on 01/06/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import UIKit
import Combine
import Loaf
import JGProgressHUD
import MBProgressHUD


class FeedbackViewController: UIViewController {
    
    @IBOutlet weak var catergoryTextField: UITextField!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var submitButton: UIBarButtonItem!
    
    @Published private var feedbackCategory: FeedbackCategory?
    @Published private var comments: String?
    
    private var subscriber: AnyCancellable?
    
    private var emailManager = EmailManager()
    
    lazy var pickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.delegate = self
        pv.dataSource = self
        return pv
    }()
    
    lazy var toolbar: UIToolbar = {
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0)
        let tb = UIToolbar(frame: frame)
        tb.sizeToFit()
        
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPickerView))
        
        tb.setItems([flexButton, doneButton], animated: true)
        tb.isUserInteractionEnabled = true
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .yellow
        
        setupTextField()
        setupViews()
        setupTextView()
        observeForm()
        setupGestures()
        //addDoneButton()
    }
    
    private func setupViews() {
        submitButton.isEnabled = false
    }
    
    private func setupTextField() {
        catergoryTextField.delegate = self
        catergoryTextField.inputView = pickerView
        catergoryTextField.inputAccessoryView = toolbar
    }
    
    private func setupTextView() {
        commentTextView.delegate = self
    }
    
    private func observeForm() {
        subscriber = Publishers.CombineLatest($feedbackCategory, $comments).sink { [unowned self] (category, comments) in
            let isFormCompeted = (category != nil && comments?.isEmpty == false)
            self.submitButton.isEnabled = isFormCompeted
        }
    }
    
    private func clearForm() {
        catergoryTextField.text = ""
        commentTextView.text = ""
        feedbackCategory = nil
        comments = nil
        pickerView.selectRow(0, inComponent: 0, animated: true)
    }
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    //    private func addDoneButton() {
    //
    //
    //        //commentTextView.inputAccessoryView = toolbar
    //    }
    
    @objc private func dismissPickerView() {
        catergoryTextField.endEditing(true)
    }
    @IBAction func submitButtonTap(_ sender: Any) {
        guard let category = self.feedbackCategory, let comments = self.comments else { return }
        
        dismissKeyboard()
        
        let form = FeedbackForm(category:category, comments: comments)
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Sending Feedback"
        hud.show(in: self.view)
//        MBProgressHUD.showAdded(to: view, animated: true)
        
        emailManager.send(form: form) { [unowned self](result) in
            
            DispatchQueue.main.async {
                
                self.clearForm()
//                MBProgressHUD.hide(for: self.view, animated: true)
                hud.dismiss()
                switch result {
                case .success:
                    Loaf("your feedback has been successfully submitted", state: .success, sender: self).show()
                    print("your feedback has been successfully submitted")
                //self.dismiss(animated: true)
                case .failure(let error):
                    Loaf(error.localizedDescription, state: .error, sender: self).show()
                    print("error: \(error.localizedDescription)")
                }
            }
        }
    }  
}
extension FeedbackViewController: UITextViewDelegate {
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if catergoryTextField.isFirstResponder {
            catergoryTextField.resignFirstResponder()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.commentTextView.becomeFirstResponder()
            }
        }
        return true
    }
    func textViewDidChange(_ textView: UITextView) {
        comments = textView.text
        //print(textView.text)
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




