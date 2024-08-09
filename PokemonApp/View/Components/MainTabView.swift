//
//  MainTabView.swift
//  PokemonApp
//
//  Created by iAURO on 05/08/24.

import SwiftUI

// Main Tab View
struct MainTabView: View {
    @ObservedObject var viewModel = PokemonviewModel()

    var body: some View {
        TabView {
            // Home Tab with NavigationView
            NavigationView {
                PokemonView(viewModel: viewModel)
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            // Other tabs
            NavigationView {
                RankView(viewModel: viewModel)
            }
            .tabItem {
                Image(systemName: "bookmark.circle.fill")
                Text("Rank")
            }

            NavigationView {
                FavoritesView(viewModel: viewModel)
            }
            .tabItem {
                Image(systemName: "heart.circle.fill")
                Text("Favorite")
            }

            NavigationView {
                ProfileView()
            }
            .tabItem {
                               Label("Profile", systemImage: "person")
                           }
        }
    }
}

// Preview provider for the MainTabView
struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}