//
//  FavoritesManager.swift
//  PokemonApp
//
//  Created by iAURO on 05/08/24.
//
import Foundation

class FavoritesManager {
    private let favoritesKey = "favoritePokemonIDs"
    
    static let shared = FavoritesManager()
    
    private init() {}
    
    func saveFavorites(_ favorites: [Int]) {
        UserDefaults.standard.set(favorites, forKey: favoritesKey)
    }
    
    func loadFavorites() -> [Int] {
        return UserDefaults.standard.array(forKey: favoritesKey) as? [Int] ?? []
    }
    
    func addFavorite(pokemonID: Int) {
        var favorites = loadFavorites()
        if !favorites.contains(pokemonID) {
            favorites.append(pokemonID)
            saveFavorites(favorites)
        }
    }
    
    func removeFavorite(pokemonID: Int) {
        var favorites = loadFavorites()
        if let index = favorites.firstIndex(of: pokemonID) {
            favorites.remove(at: index)
            saveFavorites(favorites)
        }
    }
    
    func isFavorite(pokemonID: Int) -> Bool {
        let favorites = loadFavorites()
        return favorites.contains(pokemonID)
    }
}
