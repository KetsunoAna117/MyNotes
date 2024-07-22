//
//  ImagePicker.swift
//  MyNotes
//
//  Created by Hans Arthur Cupiterson on 13/07/24.
//

import SwiftUI

/*
 This struct is used to open a view to handle take a image from camera
 USAGE: Call this on SwiftUI view like a regular view, for example:
    ```ImagePicker(image: image)```
 */
struct CameraImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage? // Binding to hold the selected image
    
    var sourceType: UIImagePickerController.SourceType // Specifies the source type for the image
    
    // This method creates a Coordinator instance which handles the delegation of UIImagePickerController
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // This method called when the view is created
    func makeUIViewController(context: UIViewControllerRepresentableContext<CameraImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator // set the delegate to handle image picker events
        picker.sourceType = sourceType // set the source type to photo library
        picker.mediaTypes = ["public.image"]
        picker.modalPresentationStyle = .fullScreen
        return picker
    }
    
    // This method is used to update this struct when SwiftUI view update, but not used in this case
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    // Coordinator class to handle the delegate methods of UIImagePickerController
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: CameraImagePicker
        
        init(_ parent: CameraImagePicker) {
            self.parent = parent
        }
        
       
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        // This delegate method is called when the image picker is cancelled
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
