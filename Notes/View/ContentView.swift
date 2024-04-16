//
//  ContentView.swift
//  Notes
//
//  Created by Hans Arthur Cupiterson on 16/04/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var noteList: NoteList
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                MyNotesView()
                    .environmentObject(noteList)
//                Profile(user: noteList.user)
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(NoteList())
}
