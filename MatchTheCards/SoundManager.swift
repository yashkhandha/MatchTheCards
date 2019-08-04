//
//  SoundManager.swift
//  MatchTheCards
//
//  Created by Yash Khandha on 4/8/19.
//  Copyright © 2019 Yash Khandha. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager{
    
    static var audio: AVAudioPlayer?
    
    enum SoundEffects{
        case shuffle
        case flip
        case match
        case nomatch
    }
    
    static func playSound(_ effect: SoundEffects){
        
        var soundFileName = ""
        
        // Determine which sound we want to play
        // And set the appropriate filename
        switch(effect){
            
        case .flip:
            soundFileName = "cardflip"
            
        case .shuffle:
            soundFileName = "shuffle"
            
        case .match:
            soundFileName = "dingcorrect"
            
        case .nomatch:
            soundFileName = "dingwrong"
        }
        
        // Get the path to the sound file inside the Bundle
        let bundlePath = Bundle.main.path(forResource: soundFileName, ofType: "wav")
        
        guard bundlePath != nil else{
            print("Couldn't find sound file \(soundFileName) in the bundle")
            return
        }
        
        // Create a URL object with this string path
        let soundURL = URL(fileURLWithPath: bundlePath!)
        
        do{
            // Create audio player object
            audio = try AVAudioPlayer(contentsOf: soundURL)
            
            // Play the sound
            audio?.play()
        }
        catch{
            //Couldn't create audio player object for the file name
            print("Could not play the audio file for file \(soundFileName)")
        }
        
    }
}
