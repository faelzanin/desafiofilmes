//
//  CarouselCollectionViewCell.swift
//  Desafio
//
//  Created by tqi on 17/03/17.
//  Copyright © 2017 Teste. All rights reserved.
//

import UIKit
import SDWebImage

class CarouselCollectionViewCell: UICollectionViewCell,iCarouselDataSource, iCarouselDelegate {

    @IBOutlet weak var iCarousel: iCarousel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var homeViewController : HomeViewController!
    var listFilms : NSMutableArray! = NSMutableArray()
    
    //Constants
    let SEGUE_HOME_FILM_DETAIL : String = "SegueHomeFilmDetail"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
        iCarousel.type = .coverFlow
        iCarousel.bounceDistance = 0.5
        iCarousel.scrollSpeed = 0.5
        iCarousel.bounces = true
        iCarousel.delegate = self
        
    }
    
    override func layoutSubviews() {
        iCarousel.reloadData()
    }
    
    
    // Ações
    @IBAction func searchFilmTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchFilmViewController")
        homeViewController.navigationController?.pushViewController(vc, animated: true)
    }
    
   

    // Carousel Delegate
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return listFilms.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var itemView: UIImageView
        
        // Recuperando objeto filme da lista
        let film : Film = listFilms.object(at: index) as! Film
        
        // Definindo altura e largura da imagem no carousel
        let width = self.iCarousel.frame.width - ((self.iCarousel.frame.width * 30) / 100)
        let height = CGFloat(300)
        let carouselSize = CGSize(width: CGFloat(width), height: CGFloat(height))
        
        // Instanciando UIImageView do poster
        itemView = UIImageView(frame: CGRect(x: 0, y: 0, width: width - 10 , height: height))
        
        
        //Baixando a imagem e inserindo no carousel
        SDWebImageManager.shared().downloadImage(with: NSURL(string: film.posterUrl!) as URL!, options: .continueInBackground, progress: {
            (receivedSize :Int, ExpectedSize :Int) in
            
            itemView.setIndicatorStyle(UIActivityIndicatorViewStyle.gray)
            itemView.setShowActivityIndicator(true)
            itemView.image = carousel.fit(UIImage(named: "no_image")!, inBox: carouselSize, withBackground: UIColor.clear)
            
        }, completed: {
            (image : UIImage?, error : Error?, cacheType : SDImageCacheType, finished : Bool, url : URL?) in
            if(image != nil) {
                itemView.image = carousel.fit(image!, inBox: carouselSize, withBackground: UIColor.clear)
            } else {
                itemView.image = carousel.fit(UIImage(named: "no_image")!, inBox: carouselSize, withBackground: UIColor.clear)
            }
        })
        
        
        // Algumas configuraçoes no item do Carousel
        itemView.contentMode = .center
        itemView.layer.cornerRadius = 10
        itemView.clipsToBounds = true
        
        return itemView

    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        homeViewController.performSegue(withIdentifier: SEGUE_HOME_FILM_DETAIL, sender: index)
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        if listFilms.count > 0 {
            let film : Film = listFilms.object(at: self.iCarousel.currentItemIndex) as! Film
            self.titleLabel.text = film.title
        }
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.1
        }
        return value
    }
    
    
}
