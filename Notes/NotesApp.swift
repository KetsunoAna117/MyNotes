//
//  NotesApp.swift
//  Notes
//
//  Created by Hans Arthur Cupiterson on 16/04/24.
//

import SwiftUI

@main
struct NotesApp: App {
    @State private var database: NoteList = NoteList()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(database)
        }
    }
}
