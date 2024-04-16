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
        NavigationStack {
            VStack(alignment: .leading) {
                // kondisi view berdasarkan tab
                TabView(selection: $activeTab, content:  {
                    switch activeTab {
                        case .mynotes:
                            MyNotesView()
                                .tag(Tab.mynotes)
                        case .myprofile:
                            Profile(user: noteList.user)
                                .tag(Tab.myprofile)
                        }
                })

            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(NoteList())
}
