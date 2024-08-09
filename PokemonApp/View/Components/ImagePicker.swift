//
//  ImagePicker.swift
//  PokemonApp
//
//  Created by iAURO on 07/08/24.
//
import SwiftUI
import PhotosUI
import FirebaseAuth

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
                if let user = Auth.auth().currentUser, let email = user.email {
                    FirebaseManager.shared.uploadImage(image, userID: user.uid, email: email) { result in
                        switch result {
                        case .success(let url):
                            print("Image uploaded successfully: \(url)")
                        case .failure(let error):
                            print("Failed to upload image: \(error)")
                        }
                    }
                }
            }
            picker.dismiss(animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}
