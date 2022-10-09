//
//  DetailsVC.swift
//  VideoGames
//
//  Created by Esin Esen on 8.03.2022.
//

import UIKit

class DetailsVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var metacriticLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var gameDetailsImage: UIImageView!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var navigator: UINavigationItem!
    
    static var id = " "
    static var selectedGame = [Game]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData(gameId: DetailsVC.id)

        if FavoritesVC.favGames.contains(where: { $0 == DetailsVC.selectedGame[0]}){
            favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else {
            favBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
        
    @IBAction func favBtnClicked(_ sender: Any) {

        if(favBtn.currentImage == UIImage(systemName: "heart")){
            FavoritesVC.favGames.append(DetailsVC.selectedGame[0])
            favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else if(favBtn.currentImage == UIImage(systemName: "heart.fill")){
            FavoritesVC.favGames.removeAll(where: {$0 == DetailsVC.selectedGame[0]})
            
            favBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }


    func getData(gameId : String){
        
        var gameDetails : GameDetails
        let urlStr = "https://api.rawg.io/api/games/\(gameId)?key=4885d5e4c21b4c95ba59b5e979506028"
        guard let gameURL = URL(string: urlStr) else { return }
        let gameList = try? JSONDecoder().decode(GameDetails.self, from: Data(contentsOf: gameURL))
        guard let games = gameList else { return }
        gameDetails = games

        let model = gameDetails
        nameLabel.text = model.name
        releasedLabel.text = model.released
        metacriticLabel.text = "Rating: \(String(model.metacritic)) / 100"
        ratingLabel.text = "Metacritic: \(String(model.rating)) / 5"
        descriptionText.text = model.description_raw
        
        let gameImageUrl = model.background_image
        if let imageUrl = URL(string: gameImageUrl) {
            if let data = try? Data(contentsOf: imageUrl) {
                self.gameDetailsImage.image = UIImage(data: data)
            }
        }
        DetailsVC.selectedGame.insert(Game(id: Int(DetailsVC.id)!, name: model.name, released: model.released, rating: model.rating, background_image: model.background_image), at: 0)
    }
}

