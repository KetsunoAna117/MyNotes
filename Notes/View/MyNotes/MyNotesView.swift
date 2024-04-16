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
    @State private var modalDetent = PresentationDetent.medium
    
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
            .sheet(isPresented: $isAddNewNotePressed, content: {
                NavigationStack {
                    CreateNewNotesView()
                        .environmentObject(noteList)
                }
                .presentationDetents(
                    [.medium, .large],
                selection: $modalDetent)
            })

        }
    }
}

#Preview {
    MyNotesView()
        .environmentObject(NoteList())
}
