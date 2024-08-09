//
//  ContentView.swift
//  PokemonApp
//
//  Created by iAURO on 29/07/24.
//
//
//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        MainTabView()
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @AppStorage("uid") var userID: String = ""
    
    var body: some View {
        if userID == "" {
            AuthView()
        } else {
            MainTabView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
