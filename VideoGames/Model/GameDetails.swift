//
//  GameDetails.swift
//  VideoGames
//
//  Created by Esin Esen on 8.03.2022.
//

import UIKit

struct GameDetails: Codable {
    let id : Int
    let name : String
    let released : String
    let metacritic : Int
    let rating : Double
    let background_image : String
    let description_raw : String
}

