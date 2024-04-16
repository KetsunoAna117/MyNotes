//
//  NotesDetailView.swift
//  Notes
//
//  Created by Hans Arthur Cupiterson on 16/04/24.
//

import SwiftUI

struct NotesDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var notes: Notes
    
    var body: some View {
        VStack(alignment: .leading, content: {
            List {
                Section {
                    TextField("", text: $notes.title, axis: .vertical)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 1)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                } header: {
                    Text("Title")
                }
                
                Section {
                    TextField("", text: $notes.content, axis: .vertical)
                        .font(.body)
                        .foregroundStyle(Color.secondary)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                } header: {
                    Text("Content")
                }

            }
            .listStyle(.insetGrouped)
            .navigationTitle("Note Details")
            .navigationBarBackButtonHidden(true)
            
            Button {
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
        NotesDetailView(notes: .constant(NoteList().notes[0]))
    }
}
