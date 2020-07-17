//
//  MapViewController.swift
//  AquaplusAppStoryBoards
//
//  Created by David Mendes Da Silva on 22/06/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var addressLabel: UILabel!
    
    var order: Order?
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        // 1
        locationManager.delegate = self
        
        // 2
        if CLLocationManager.locationServicesEnabled() {
            // 3
            locationManager.requestLocation()
            
            // 4
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        } else {
            // 5
            locationManager.requestWhenInUseAuthorization()
        }
        

        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString("HA9 0AT") {
            placemarks, error in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            print("Lat: \(lat), Lon: \(lon)")

                    // Creates a marker in the center of the map.
                    let marker = GMSMarker()

            marker.position = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)
                    marker.title = "Aquaplus"
                    marker.snippet = "Depot"
            marker.map = self.mapView
        }
        
    }
    
    func reverseGeocode(coordinate: CLLocationCoordinate2D) {
        // 1
        let geocoder = GMSGeocoder()

        // 2
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard
                let address = response?.firstResult(),
                let lines = address.lines
                else {
                    return
            }

            // 3
            self.addressLabel.text = lines.joined(separator: "\n")

            // 1
            let labelHeight = self.addressLabel.intrinsicContentSize.height
            let topInset = self.view.safeAreaInsets.top
            self.mapView.padding = UIEdgeInsets(
                top: topInset,
                left: 0,
                bottom: labelHeight,
                right: 0)

            // 4
            UIView.animate(withDuration: 0.25) {
                //self.pinImageVerticalConstraint.constant = (labelHeight - topInset) * 0.5
                self.view.layoutIfNeeded()
            }
        }
    }
    @IBAction func changeMapType(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Map Types", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(.init(title: "Normal", style: .default, handler: { (_) in
            self.mapView?.mapType = GMSMapViewType.normal
        }))
        actionSheet.addAction(.init(title: "Hybrid", style: .default, handler: { (_) in
            self.mapView?.mapType = GMSMapViewType.hybrid
        }))
        actionSheet.addAction(.init(title: "Satallite", style: .default, handler: { (_) in
            self.mapView?.mapType = GMSMapViewType.satellite
        }))
        actionSheet.addAction(.init(title: "Terrain", style: .default, handler: { (_) in
            self.mapView?.mapType = GMSMapViewType.terrain
        }))
        
        actionSheet.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
        
    }
    
    
}
// MARK: - CLLocationManagerDelegate
//1
extension MapViewController: CLLocationManagerDelegate {
    // 2
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        // 3
        guard status == .authorizedWhenInUse else {
            return
        }
        // 4
        locationManager.requestLocation()
        
        //5
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    // 6
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        // 7
        mapView.camera = GMSCameraPosition(
            target: location.coordinate,
            zoom: 15,
            bearing: 0,
            viewingAngle: 0)
    }
    
    // 8
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print(error)
    }
}
// MARK: - GMSMapViewDelegate
extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocode(coordinate: position.target)
    }
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
      //addressLabel.lock()
    }
    
}
