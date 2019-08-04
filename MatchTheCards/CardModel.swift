//
//  CardModel.swift
//  MatchTheCards
//
//  Created by Yash Khandha on 3/8/19.
//  Copyright © 2019 Yash Khandha. All rights reserved.
//

import Foundation

class CardModel{
    
    var generatedArray = [Int]()
    
    /// Function will handle all the computations needed to generate random cards and return it in form of an array to the ViewController
    func getCards() -> [Card]{
        
        // Declare an array to store the generated cards
        var cards = [Card]()
        
        // Randomly generate pairs of cards
        while generatedArray.count < 8 {
            
            // Generate a random number between 1 to 13
            let randomNumber = arc4random_uniform(13) + 1
            
            // check if the random number already exists in the geenratedArray to keep the pairs unique
            if generatedArray.contains(Int(randomNumber)) == false{
                
                //Log the number
                print("Random number is \(randomNumber)")
                
                //Add the Random number in the generated array
                generatedArray.append(Int(randomNumber))
                
                // Create the first card object
                let cardOne = Card()
                cardOne.imageName = "card\(randomNumber)"
                
                cards.append(cardOne)
                
                // Create the second card object
                let cardTwo = Card()
                cardTwo.imageName = "card\(randomNumber)"
                
                cards.append(cardTwo)
            }
        }
        
        // Randomize the array
        cards.shuffle()
        
        // Return the array
        return cards
    }
}
