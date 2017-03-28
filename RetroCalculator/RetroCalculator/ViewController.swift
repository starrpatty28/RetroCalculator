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
    
    enum Operation: String {   //All the operator cases with the calculator
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        
        
    }
    var currentOperation = Operation.Empty   //when you open your calculator your operation is empty
    var runningNumber = ""  //iniialize as a empty string
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")  //creating a path to the Bundle where the file lives (its returing a string and we need to make it a url)
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
           try btnSound = AVAudioPlayer(contentsOf: soundURL)
        } catch let err as NSError {
            print(err.debugDescription)
            
        }
        
        outputLbl.text = "0"
        
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"  //everytime you hit a number it will append to the running number=(result)
        outputLbl.text = runningNumber    //how you get the display of the runningNumber
        
    }
    
    //create IBActions for all the operators
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
 
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func processOperation(operation: Operation) {     //this fnction process the operations
        playSound()
        if currentOperation != Operation.Empty {
            
            //A user selected an operator, but then selected another operator without first enetering a number
            if runningNumber != "" {   //if running number value is not empty
               rightValStr = runningNumber
               runningNumber = ""
                
                if currentOperation == Operation.Multiply {                   //when operators are pressed, we will have an action
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result   //after calculation is result
            }
            
            currentOperation = operation
        } else {
            //This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
}



