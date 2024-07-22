//
//  Notes.swift
//  MyNotes
//
//  Created by Hans Arthur Cupiterson on 13/07/24.
//

import Foundation
import SwiftData
import UIKit
import RichTextKit

@Model
class Note: Hashable {
    var id: UUID
    var encodedText: Data?
    var dateWritten: Date
    
    init(encodedText: Data?){
        self.dateWritten = Date.now
        self.id = UUID()
        self.encodedText = encodedText
    }
    
    static func getTestNote() -> Note {
        guard let data = StringDataConverter.convertAttributedStringToArchivedData(NSAttributedString(string: "This is a test")) else {
            return Note(encodedText: nil)
        }
        return Note(encodedText: data)
    }

}


