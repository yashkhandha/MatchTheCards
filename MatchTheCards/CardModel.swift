//
//  CardModel.swift
//  MatchTheCards
//
//  Created by Yash Khandha on 3/8/19.
//  Copyright © 2019 Yash Khandha. All rights reserved.
//

import Foundation

class CardModel{
    
    
    /// Function will handle all the computations needed to generate random cards and return it in form of an array to the ViewController
    func getCards() -> [Card]{
        
        // Declare an array to store the generated cards
        var cards = [Card]()
        
        // Randomly generate pairs of cards
        for _ in 1...8 {
            
            // Generate a random number between 1 to 13
            let randomNumber = arc4random_uniform(13) + 1
            
            //Log the number
            print("Random number is \(randomNumber)")
            
            // Create the first card object
            let cardOne = Card()
            cardOne.imageName = "card\(randomNumber)"
            
            cards.append(cardOne)
            
            // Create the second card object
            let cardTwo = Card()
            cardTwo.imageName = "card\(randomNumber)"
            
            cards.append(cardTwo)
            
            //OPTIONAL: Make it so we have unique pairs of cards (while loop)
        }
        
        // TODO: Randomize the array
        
        // Return the array
        return cards
    }
}
