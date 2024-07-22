//
//  ModelContainerProvider.swift
//  MyNotes
//
//  Created by Hans Arthur Cupiterson on 13/07/24.
//

import Foundation
import SwiftData

class ModelContainerProvider {
    static func createModelContainer() ->  ModelContainer {
        let schema = setModelContainerSchema()
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            let container = try ModelContainer(for: schema, configurations: modelConfiguration)
            return container
        } catch {
            fatalError("Could not create the Model Container: \(error)")
        }
    }
    
    private static func setModelContainerSchema() -> Schema {
        return Schema([
            Note.self
        ])
    }
}
