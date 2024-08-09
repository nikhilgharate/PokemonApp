//
//  ProfileView.swift
//  PokemonApp
//
//  Created by iAURO on 07/08/24.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @AppStorage("uid") var userID: String = ""
    @State private var isPickerPresented = false
    @State private var selectedImage: UIImage? = nil
    
    var body: some View {
        VStack {
            if let user = Auth.auth().currentUser {
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 10)
                        .padding()
                } else {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 150, height: 150)
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 10)
                        .padding()
                }
                
                Button(action: {
                    isPickerPresented.toggle()
                }) {
                    Text("Upload Selfie")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue)
                        )
                        .padding(.horizontal)
                }
                .sheet(isPresented: $isPickerPresented) {
                    ImagePicker(selectedImage: $selectedImage)
                }
                
                Text("Email: \(user.email ?? "No email")")
                    .font(.title)
                    .padding()
                
                Button(action: {
                    do {
                        try Auth.auth().signOut()
                        withAnimation {
                            userID = ""
                            selectedImage = nil
                        }
                    } catch let signOutError as NSError {
                        print("Error signing out: %@", signOutError)
                    }
                }) {
                    Text("Log Out")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.red)
                        )
                        .padding(.horizontal)
                }
            } else {
                Text("No user is logged in.")
                    .font(.title)
                    .padding()
            }
        }
        .padding()
        .onChange(of: selectedImage) { newImage in
            if let image = newImage, let user = Auth.auth().currentUser {
                FirebaseManager.shared.uploadImage(image, userID: user.uid, email: user.email ?? "") { result in
                    switch result {
                    case .success(let url):
                        print("Image uploaded successfully: \(url)")
                    case .failure(let error):
                        print("Failed to upload image: \(error)")
                    }
                }
            }
        }
    }
}
