//
//  FavoritesVC.swift
//  VideoGames
//
//  Created by Esin Esen on 8.03.2022.
//

import UIKit

class FavoritesVC: UIViewController {
    
    @IBOutlet weak var favoritesCollectionView: UICollectionView!
    @IBOutlet weak var navigator: UINavigationItem!
    
    static var favGames = [Game]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.favoritesCollectionView.reloadData()
        FavoritesVC.favGames.isEmpty ? (self.favoritesCollectionView.backgroundView?.isHidden = false) : (self.favoritesCollectionView.backgroundView?.isHidden = true)
    }
}

extension FavoritesVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoritesCell", for: indexPath as IndexPath) as! FavoritesCell
        cell.configure(model: FavoritesVC.favGames[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FavoritesVC.favGames.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        let selectedItem = collectionView.dequeueReusableCell(withReuseIdentifier: "favoritesCell", for: indexPath as IndexPath) as! FavoritesCell
        selectedItem.configure(model: FavoritesVC.favGames[indexPath.row])
        
        DetailsVC.id = selectedItem.id
    }
}
