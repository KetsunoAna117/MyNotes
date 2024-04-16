//
//  ContentView.swift
//  Notes
//
//  Created by Hans Arthur Cupiterson on 16/04/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var noteList: NoteList
    @State private var activeTab = Tab.mynotes
    
    // make enum
    enum Tab {
        case mynotes
        case myprofile
    }
    
    var body: some View {
        // kondisi view berdasarkan tab
        TabView(selection: $activeTab, content:  {
            MyNotesView(filteredNotes: noteList.notes)
                .environmentObject(noteList)
                .tag(Tab.mynotes)
                .tabItem {
                    Label("My Notes", systemImage: "note")
                }
            
            Profile(user: noteList.user)
                .tag(Tab.myprofile)
                .tabItem {
                    Label("My Profile", systemImage: "person")
                }
        })
    }
}

#Preview {
    ContentView()
        .environmentObject(NoteList())
}
