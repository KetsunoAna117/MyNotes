//
//  PhotoPicker.swift
//  MyNotes
//
//  Created by Hans Arthur Cupiterson on 13/07/24.
//

import Foundation
import UIKit
import SwiftUI
import PhotosUI

/*
 Photopicker struct is a SwiftUI wrapper around PHPickerViewController,
 which is a modern replacement for UIImagePickerController for picking photos from the library
 USAGE: Call this on SwiftUI view like a regular view, for example:
    ```PhotoLibraryPicker(image: image)```
 */

struct PhotoLibraryPicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage? // Binding to hold the selected image
    let limitImageSelection = 1
    
    // This method creates a Coordinator instance which handles the delegation of PHPickerViewController
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // This method called when the view is created
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        
        configuration.selectionLimit = limitImageSelection // limit selection to one image
        configuration.filter = .images // filtering for images only
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    // This method is used to update this struct when SwiftUI view update, but not used in this case
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: PhotoLibraryPicker
        
        init(_ parent: PhotoLibraryPicker) {
            self.parent = parent
        }
        
        // this delegate method is called when an image is selected
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            if let result = results.first {
                result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                    if let uiImage = object as? UIImage {
                        DispatchQueue.main.async {
                            self.parent.selectedImage = uiImage
                            print("Image successfully inserted")
                        }
                    }
                }
            }
            picker.dismiss(animated: true, completion: nil) // Dismiss the photo picker
        }
    }
}
