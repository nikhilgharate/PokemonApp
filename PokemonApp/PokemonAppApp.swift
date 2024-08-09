//
//  PokemonAppApp.swift
//  PokemonApp
//
//  Created by iAURO on 29/07/24.
//

import SwiftUI
import FirebaseCore


@main
struct PokemonAppApp: App {
    
    init() {
          FirebaseApp.configure()
      }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
