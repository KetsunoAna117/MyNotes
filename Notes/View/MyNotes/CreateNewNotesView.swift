//
//  CreateNewNotesView.swift
//  Notes
//
//  Created by Hans Arthur Cupiterson on 16/04/24.
//

import SwiftUI

struct CreateNewNotesView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var noteList: NoteList
    @State private var noteTitle: String = ""
    @State private var noteDesc: String = ""
    
    var body: some View {
        VStack(alignment: .leading, content: {
            List {
                Section {
                    TextField("", text: $noteTitle, axis: .vertical)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 1)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                } header: {
                    Text("Title")
                }
                
                Section {
                    TextField("", text: $noteDesc, axis: .vertical)
                        .font(.body)
                        .foregroundStyle(Color.secondary)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                } header: {
                    Text("Content")
                }

            }
            .listStyle(.insetGrouped)
            .navigationTitle("New Note")
            .navigationBarBackButtonHidden(true)
            
            Button {
                let newNote = Notes(title: noteTitle, content: noteDesc)
                noteList.notes.append(newNote)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal, 40)
            .padding(.vertical, 10)

        })
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    NavigationStack {
        CreateNewNotesView()
            .environmentObject(NoteList())
    }
    
}
