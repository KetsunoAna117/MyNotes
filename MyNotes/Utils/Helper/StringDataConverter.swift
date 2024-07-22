//
//  StringDataConverter.swift
//  MyNotes
//
//  Created by Hans Arthur Cupiterson on 22/07/24.
//

import Foundation

struct StringDataConverter {
    static func convertAttributedStringToArchivedData(_ attributedString: NSAttributedString) -> Data? {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: attributedString, requiringSecureCoding: false)
            return data
        } catch {
            print("Failed to archive NSAttributedString: \(error)")
            return nil
        }
    }
    
    static func convertDataToAttributedString(_ note: Note) -> NSAttributedString? {
        if let encodedText = note.encodedText {
            return try? NSAttributedString(data: encodedText, format: .archivedData)
        }
        return nil
    }
}
