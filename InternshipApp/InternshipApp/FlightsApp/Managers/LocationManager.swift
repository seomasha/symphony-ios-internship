//
//  LocationManager.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 10. 9. 2024..
//

import Foundation
import SwiftUI
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager?
    
    @Published var isLocationGranted: Bool = false
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var currentLocation: CLLocation?
    
    override init() {
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocationPermission() {
        guard let locationManager = locationManager else { return }
        
        let status = locationManager.authorizationStatus
        checkLocationPermission(status: status)
    }
    
    private func checkLocationPermission(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .restricted, .denied:
            isLocationGranted = false
            print("Restricted, denied")
        case .authorizedWhenInUse, .authorizedAlways:
            isLocationGranted = true
            locationManager?.startUpdatingLocation()
        @unknown default:
            break
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        locationStatus = status
        checkLocationPermission(status: status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
        locationManager?.stopUpdatingLocation()
    }
}
