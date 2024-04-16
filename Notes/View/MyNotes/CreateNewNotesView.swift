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
    
    @State private var placeholderDesc: String = "Description"
    
    var body: some View {
        VStack(alignment: .leading, content: {
            Form(content: {
                TextField("Title", text: $noteTitle, axis: .vertical)
                    .font(.title)
                    .fontWeight(.bold)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .padding(.vertical)
                
                TextEditor(text: $noteDesc)
                    .foregroundStyle(self.noteDesc == placeholderDesc ? Color.secondary : Color.primary)
                    .onTapGesture(perform: {
                        if self.noteDesc == placeholderDesc {
                            self.noteDesc = ""
                        }
                    })
                    .onAppear(){
                        self.noteDesc = placeholderDesc
                    }
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                
            })
            .navigationTitle("New Note")
            .navigationBarBackButtonHidden(true)
            
            Spacer()
            
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
            .padding(.horizontal, 30)
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
