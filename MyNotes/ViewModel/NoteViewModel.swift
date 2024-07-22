//
//  NoteViewModel.swift
//  MyNotes
//
//  Created by Hans Arthur Cupiterson on 13/07/24.
//

import Foundation
import SwiftData
import UIKit
import RichTextKit

class NoteViewModel: ObservableObject {
    var modelContext: ModelContext?
    @Published var noteList: [Note] = []
    
    func fetchAllNotesToList(){
        guard let modelContext = modelContext else { return }
        noteList.removeAll()
        
        let fetchDescriptor = FetchDescriptor<Note>()
        guard let fetchedNote = try? modelContext.fetch(fetchDescriptor) else { return }
        noteList = fetchedNote
    }
    
    func trySaveNote(note: Note, text: NSAttributedString) -> Bool {
        guard let data = StringDataConverter.convertAttributedStringToArchivedData(text) else { return false }
        
        guard let modelContext = modelContext else {
            print("Note can't be saved due to missing model context")
            return false
        }
        
        if note.encodedText != nil {
            print("Update value")
            note.encodedText = data
            return true
        }
        
        let note = Note(encodedText: data)
        modelContext.insert(note)
        try? modelContext.save()
        
        print("new note saved")
        return true
    }
    
    
    func deleteSelectedNote(note: Note) {
        modelContext?.delete(note)
        self.fetchAllNotesToList()
    }
    
    func loadImageIntoCursor(inputImage: UIImage, context: RichTextContext) {
        let cursorLocation = context.selectedRange.location
        let insertion = RichTextInsertion<UIImage>.image(inputImage, at: cursorLocation, moveCursor: true)
        let action = RichTextAction.pasteImage(insertion)
        context.handle(action)
    }

}
