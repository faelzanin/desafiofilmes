//
//  FilmDetailViewController.swift
//  Desafio
//
//  Created by tqi on 18/03/17.
//  Copyright © 2017 Teste. All rights reserved.
//

import UIKit

class FilmDetailViewController: UIViewController, FilmControllerDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var releasedLabel: UILabel!
    
    @IBOutlet weak var runtimeLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var directorLabel: UILabel!
    
    @IBOutlet weak var writerLabel: UILabel!
    
    @IBOutlet weak var actorsLabel: UILabel!
    
    @IBOutlet weak var plotLabel: UILabel!
    
    @IBOutlet weak var awardsLabel: UILabel!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var saveOrRemoveFilmButton: DesafioButton!
    
    var film : Film?
    var cachedFilm : Film?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FilmController.sharedInstance.delegate = self
        fillLabels()
    }

    func fillLabels(){
        self.titleLabel.text = film?.title
        self.yearLabel.text = film?.year?.description
        self.posterImageView.sd_setImage(with: URL(string: (film?.posterUrl!)!), placeholderImage: UIImage(named: "no_image.jpeg"))
        
        
        // Caso nao encontre o filme no cache, busco os dados no WebService
        cachedFilm = CacheUtil.sharedInstance.getFilmByTitle(title: (film?.title)!)
        
        if(cachedFilm != nil) {
            film? = cachedFilm!
            
            saveOrRemoveFilmButton.backgroundColor = UIColor.white
            saveOrRemoveFilmButton.setTitleColor(UIColor.blue, for: .normal)
            saveOrRemoveFilmButton.borderColor = UIColor.blue
            saveOrRemoveFilmButton.borderWidth = 0.5
            saveOrRemoveFilmButton.setTitle("REMOVER FILME", for: .normal)
            
        }
        
        if(film?.released != nil || film?.runtime != nil || film?.runtime != nil) {
            self.releasedLabel.text = film?.released
            self.runtimeLabel.text = film?.runtime
            self.genreLabel.text = film?.genre
            self.directorLabel.text = film?.director
            self.writerLabel.text = film?.writer
            self.actorsLabel.text = film?.actors
            self.plotLabel.text = film?.plot
            self.awardsLabel.text = film?.awards
        } else {
            loadFilm()
        }
    }
    
    func loadFilm(){
        FilmController.sharedInstance.getFilmById(imdbID: (film?.imdbID)!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func saveOrRemoveFilmTapped(_ sender: Any) {
        //Salvar ou remover do cache
        if(cachedFilm != nil) {
            CacheUtil.sharedInstance.removeFilm(film: film!)
            AlertMessage.shared.show(title: "AlertInfoTitle".localized, message: "AlertInfoFilmRemoved".localized, viewController: self, dismissViewController: true)
        } else {
            CacheUtil.sharedInstance.saveFilm(film: film!)
            AlertMessage.shared.show(title: "AlertInfoTitle".localized, message: "AlertInfoFilmAdded".localized, viewController: self, dismissViewController: true)
        }
        
    }
  
    
    // Delegate FilmController
    
    func getFilmByIdDidFinishWithSuccess(response: Film) {
        film = response
        fillLabels()
    }
    
    func getFilmByIdDidFinishWithError(error: NSError) {
         AlertMessage.shared.show(title: "AlertErrorTitle".localized, message: error.domain, viewController: self, dismissViewController: false)
    }

}
