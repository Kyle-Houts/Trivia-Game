//
//  TriviaQuestion.swift
//  Trivia-Game
//
//  Created by Kyle Houts on 10/9/18.
//  Copyright © 2018 Kyle Houts. All rights reserved.
//

import Foundation


class TriviaQuestion {
    
    // String storing the text of the question
    let question: String
    
    // String array storing the potential answers to the question
    let answers: [String]
    
    // Store the index of the correct answer in the answers array
    let correctAnswerIndex: Int
    
    // Computed property that returns the correct answer for the Trivia Question
    var correctAnswer: String {
        return answers[correctAnswerIndex]
    }
    
    // Initializer for the TriviaQuestion class
        init(question: String, answers: [String], correctAnswerIndex: Int){
        self.question = question
        self.answers = answers
        self.correctAnswerIndex = correctAnswerIndex
        
    }
    
    
}
