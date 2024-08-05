//
//  PokemonViewModel.swift
//  PokemonApp
//
//  Created by iAURO on 29/07/24.

import SwiftUI
import Combine

// ViewModel class to manage Pokémon data
class PokemonviewModel: ObservableObject {
    @Published var pokemon = [Pokemon]()
    @Published var filteredPokemon = [Pokemon]()
    @Published var favoritePokemonIDs = Set<Int>() // Set to manage favorite Pokémon IDs

    
    @Published var minAttack: String = ""
    @Published var minDefense: String = ""
    
    @Published var isLoading: Bool = false // Add a loading state
    
    private var cancellables = Set<AnyCancellable>()
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
        
        fetchPokemon { success in
            if !success {
                print("Failed to fetch Pokémon data")
            }
        }
    }
    
    func fetchPokemon(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: API.baseUrl) else {
            completion(false)
            return
        }
        
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let data = data?.parseData(removeString: "null,") else {
                completion(false)
                return
            }
            
            do {
                let pokemonList = try JSONDecoder().decode([Pokemon].self, from: data)
                DispatchQueue.main.async {
                    self.pokemon = pokemonList
                    self.filteredPokemon = pokemonList
                    completion(true)
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion(false)
            }
        }.resume()
    }
    
    // Function to filter Pokémon based on attack and defense values
    func applyFilters() {
        self.isLoading = true // Start loading
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let attack = Int(self?.minAttack ?? "") ?? 0
            let defense = Int(self?.minDefense ?? "") ?? 0
            let filtered = self?.pokemon.filter { $0.attack >= attack && $0.defense >= defense } ?? []
            
            DispatchQueue.main.async {
                self?.filteredPokemon = filtered
                self?.isLoading = false // Stop loading
            }
        }
    }
    
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
    
    func toggleFavorite(pokemonID: Int) {
            if favoritePokemonIDs.contains(pokemonID) {
                favoritePokemonIDs.remove(pokemonID)
            } else {
                favoritePokemonIDs.insert(pokemonID)
            }
        }
    
        var favoritePokemon: [Pokemon] {
            pokemon.filter { favoritePokemonIDs.contains($0.id) }
        }
    }


// Extension to add a function for parsing data
extension Data {
    func parseData(removeString string: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: "")
        guard let data = parsedDataString?.data(using: .utf8) else {
            return nil
        }
        return data
    }
}

//
//import SwiftUI
//import Combine
//
//class PokemonviewModel: ObservableObject {
//    @Published var pokemon = [Pokemon]()
//    @Published var filteredPokemon = [Pokemon]()
//    @Published var favoritePokemonIDs = Set<Int>() // Set to manage favorite Pokémon IDs
//    
//    @Published var minAttack: String = "" {
//        didSet {
//            applyFilters()
//        }
//    }
//    
//    @Published var minDefense: String = "" {
//        didSet {
//            applyFilters()
//        }
//    }
//    
//    private var cancellables = Set<AnyCancellable>()
//    private let session: URLSession
//    
//    init(session: URLSession = .shared) {
//        self.session = session
//        
//        fetchPokemon { success in
//            if !success {
//                print("Failed to fetch Pokémon data")
//            }
//        }
//        
//        Publishers.CombineLatest($minAttack, $minDefense)
//            .sink { [weak self] attack, defense in
//                self?.applyFilters()
//            }
//            .store(in: &cancellables)
//    }
//    
//    func fetchPokemon(completion: @escaping (Bool) -> Void) {
//        guard let url = URL(string: API.baseUrl) else {
//            completion(false)
//            return
//        }
//        
//        session.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("Error fetching data: \(error.localizedDescription)")
//                completion(false)
//                return
//            }
//            
//            guard let data = data?.parseData(removeString: "null,") else {
//                completion(false)
//                return
//            }
//            
//            do {
//                let pokemonList = try JSONDecoder().decode([Pokemon].self, from: data)
//                DispatchQueue.main.async {
//                    self.pokemon = pokemonList
//                    self.filteredPokemon = pokemonList
//                    completion(true)
//                }
//            } catch {
//                print("Error decoding data: \(error.localizedDescription)")
//                completion(false)
//            }
//        }.resume()
//    }
//    
//    func applyFilters() {
//        let attack = Int(minAttack) ?? 0
//        let defense = Int(minDefense) ?? 0
//        self.filteredPokemon = pokemon.filter { $0.attack >= attack && $0.defense >= defense }
//    }
//    
//    func backgroundColor(forType type: String) -> UIColor {
//        switch type {
//        case "fire": return .systemRed
//        case "poison": return .systemGreen
//        case "water": return .systemBlue
//        case "electric": return .systemYellow
//        case "psychic": return .systemPurple
//        case "normal": return .systemOrange
//        case "ground": return .systemGray
//        case "flying": return .systemTeal
//        case "fairy": return .systemPink
//        default: return .systemIndigo
//        }
//    }
//    
//    func toggleFavorite(pokemonID: Int) {
//        if favoritePokemonIDs.contains(pokemonID) {
//            favoritePokemonIDs.remove(pokemonID)
//        } else {
//            favoritePokemonIDs.insert(pokemonID)
//        }
//    }
//    
//    var favoritePokemon: [Pokemon] {
//        pokemon.filter { favoritePokemonIDs.contains($0.id) }
//    }
//}
//
//extension Data {
//    func parseData(removeString string: String) -> Data? {
//        let dataAsString = String(data: self, encoding: .utf8)
//        let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: "")
//        guard let data = parsedDataString?.data(using: .utf8) else {
//            return nil
//        }
//        return data
//    }
//}
