//
//  PokemonViewModel.swift
//  PokemonApp
//
//  Created by iAURO on 29/07/24.
import SwiftUI
import Combine

// ViewModel class to manage Pokémon data
class PokemonviewModel: ObservableObject {
    // Published properties that will trigger view updates when modified
    @Published var pokemon = [Pokemon]()
    @Published var filteredPokemon = [Pokemon]()
    @Published var favoritePokemonIDs: [Int] = []
    
    @Published var minAttack: String = ""
    @Published var minDefense: String = ""
    
    // To manage Combine subscriptions
    private var cancellables = Set<AnyCancellable>()
    private let session: URLSession
    
    // Initializer to set up the session and fetch Pokémon data
    init(session: URLSession = .shared) {
        self.session = session
        
        // Fetch Pokémon data when the view model is initialized
        fetchPokemon { success in
            if !success {
                print("Failed to fetch Pokémon data")
            }
        }
        
        // Load favorite Pokémon IDs from UserDefaults
        loadFavorites()
    }
    
    // Function to fetch Pokémon data from the API
    func fetchPokemon(completion: @escaping (Bool) -> Void) {
        // Ensure the URL is valid
        guard let url = URL(string: API.baseUrl) else {
            completion(false)
            return
        }
        
        // Start a data task to fetch the data from the URL
        session.dataTask(with: url) { data, response, error in
            // Handle any errors that occurred during the fetch
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            // Ensure the data is not nil and parse it
            guard let data = data?.parseData(removeString: "null,") else {
                completion(false)
                return
            }
            
            // Decode the data into an array of Pokémon
            do {
                let pokemonList = try JSONDecoder().decode([Pokemon].self, from: data)
                // Update the Pokémon array on the main thread
                DispatchQueue.main.async {
                    self.pokemon = pokemonList
                    self.filteredPokemon = pokemonList
                    completion(true)
                }
            } catch {
                // Handle any errors that occurred during decoding
                print("Error decoding data: \(error.localizedDescription)")
                completion(false)
            }
        }.resume()
    }
    
    // Function to filter Pokémon based on attack and defense values
    func applyFilters() {
        let attack = Int(minAttack) ?? 0
        let defense = Int(minDefense) ?? 0
        // Filter Pokémon based on attack and defense criteria
        self.filteredPokemon = pokemon.filter { $0.attack >= attack && $0.defense >= defense }
    }
    
    // Function to toggle a Pokémon ID in the favorites list
    func toggleFavorite(pokemonID: Int) {
        // If the Pokémon ID is already in the favorites, remove it; otherwise, add it
        if favoritePokemonIDs.contains(pokemonID) {
            FavoritesManager.shared.removeFavorite(pokemonID: pokemonID)
        } else {
            FavoritesManager.shared.addFavorite(pokemonID: pokemonID)
        }
        // Reload the favorites from UserDefaults
        loadFavorites()
    }
    
    // Function to load favorite Pokémon IDs from UserDefaults
    func loadFavorites() {
        favoritePokemonIDs = FavoritesManager.shared.loadFavorites()
    }
    
    // Computed property to return the favorite Pokémon
    var favoritePokemon: [Pokemon] {
        return pokemon.filter { favoritePokemonIDs.contains($0.id) }
    }
    
    // Function to determine the background color based on Pokémon type
    func backgroundColor(forType type: String) -> UIColor {
        switch type {
        case "fire": return .systemRed
        case "poison": return .systemGreen
        case "water": return .systemBlue
        case "electric": return .systemYellow
        case "psychic": return .systemPurple
        case "normal": return .systemOrange
        case "ground": return .systemGray
        case "flying": return .systemTeal
        case "fairy": return .systemPink
        default: return .systemIndigo
        }
    }
}

// Extension to add a function for parsing data
extension Data {
    // Function to parse data and remove a specified string
    func parseData(removeString string: String) -> Data? {
        // Convert data to string
        let dataAsString = String(data: self, encoding: .utf8)
        // Remove the specified string from the data string
        let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: "")
        // Convert the string back to data
        guard let data = parsedDataString?.data(using: .utf8) else {
            return nil
        }
        return data
    }
}
