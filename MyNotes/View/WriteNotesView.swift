//
//  WriteNotesView.swift
//  MyNotes
//
//  Created by Hans Arthur Cupiterson on 13/07/24.
//

import SwiftUI
import RichTextKit

struct WriteNotesView: View {
    @ObservedObject var noteViewModel: NoteViewModel
    @Environment (\.dismiss) private var dismiss
    
    @Bindable var note: Note
    
    @State var text: NSAttributedString = NSMutableAttributedString(string: "")
    @StateObject private var context = RichTextContext()
    
    @FocusState private var isFocused: Bool
    @State private var noteSavedStatus: Bool = false
    
    @State private var isConfirmationDialogPresented: Bool = false
    @State private var isShowingImagePicker: Bool = false
    @State private var imageSourceType: ImageSourceType = .photoLibrary
    @State private var inputImage: UIImage?
    
    var body: some View {
        VStack {
            RichTextEditor(text: $text, context: context)
                .focusedValue(\.richTextContext, context)
                .focused($isFocused)
                .onAppear(){
                    isFocused = true
                }
            RichTextKeyboardToolbar(
                context: context,
                leadingButtons: {_ in },
                trailingButtons: {_ in
                    Button(action: {
                        isConfirmationDialogPresented = true
                    }, label: {
                        Image(systemName: "photo")
                    })
                },
                formatSheet: {$0}
            )
            
        }
        .toolbar(content: {
            Button(action: {
                if text.length > 0 {
                    noteSavedStatus = noteViewModel.trySaveNote(note: note, text: text)
                }
            }, label: {
                Text("Save")
            })
        })
        .onChange(of: noteSavedStatus, { oldValue, newValue in
            if noteSavedStatus {
                dismiss()
            }
        })
        .richTextEditorStyle(
            .init(font: .systemFont(ofSize: 16),
                  fontColor: .textColor)
        )
        .confirmationDialog("Select source", isPresented: $isConfirmationDialogPresented, actions: {
            Button("Camera") {
                self.imageSourceType = .camera
                self.isShowingImagePicker = true
            }
            Button("Photo Library") {
                self.imageSourceType = .photoLibrary
                self.isShowingImagePicker = true
            }
        })
        .sheet(isPresented: $isShowingImagePicker, onDismiss: {
            if let inputImage = inputImage {
                let cursorLocation = context.selectedRange.location
                let insertion = RichTextInsertion<UIImage>.image(inputImage, at: cursorLocation, moveCursor: true)
                let action = RichTextAction.pasteImage(insertion)
                context.handle(action)
                self.inputImage = nil
            }
        }, content: {
            switch imageSourceType {
            case .camera:
                CameraImagePicker(image: $inputImage, sourceType: .camera)
            case .photoLibrary:
                PhotoLibraryPicker(selectedImage: $inputImage)
            }
        })
        .navigationBarTitleDisplayMode(.inline)
        .padding()

    }
}

#Preview {
    NavigationStack {
        WriteNotesView(noteViewModel: NoteViewModel(), note: Note.getTestNote())
    }
}
