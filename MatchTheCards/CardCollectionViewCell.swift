//
//  CardCollectionViewCell.swift
//  MatchTheCards
//
//  Created by Yash Khandha on 3/8/19.
//  Copyright © 2019 Yash Khandha. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card: Card?
    
    func setCard(_ card:Card){
        
        //Keep track of card passed in
        self.card = card
        frontImageView.image = UIImage(named: card.imageName)
        
        if card.isMatched == true{
            
            // If the cards have been matched, then make the images invisible
            frontImageView.alpha = 0
            backImageView.alpha = 0
            return
        }
        else{
            // IF the card hasn't been matched, then make the image views visible
            frontImageView.alpha = 1
            backImageView.alpha = 1
        }
        
        //Determine if the card is in a flipped up state or flipped down state
        if card.isFlipped == true{
            // Make sure the frontimageview is on top
            UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }
        else{
            // Make sure the backimageview is on top
            UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
        
    }
    
    func flip(){
        
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
    }
    
    func flipBack(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
    }
    
    func remove(){
        // Removes both imageviews from being visible
            self.backImageView.alpha = 0
        
        // Add animation
        UIView.animate(withDuration: 0.3, delay: 1, options: .transitionCurlUp, animations: {
            self.frontImageView.alpha = 0
        }, completion: nil)
    }
}
