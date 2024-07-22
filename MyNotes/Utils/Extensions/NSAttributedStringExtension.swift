//
//  NSAttributedStringExtension.swift
//  MyNotes
//
//  Created by Hans Arthur Cupiterson on 13/07/24.
//

import Foundation

extension NSAttributedString {
    static func get(from data: Data?) -> NSAttributedString? {
        guard let data else { return nil }
        var attributedString: NSAttributedString?
        do {
            attributedString = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSAttributedString.self, from: data)
        } catch {
            print("Error converting Data to NSAttributedString: \(error)")
        }
        return attributedString
    }
    
    var data: Data? {
        var data: Data?
        do {
            data = try NSKeyedArchiver.archivedData(withRootObject: self,
                                                    requiringSecureCoding: false)
        } catch {
            print("Error converting NSAttributedString to Data: \(error)")
        }
        return data
    }
}
