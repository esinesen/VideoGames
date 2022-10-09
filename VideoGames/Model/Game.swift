//
//  Game.swift
//  VideoGames
//
//  Created by Esin Esen on 6.03.2022.
//

import Foundation

struct Games: Decodable {
    let results : [Game]
}

struct Game: Decodable {
    static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.name == rhs.name
    }
    
    let id : Int
    let name : String
    let released : String
    let rating : Double
    let background_image : String
}

