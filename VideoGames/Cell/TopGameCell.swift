//
//  TopGameCell.swift
//  VideoGames
//
//  Created by Esin Esen on 9.10.2022.
//

import UIKit

class TopGameCell: UICollectionViewCell {
    @IBOutlet weak var topImageView: UIImageView!
    
    var id = ""
    var currentPage = 0
    override func awakeFromNib() {
      super.awakeFromNib()

    }
    
    func configure(model: Game) {
        self.id = String(model.id)
        
        let gameImageUrl = model.background_image
        if let imageUrl = URL(string: gameImageUrl) {
            if let data = try? Data(contentsOf: imageUrl) {
                self.topImageView.image = UIImage(data: data)
            }
        }
    }
}
