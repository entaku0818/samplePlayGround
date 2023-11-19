//
//  LocationClient.swift
//  samplePlayGround
//
//  Created by 遠藤拓弥 on 19.11.2023.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private var continuation: AsyncThrowingStream<CLLocation, Error>.Continuation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // 位置情報サービスの使用許可をユーザーに求める
    }

    func requestLocation() -> AsyncThrowingStream<CLLocation, Error> {
        return AsyncThrowingStream { continuation in
            self.continuation = continuation
            self.locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            continuation?.yield(location)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        continuation?.finish(throwing: error)
    }
}

