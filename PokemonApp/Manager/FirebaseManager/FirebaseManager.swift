//
//  FirebaseManager.swift
//  PokemonApp
//
//  Created by iAURO on 07/08/24.
//

import FirebaseStorage
import FirebaseDatabase
import UIKit

class FirebaseManager {
    static let shared = FirebaseManager()
    
    private init() {}
    
    func uploadImage(_ image: UIImage, userID: String, email: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child("profileImages/\(userID).jpg")
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "ImageError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data"])))
            return
        }
        
        imageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            imageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let url = url {
                    print("Image URL: \(url.absoluteString)")
                    self.saveUserMetadataToRealtimeDatabase(userID: userID, email: email, imageUrl: url.absoluteString)
                    completion(.success(url))
                } else {
                    completion(.failure(NSError(domain: "URLFetchError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve download URL"])))
                }
            }
        }
    }
    
    func saveUserMetadataToRealtimeDatabase(userID: String, email: String, imageUrl: String) {
        let databaseRef = Database.database().reference().child("users").child(userID)
        let values = [
            "email": email,
            "imageUrl": imageUrl,
            "userID": userID
        ]
        
        databaseRef.setValue(values) { error, _ in
            if let error = error {
                print("Failed to save user metadata: \(error)")
            } else {
                print("User metadata saved successfully.")
            }
        }
    }
}
