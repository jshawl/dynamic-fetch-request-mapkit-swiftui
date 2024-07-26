//
//  dynamic_map_fetch_requestApp.swift
//  dynamic-map-fetch-request
//
//  Created by Jesse Shawl on 7/26/24.
//

import SwiftUI

@main
struct dynamic_map_fetch_requestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
