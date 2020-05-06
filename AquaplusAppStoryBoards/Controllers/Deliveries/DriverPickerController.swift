//
//  DriverPickerViewController.swift
//  AquaApp
//
//  Created by Edson Mendes da silva on 14/04/2020.
//  Copyright © 2020 Edson Mendes da silva. All rights reserved.
//

import UIKit

class DriverPickerController: UITableViewController {

   // MARK: - Properties
        var driver = [
          "David",
          "Edson",
          "Joshua",
          "Jeff",
          "Jake"
        ]
        
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
          guard segue.identifier == "SaveSelectedDriver",
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) else {
              return
          }
            
          let index = indexPath.row
          selectedDriver = driver[index]
        }

        var selectedDriver: String? {
          didSet {
            if let selectedDriver = selectedDriver,
                let index = driver.firstIndex(of: selectedDriver) {
                selectedDriverIndex = index
            }
          }
        }
          
        var selectedDriverIndex: Int?


    }
    // MARK: - UITableViewDataSource
    extension DriverPickerController {

      override func tableView(_ tableView: UITableView,
                              numberOfRowsInSection section: Int) -> Int {
        return driver.count
      }
      
      override func tableView(_ tableView: UITableView,
                              cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
        let cell = tableView.dequeueReusableCell(withIdentifier: "DriverCell", for: indexPath)
        cell.textLabel?.text = driver[indexPath.row]
          
        if indexPath.row == selectedDriverIndex {
          cell.accessoryType = .checkmark
        } else {
          cell.accessoryType = .none
        }
        
        return cell
      }
    }
    // MARK: - UITableViewDelegate
    extension DriverPickerController {

      override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Other row is selected - need to deselect it
        if let index = selectedDriverIndex {
          let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
          cell?.accessoryType = .none
        }
        
        selectedDriver = driver[indexPath.row]
        
        // update the checkmark for the current row
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
      }
    }
