//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Noi-Ariella Baht Israel on 3/27/17.
//  Copyright © 2017 Plant A Seed of Code. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var outputLbl: UILabel!
    
    
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "_"
        case Addition = "+"
        
        
    }
    
    var runningNumber = ""  //iniialize as a empty string
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")  //creating a path to the Bundle where the file lives (its returing a string and we need to make it a url)
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
           try btnSound = AVAudioPlayer(contentsOf: soundURL)
        } catch let err as NSError {
            print(err.debugDescription)
            
        }
        
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"  //everytime you hit a number it will append to the running number=(result)
        outputLbl.text = runningNumber    //how you get the display of the runningNumber
        
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
}

