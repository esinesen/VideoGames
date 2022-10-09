//
//  HomeVC.swift
//  VideoGames
//
//  Created by Esin Esen on 6.03.2022.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var bottomCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var topCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var navigator: UINavigationItem!
    
    var topGames = [Game]()
    var games = [Game]()
    var filteredGames = [Game]()
    var isFiltering: Bool = false
    
    var scrollWidth = CGFloat()
    var scrollHeight = CGFloat()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://api.rawg.io/api/games?key=4885d5e4c21b4c95ba59b5e979506028"
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        scrollWidth = topCollectionView.frame.size.width
        scrollHeight = topCollectionView.frame.size.height
    }
    
    @IBAction func pageChanged(_ sender: Any) {
        topCollectionView.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonGames = try? decoder.decode(Games.self, from: json) {
            games += jsonGames.results
            for i in 0..<3 {
                topGames.append(jsonGames.results[i])
                games.removeAll(where: {$0 == topGames[i]})
            }
            bottomCollectionView.reloadData()
            topCollectionView.reloadData()
        }
    }
}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == topCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topGameCell", for: indexPath as IndexPath) as! TopGameCell
            let topGame = topGames[indexPath.row]
            cell.configure(model: topGame)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath as IndexPath) as! GameCell
            let game: Game
            if isFiltering {
                game = filteredGames[indexPath.row]
            } else {
                game = games[indexPath.row]
            }
            cell.configure(model: game)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topCollectionView {
            return topGames.count
        } else {
            if isFiltering {
                return filteredGames.count
            }
            return games.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        if collectionView == topCollectionView {
            let selectedItem = collectionView.dequeueReusableCell(withReuseIdentifier: "topGameCell", for: indexPath as IndexPath) as! TopGameCell
            selectedItem.configure(model: topGames[indexPath.row])
            DetailsVC.id = selectedItem.id
        } else {
            let selectedItem = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath as IndexPath) as! GameCell
            selectedItem.configure(model: games[indexPath.row])
            DetailsVC.id = selectedItem.id
        }
    }
}

extension HomeVC : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = (topCollectionView.contentOffset.x)/scrollWidth
        pageControl.currentPage = Int(page)
    }
}

extension HomeVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count >= 3 {
            filteredGames = games.filter({ (game:Game) -> Bool in
                return game.name.lowercased().contains(searchText.lowercased())
            })
            if filteredGames.count == 0 {
                topConstraint.constant = 20
                topCollectionView.isHidden = true
                bottomCollectionView.isHidden = true
                isFiltering = true
                pageControl.isHidden = true
            } else {
                topConstraint.constant = 20
                topCollectionView.isHidden = true
                bottomCollectionView.isHidden = false
                isFiltering = true
                pageControl.isHidden = true
                bottomCollectionView.reloadData()
            }
        } else if searchText.isEmpty {
            topConstraint.constant = 266
            isFiltering = false
            topCollectionView.isHidden = false
            bottomCollectionView.isHidden = false
            pageControl.isHidden = false
            bottomCollectionView.reloadData()
        }

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltering = false
        searchBar.text = ""
        bottomCollectionView.reloadData()
    }
}
