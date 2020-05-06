//
//  CollectionViewController.swift
//  AquaplusAppStoryBoards
//
//  Created by David Mendes Da Silva on 02/05/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
  
    let modelData = ["1","2","3","4","5","6","7","8","9"]

    var accName:String?
    var accId:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    var orders = [Order]()
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return orders.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomerOrderCell", for: indexPath) as! CustomerOrderCell
    
        
    
        if let label = cell.viewWithTag(100) as? UILabel {
            label.text = modelData[indexPath.row]
        }
//        let cust = orders[indexPath.item]
//
//        cell.accountNameLabel.text = cust.customers.accountNumber
//
        return cell
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as?
//            DetailViewController, let index =
//            collectionView.indexPathsForSelectedItems?.first {
//            destination.selectedNumber = modelData[index.row]
//        }
//    }
   
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
      // 1
      switch kind {
      // 2
      case UICollectionView.elementKindSectionHeader:
        // 3
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
          ofKind: kind,
          withReuseIdentifier: "\(Header.self)",
          for: indexPath) as? Header
          else {
            fatalError("Invalid view type")
        }
        
//        let searchTerm = searches[indexPath.section].searchTerm
//        headerView.label.text = searchTerm
        return headerView
      default:
        // 4
        assert(false, "Invalid element type")
      }
    }
}
