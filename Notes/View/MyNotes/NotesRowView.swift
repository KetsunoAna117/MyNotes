//
//  NotesRowView.swift
//  Notes
//
//  Created by Hans Arthur Cupiterson on 16/04/24.
//

import SwiftUI

struct NotesRowView: View {
    var notes: Notes
    
    var body: some View {
        VStack(alignment: .leading, content: {
            Text(notes.title)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .lineLimit(1)
                .truncationMode(.tail)
                .padding(.bottom, 1)
            Text(notes.content)
                .font(.caption)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .truncationMode(.tail)
                .foregroundStyle(Color.secondary)
        })
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    NotesRowView(notes: NoteList().notes[0])
}
