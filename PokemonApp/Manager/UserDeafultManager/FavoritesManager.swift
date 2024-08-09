//
//  FavoritesManager.swift
//  PokemonApp
//
//  Created by iAURO on 05/08/24.
//
import Foundation

// Manager class for handling favorite Pokémon using UserDefaults
class FavoritesManager {
    // Key used to store favorite Pokémon IDs in UserDefaults
    private let favoritesKey = "favoritePokemonIDs"
    
    // Singleton instance for global access
    static let shared = FavoritesManager()
    
    // Private initializer to ensure only one instance is created
    private init() {}
    
    // Function to save the array of favorite Pokémon IDs to UserDefaults
    func saveFavorites(_ favorites: [Int]) {
        UserDefaults.standard.set(favorites, forKey: favoritesKey)
    }
    
    // Function to load the array of favorite Pokémon IDs from UserDefaults
    func loadFavorites() -> [Int] {
        // Return the saved array or an empty array if none exists
        return UserDefaults.standard.array(forKey: favoritesKey) as? [Int] ?? []
    }
    
    // Function to add a Pokémon ID to the favorites list
    func addFavorite(pokemonID: Int) {
        var favorites = loadFavorites()
        // Add the ID only if it's not already in the favorites list
        if !favorites.contains(pokemonID) {
            favorites.append(pokemonID)
            saveFavorites(favorites) // Save the updated list to UserDefaults
        }
    }
    
    // Function to remove a Pokémon ID from the favorites list
    func removeFavorite(pokemonID: Int) {
        var favorites = loadFavorites()
        // Find and remove the ID if it exists in the favorites list
        if let index = favorites.firstIndex(of: pokemonID) {
            favorites.remove(at: index)
            saveFavorites(favorites) // Save the updated list to UserDefaults
        }
    }
    
    // Function to check if a Pokémon ID is in the favorites list
    func isFavorite(pokemonID: Int) -> Bool {
        let favorites = loadFavorites()
        return favorites.contains(pokemonID)
    }
}
