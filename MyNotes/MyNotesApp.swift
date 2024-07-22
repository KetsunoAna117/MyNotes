//
//  MyNotesApp.swift
//  MyNotes
//
//  Created by Hans Arthur Cupiterson on 12/07/24.
//

import SwiftUI
import SwiftData

@main
struct MyNotesApp: App {
    var sharedModelContainer: ModelContainer = ModelContainerProvider.createModelContainer()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
