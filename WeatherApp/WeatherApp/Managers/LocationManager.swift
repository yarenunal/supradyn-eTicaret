//
//  LocationView.swift
//  WeatherApp
//
//  Created by Yaren on 18.12.2024.
//

import Foundation
import CoreLocation

class LocationManager : NSObject ,ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading = false
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLoacation () {
        isLoading = true
        manager.requestLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation] ){
        location = locations.first?.coordinate
        isLoading = false
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        isLoading = false
        print ("Error getting location" , error)
    }
}
