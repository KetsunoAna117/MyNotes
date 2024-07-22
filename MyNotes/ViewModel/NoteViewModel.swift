//
//  NoteViewModel.swift
//  MyNotes
//
//  Created by Hans Arthur Cupiterson on 13/07/24.
//

import Foundation
import SwiftData
import UIKit

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
        guard let data = convertAttributedStringToArchivedData(text) else { return false }
        
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
    
    func loadImageIntoCursor(inputImage: UIImage, text: NSAttributedString) -> NSAttributedString {
        let newImage = UIImage.resizeImage(image: inputImage, targetSize: CGSize(width: 300, height: 100))
        let attachment = NSTextAttachment()
        attachment.image = newImage
        
        let attributedString = NSAttributedString(attachment: attachment)
        let muttableAttributedString = NSMutableAttributedString(attributedString: text)
        
        muttableAttributedString.append(attributedString)
        return muttableAttributedString
        
    }
    
    func convertAttributedStringToArchivedData(_ attributedString: NSAttributedString) -> Data? {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: attributedString, requiringSecureCoding: false)
            return data
        } catch {
            print("Failed to archive NSAttributedString: \(error)")
            return nil
        }
    }
    
    func convertDataToAttributedString(_ note: Note) -> NSAttributedString? {
        if let encodedText = note.encodedText {
            return try? NSAttributedString(data: encodedText, format: .archivedData)
        }
        return nil
    }

}
