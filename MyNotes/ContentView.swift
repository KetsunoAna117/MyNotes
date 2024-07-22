//
//  ContentView.swift
//  MyNotes
//
//  Created by Hans Arthur Cupiterson on 12/07/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @StateObject private var noteViewModel = NoteViewModel()
    @State private var addButtonPressed: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                if noteViewModel.noteList.isEmpty == false {
                    // Section to display all saved notes in SwiftData
                    Section(header: Text("Notes List")) {
                        ForEach(noteViewModel.noteList, id: \.id) { note in
                            // This navigation link to navigate and edit created notes
                            NavigationLink(destination: {
                                if let text = StringDataConverter.convertDataToAttributedString(note) {
                                    WriteNotesView(noteViewModel: noteViewModel, note: note, text: text)
                                }
                            }) {
                                Text(DateHelper.formatDate(note.dateWritten))
                            }
                            // Add swipe right action to delete notes
                            .swipeActions {
                                Button(role: .destructive) {
                                    noteViewModel.deleteSelectedNote(note: note)
                                } label: {
                                    Text("Delete")
                                }
                            }
                            .animation(.easeIn, value: noteViewModel.noteList)
                        }
                    }
                } else {
                    Text("No Data...")
                }
            }
            .toolbar(content: {
                Button("Add") {
                    self.addButtonPressed = true
                }
            })
            .navigationDestination(isPresented: $addButtonPressed) {
                WriteNotesView(noteViewModel: noteViewModel, note: Note(encodedText: nil))
            }
            // When the view is appeared on the screen, fetch all note from SwiftData and display it
            .onAppear {
                noteViewModel.modelContext = modelContext
                noteViewModel.fetchAllNotesToList()
            }
            .navigationTitle("My Notes")
        }
    }
}

#Preview {
    ContentView()
}
