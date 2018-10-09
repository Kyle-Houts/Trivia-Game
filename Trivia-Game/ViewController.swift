//
//  ViewController.swift
//  Trivia-Game
//
//  Created by Kyle Houts on 10/9/18.
//  Copyright © 2018 Kyle Houts. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let newQuestion = TriviaQuestion(question: "What's my name?", answers: ["Timmy", "Brett", "Tobin", "Squee"], correctAnswerIndex: 3)
        print(newQuestion.correctAnswer)
    }

    
    

}

