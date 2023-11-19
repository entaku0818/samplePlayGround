//
//  DelegateViewController.swift
//  samplePlayGround
//
//  Created by 遠藤拓弥 on 19.11.2023.
//

import Foundation
import UIKit
import MapKit
import SwiftUI

struct MapView: View {
    @State private var locationDescription: String = "Location not available"

    var body: some View {
        VStack {
            Text(locationDescription)
            Button("Get Location") {
                Task {
                    await fetchLocation()
                }
            }
        }
    }

    private func fetchLocation() async {
        let locationManager = LocationManager()
        do {
            for try await location in locationManager.requestLocation() {
                self.locationDescription = "Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)"
            }
        } catch {
            self.locationDescription = "Failed to get location: \(error.localizedDescription)"
        }
    }
}


