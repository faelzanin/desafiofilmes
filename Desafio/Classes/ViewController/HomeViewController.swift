//
//  HomeViewController.swift
//  Desafio
//
//  Created by rafaelzanin on 17/03/17.
//  Copyright © 2017 Teste. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    var listFilms : NSMutableArray! = NSMutableArray()
    
    // Constantes
    let XIB_CAROUSEL : String = "CarouselCollectionViewCell_XIB"
    let XIB_EMPTY_STATE : String = "EmptyStateCollectionViewCell_XIB"
    let XIB_BUTTON_SEARCH : String = "HomeSearchFilmsCollectionViewCell_XIB"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        registerNibs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFilms()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func registerNibs(){
        self.homeCollectionView.register(UINib.init(nibName: "CarouselCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: XIB_CAROUSEL)
        self.homeCollectionView.register(UINib.init(nibName: "EmptyStateCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: XIB_EMPTY_STATE)
        self.homeCollectionView.register(UINib.init(nibName: "HomeSearchFilmsCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: XIB_BUTTON_SEARCH)
    }
    
    // Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let filmDetailVC =  segue.destination as! FilmDetailViewController
        filmDetailVC.film = self.listFilms.object(at: sender as! Int) as? Film
    }
    
    // Delegate CollectionView
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        
        let position = indexPath.row
        
        switch position {
        case 0:
            if self.listFilms.count == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XIB_EMPTY_STATE, for: indexPath) as! EmptyStateCollectionViewCell
                cell.homeViewController = self
                return cell
            } else {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XIB_CAROUSEL, for: indexPath) as! CarouselCollectionViewCell
                cell.homeViewController = self
                cell.listFilms = self.listFilms
                cell.layoutSubviews()
                return cell
            }
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XIB_BUTTON_SEARCH, for: indexPath) as! HomeSearchFilmsCollectionViewCell
            cell.homeViewController = self
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XIB_EMPTY_STATE, for: indexPath) as! EmptyStateCollectionViewCell
            cell.homeViewController = self
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.size.width
        let height: CGFloat = collectionView.frame.size.height
        
        switch indexPath.row {
        case 0:
            return CGSize(width: width, height: height - 100)
        case 1:
            return CGSize(width: width, height: 100)
        default:
            return CGSize(width: width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
    func loadFilms(){
        
        listFilms = CacheUtil.sharedInstance.getFilms()
        homeCollectionView.reloadData()
    }


}

