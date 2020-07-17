//
//  MapTasks.swift
//  AquaplusAppStoryBoards
//
//  Created by David Mendes Da Silva on 10/07/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import UIKit

class MapTasks: NSObject {
    
    let baseURLGeocode = "https://maps.googleapis.com/maps/api/geocode/json?"
     
    var lookupAddressResults: Dictionary<NSObject, AnyObject>!
     
    var fetchedFormattedAddress: String!
     
    var fetchedAddressLongitude: Double!
     
    var fetchedAddressLatitude: Double!
    
    override init() {
        super.init()
    }
    
    
    
}
