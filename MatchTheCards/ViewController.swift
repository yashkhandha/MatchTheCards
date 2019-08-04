//
//  ViewController.swift
//  MatchTheCards
//
//  Created by Yash Khandha on 3/8/19.
//  Copyright © 2019 Yash Khandha. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstFlippedCardIndex: IndexPath?
    
    var timer: Timer?
    var milliseconds: Float = 10 * 1000 // 10 seconds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call the getCards method of the CardModel
        cardArray = model.getCards()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(elapsedTime), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    // MARK: - Timer methods
    @objc func elapsedTime(){
        
        milliseconds -= 1
        
        // Convert to seconds
        let seconds = String(format: "%.2f", milliseconds/1000)
        
        // Set the label
        timerLabel.text = "Time Remaining : \(seconds)"
        
        // When the timer has reached 0..
        if (milliseconds <= 0){
            
            // Stop the timer
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
            
            // Check if there are any cards unmatched
            checkGameEnded()
        }
    }
    
    // MARK: - UICollectionView Protocol Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as? CardCollectionViewCell
        
        // Cells getting reused when you scroll up the screen
        cell?.setCard(cardArray[indexPath.row])
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Check if there is any time left, then disable user interaction
        if (milliseconds <= 0){
            return
        }
        
        //Get the cell user selected
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false && card.isMatched == false{
            
            // Flip the card
            cell?.flip()
            
            // Set the status
            card.isFlipped = true
            
            if firstFlippedCardIndex == nil{
                
                // This is the first card being flipped
                //set the firstFlippedCardIndex
                firstFlippedCardIndex = indexPath
            }else{
                // This is the second card being flipped
                
                // TODO: - Matching logic
                let secondFlippedCardIndex = indexPath
                checkForMatches(secondFlippedCardIndex)
            }
        }
    }
    
    // MARK: - Game logic method
    func checkForMatches(_ secondFlippedCardIndex: IndexPath){
        
        // Get the cells for the cards selected
        let firstFlippedCardCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        
        let secondFlippedCardCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        // Get the cards for the cards selected
        let firstCard = cardArray[firstFlippedCardIndex!.row]
        let secondCard = cardArray[secondFlippedCardIndex.row]
        
        if firstCard.imageName == secondCard.imageName{
            // It is a match
            
            //Set the statuses of the matched cards
            firstCard.isMatched = true
            secondCard.isMatched = true
            
            //Make the matched cards invisible from the screen
            firstFlippedCardCell?.remove()
            secondFlippedCardCell?.remove()
            
            // Check if there are any cards left unmatched
            checkGameEnded()
        }
        else{
            //It is not a match
            
            //Set the statuses of the cards
            firstCard.isFlipped = false
            secondCard.isFlipped = false
            
            //Flip back the cards
            firstFlippedCardCell?.flipBack()
            secondFlippedCardCell?.flipBack()
        }
        
        // Tell the collectionview to reload the cell of the first card if it is nil
        if firstFlippedCardCell == nil{
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
        }
        
        // Reset the property that tracks the first card flipped
        firstFlippedCardIndex = nil
    }
    
    func checkGameEnded(){
        
        // Check if there are any cards unmatched
        var isWon = true
        
        for card in cardArray{
            if card.isMatched == false{
                isWon = false
                break
            }
        }
        
        // Alert variables
        var title = ""
        var message = ""
        
        // If not, then the user has won, stop the timer
        if isWon == true{
            
            if (milliseconds > 0){
                timer?.invalidate()
            }
            title = "Congratulations!"
            message = "You've won the game"
        }
        else{
            // If there are any cards left unmatched, check if there is any time left
            if (milliseconds > 0){
                return
            }
            
            title = "Game Over"
            message = "You've lost the game"
        }
        
        // Show won/lost message
        showAlert(title, message)
    }
    
    func showAlert(_ title: String, _ message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
}

