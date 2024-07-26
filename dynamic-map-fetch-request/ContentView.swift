//
//  ContentView.swift
//  dynamic-map-fetch-request
//
//  Created by Jesse Shawl on 7/26/24.
//

import SwiftUI
import CoreData
import MapKit

struct PolylineView: MapContent {
    @FetchRequest var fetchRequest: FetchedResults<Item>

    init(region: MKCoordinateRegion?){
        if region != nil {
            let regionBounds = bounds(region: region!)
            _fetchRequest = FetchRequest<Item>(
                sortDescriptors: [],
                predicate: NSPredicate(
                    format: "latitude > %f AND latitude < %f AND longitude > %f AND longitude < %f",
                    regionBounds.minLatitude,
                    regionBounds.maxLatitude,
                    regionBounds.minLongitude,
                    regionBounds.maxLongitude
                )
            )
        } else {
            // fetch nothing
            _fetchRequest = FetchRequest<Item>(
                sortDescriptors: [],
                predicate: NSPredicate(
                    format: "latitude = %f",
                    -200.0
                )
            )
        }
    }

    var body: some MapContent {
        let coordinates = fetchRequest.map { item in
                    CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
        }
        MapPolyline(coordinates: coordinates).stroke(.blue, lineWidth: 2.0)
    }
}

struct ContentView: View {
    @State var region: MKCoordinateRegion?;
    var body: some View {
        Map(){
            PolylineView(region: region)
        }.onMapCameraChange(frequency: .continuous) { context in
            region = context.region
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
