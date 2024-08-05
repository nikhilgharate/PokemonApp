//
//  Pokemon.swift
//  PokemonApp
//
//  Created by iAURO on 29/07/24.


import Foundation

// Define a struct for the Pokémon model
struct Pokemon: Decodable,Identifiable{
    
    let id:Int
    let name:String
    let imageUrl:String
    let type:String
    let description:String
    let height:Int
    let weight:Int
    let attack:Int
    let defense:Int
    
    
}

// Mock data for testing purposes (commented out)

//let MOCK_POKEMON:[Pokemon] = [
//    .init(id:1,name:"bulbasaur",imageUrl: "",type: "poison", description: "",height: 12,weight: 5),
//    .init(id:1,name:"Ivysaur",imageUrl: "",type: "poison", description: "",height: 12,weight: 5),
//    .init(id:1,name:"V",imageUrl: "",type: "poison", description: "",height: 12,weight: 5),
//    .init(id:1,name:"bulbasaur",imageUrl: "",type: "fire", description: "",height: 12,weight: 5),
//    .init(id:1,name:"bulbasaur",imageUrl: "",type: "fire", description: "",height: 12,weight: 5),
//    .init(id:1,name:"bulbasaur",imageUrl: "",type: "fire", description: "",height: 12,weight: 5),
//    .init(id:1,name:"bulbasaur",imageUrl: "",type: "poison", description: "",height: 12,weight: 5),
//    .init(id:1,name:"bulbasaur",imageUrl: "",type: "poison", description: "",height: 12,weight: 5),
//    .init(id:1,name:"bulbasaur",imageUrl: "",type: "poison", description: "",height: 12,weight: 5),
//    .init(id:1,name:"bulbasaur",imageUrl: "",type: "poison", description: "",height: 12,weight: 5),
//    .init(id:1,name:"bulbasaur",imageUrl: "",type: "poison", description: "",height: 12,weight: 5),
//    
//]
