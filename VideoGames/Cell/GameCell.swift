//
//  GameCell.swift
//  VideoGames
//
//  Created by Esin Esen on 7.03.2022.
//

import UIKit

class GameCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var gameImage: UIImageView!
    
    var id = ""
    
    override func awakeFromNib() {
      super.awakeFromNib()
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.darkGray.cgColor
    }
    override var isSelected: Bool {
       didSet{
           if self.isSelected {
               UIView.animate(withDuration: 0.3) {
                   self.backgroundColor = UIColor(red: 64/255, green: 64/255, blue: 64/255, alpha: 0.5)
               }
           }
           else {
               UIView.animate(withDuration: 0.3) {
                    self.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
               }
           }
       }
   } 
    
    func configure(model: Game) {
        self.nameLabel.text = model.name
        self.releasedLabel.text = model.released
        self.ratingLabel.text = String(model.rating)
        self.id = String(model.id)
        
        let gameImageUrl = model.background_image
        if let imageUrl = URL(string: gameImageUrl) {
            if let data = try? Data(contentsOf: imageUrl) {
                self.gameImage.image = UIImage(data: data)
            }
        }
    }
}
