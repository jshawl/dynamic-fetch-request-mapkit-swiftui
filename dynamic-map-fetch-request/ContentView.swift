//
//  ContentView.swift
//  dynamic-map-fetch-request
//
//  Created by Jesse Shawl on 7/26/24.
//

import SwiftUI
import CoreData
import MapKit

struct ContentView: View {
    var body: some View {
        Map().onMapCameraChange(frequency: .continuous) { context in
            print(bounds(region: context.region))
        }
    }
}

struct Bounds {
    var minLatitude: Double
    var maxLatitude: Double
    var minLongitude: Double
    var maxLongitude: Double
}

func bounds(region: MKCoordinateRegion) -> Bounds {
    return Bounds(
        minLatitude: region.center.latitude - (region.span.latitudeDelta / 2.0),
        maxLatitude: region.center.latitude + (region.span.latitudeDelta / 2.0),
        minLongitude: region.center.longitude - (region.span.longitudeDelta / 2.0),
        maxLongitude: region.center.longitude + (region.span.longitudeDelta / 2.0)
    )
}
