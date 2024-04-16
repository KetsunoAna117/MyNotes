//
//  MyNotesView.swift
//  Notes
//
//  Created by Hans Arthur Cupiterson on 16/04/24.
//

import SwiftUI

struct MyNotesView: View {
    @EnvironmentObject private var noteList: NoteList
    @Environment(\.editMode) var editMode
    
    @State private var isAddNewNotePressed: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($noteList.notes, id: \.self) { $note in
                    NavigationLink {
                        NotesDetailView(notes: $note)
                    } label: {
                        NotesRowView(notes: note)
                    }
                }
            }
            .navigationTitle("My Notes")
            .toolbar(content: {
                Button(action: {
                    isAddNewNotePressed = true
                }, label: {
                    Image(systemName: "doc.badge.plus")
                })
            })
            .navigationDestination(
                isPresented: $isAddNewNotePressed) {
                    CreateNewNotesView()
                        .environmentObject(noteList)
            }
        }
    }
}

#Preview {
    MyNotesView()
        .environmentObject(NoteList())
}
