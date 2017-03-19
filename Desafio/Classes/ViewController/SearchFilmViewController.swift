//
//  SearchFilmViewController.swift
//  Desafio
//
//  Created by rafaelzanin on 18/03/17.
//  Copyright © 2017 Teste. All rights reserved.
//

import UIKit
import SDWebImage

class SearchFilmViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, FilmControllerDelegate {

    @IBOutlet weak var searchFilmCollectionView: UICollectionView!
    
    var listFilms : NSMutableArray! = NSMutableArray()

    // Constantes
    let XIB_FILM_SEARCHED : String = "FilmSearchedCollectionViewCell_XIB"
    let XIB_EMPTY_STATE : String = "EmptyStateCollectionViewCell_XIB"
    let SEGUE_FILM_DETAIL : String = "SearchedFilmDetailSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        FilmController.sharedInstance.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func registerNibs(){
        self.searchFilmCollectionView.register(UINib.init(nibName: "FilmSearchedCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: XIB_FILM_SEARCHED)
        self.searchFilmCollectionView.register(UINib.init(nibName: "EmptyStateCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: XIB_EMPTY_STATE)
    }
    
    
    func loadFilms(search: String){
        FilmController.sharedInstance.getFilmsBySearch(search: search)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
       _ = self.navigationController?.popViewController(animated: true)
    }
    
    // Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let filmDetailVC =  segue.destination as! FilmDetailViewController
        
        if let indexPath = self.searchFilmCollectionView.indexPathsForSelectedItems?[0]{
            filmDetailVC.film = self.listFilms.object(at: indexPath.row) as? Film
        }
        
    }
    
    // Delegate CollectionView
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Se nao tem filmes no array, é mostrado o xib de EmptyState
        if self.listFilms.count == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XIB_EMPTY_STATE, for: indexPath) as! EmptyStateCollectionViewCell
            cell.messageEmptyLabel.text = "Não foi encontrado nenhum filme. :("
            return cell
        }
        
        // Recuperando o filme no array
        let film : Film? = self.listFilms.object(at: indexPath.row) as? Film
        
        // Instanciando a célula
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XIB_FILM_SEARCHED, for: indexPath) as! FilmSearchedCollectionViewCell
        cell.titleLabel.text = film?.title
        cell.yearLabel.text = film?.year?.description
        cell.posterImageView.sd_setImage(with: URL(string: (film?.posterUrl!)!), placeholderImage: UIImage(named: "no_image.jpeg"))
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(self.listFilms.count == 0) {
            return 1
        }
        
        return self.listFilms.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.endEditing(true)
        if(self.listFilms.count > 0) {
            self.performSegue(withIdentifier: SEGUE_FILM_DETAIL, sender: indexPath.row)
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = self.view.frame.size.width
        let height: CGFloat = collectionView.frame.size.height
        
        switch indexPath.row {
        case 0:
            
            if self.listFilms.count == 0 {
                return CGSize(width: width, height: height)
            } else {
               return CGSize(width: width, height: 100)
            }
            
        default:
            return CGSize(width: width, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    // Delegate Search Bar
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Clicou no botão "Search" do teclado, busca os filmes no WebService
        loadFilms(search: searchBar.text!)
    }
    
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        // Caso nao tenha nada preenchido no SearchBar, mostra-se tela em branco.
        if(searchBar.text == "") {
            listFilms = NSMutableArray()
            searchFilmCollectionView.reloadData()
        }
        
        return true
    }
    
    // Delegate Film Controller
    
    func getFilmsBySearchDidFinishWithSuccess(response: NSMutableArray) {
        listFilms = response
        searchFilmCollectionView.reloadData()
    }
    
    func getFilmsBySearchDidFinishWithError(error: NSError) {
        AlertMessage.shared.show(title: "AlertErrorTitle".localized, message: error.domain, viewController: self, dismissViewController: false)
    }
    
}
