//
//  Practice_SwiftUIApp.swift
//  Practice SwiftUI
//
//  Created by Ahmed Yamany on 17/08/2023.
//

import SwiftUI

@main
struct Practice_SwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
