//
//  NotesDetailView.swift
//  Notes
//
//  Created by Hans Arthur Cupiterson on 16/04/24.
//

import SwiftUI

struct NotesDetailView: View {
    @Binding var notes: Notes
    
    var body: some View {
        VStack(alignment: .leading, content: {
            Form(content: {
                TextField("Title", text: $notes.title, axis: .vertical)
                    .font(.title)
                    .fontWeight(.bold)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .padding(.vertical)
                
                TextEditor(text: $notes.content)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .frame(height: 500)
                
            })
            .navigationTitle("Note Details")

        })
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    NavigationStack {
        NotesDetailView(notes: .constant(NoteList().notes[0]))
    }
}
