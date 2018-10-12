//
//  ViewController.swift
//  Trivia-Game
//
//  Created by Kyle Houts on 10/9/18.
//  Copyright © 2018 Kyle Houts. All rights reserved.
//



import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var triviaGameQuestionLabel: UILabel!
    
    @IBOutlet weak var answer1Button: UIButton!
    
    @IBOutlet weak var answer2Button: UIButton!
    
    @IBOutlet weak var answer3Button: UIButton!
    
    @IBOutlet weak var answer4Button: UIButton!
    
    @IBOutlet weak var userScoreLabel: UILabel!
    
    @IBOutlet weak var userScoreNumberLabel: UILabel!
    
    @IBOutlet weak var resetButton: UIBarButtonItem!
    
    @IBOutlet weak var photoPlaceholder: UIImageView!
    
    var currentQuestion: TriviaQuestion!
        
        
    {
        didSet {
            // Property Observer for currentQuestion
            triviaGameQuestionLabel.text = currentQuestion.question
            if let image = currentQuestion.photo {
                photoPlaceholder.image = image
            }
            answer1Button.setTitle(currentQuestion.answers[0], for: .normal)
            answer2Button.setTitle(currentQuestion.answers[1], for: .normal)
            answer3Button.setTitle(currentQuestion.answers[2], for: .normal)
            answer4Button.setTitle(currentQuestion.answers[3], for: .normal)
            
        }
    }
    
    
    var questions: [TriviaQuestion] = []
    
    var questionsPlaceholder: [TriviaQuestion] = []
    
    var score = 0 {
        // Property Observer for score
        didSet {
            userScoreNumberLabel.text = "\(score)"
        }
    }
    
    
    // This will store the index of the current question
    var randomIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        populateQuestions()
        getNewQuestion()
        
    }
    
    
    // This will be used to populate our question array when the app loads
    func populateQuestions() {
        let question1 = TriviaQuestion(question: "What year did The Muppet Show premiere?", answers: ["1971", "1973", "1976", "1979"], correctAnswerIndex: 2, photo: UIImage(named: "Image1.jpeg")!)
        
        let question2 = TriviaQuestion(question: "What Muppets song made it on to the pop music chart?", answers: ["Movin' Right Along", "Mah Na Mah Na", "Man or Muppet", "Rainbow Connection"], correctAnswerIndex: 3, photo: UIImage(named: "Image2.jpeg")!)
        
        let question3 = TriviaQuestion(question: "What are the names of the two hecklers in the balcony?", answers: ["Statler and Waldorf", "Bert and Ernia", "Tim and Tom", "Bunsen and Beaker"], correctAnswerIndex: 0, photo: UIImage(named: "Image3.jpeg")!)
        
        let question4 = TriviaQuestion(question: "What is the name of the Muppet house band?", answers: ["The What", "Huggy Bear and the Snuggles", "Dr. Teeth and the Electric Mayhem", "Swedish Chef"], correctAnswerIndex: 2, photo: UIImage(named: "Image4.jpeg")!)
        
        let question5 = TriviaQuestion(question: "Who hosts The Muppet Show?", answers: ["Rowlf the Dog", "Kermit the Frog", "Miss Piggy", "Kermit the Frog"], correctAnswerIndex: 3, photo: UIImage(named: "Image5.jpeg")!)
        
        let question6 = TriviaQuestion(question: "What is this Muppet's name?", answers: ["Fozzie", "Pepe", "Rizzo", "Walter"], correctAnswerIndex: 1, photo: UIImage(named: "Image6.jpeg")!)
        
        
        
        questions = [question1, question2, question3, question4, question5, question6]
    }
    
    
    
    // This function will be used to get a random question from our array of questions
    func getNewQuestion() {
        if questions.count > 0 {
            // Get a random index from 0 up to 1 less than the number of elements in the questions array
            randomIndex = Int(arc4random_uniform(UInt32(questions.count)))
            // Set currentQuestion equal to the question that is at the random index in the questions array
            currentQuestion = questions[randomIndex]
        } else {
            // If there are no question left, reset the game
            showGameOverAlert()
        }
    }
    
    
    
    func resetGame() {
        // Reset the score
        score = 0
        
        
        
        //Repopulate the question array with the question in the placeholder
        if !questions.isEmpty {
            // If we have questions remaining, append all of the remaining question to the placeholder array
            questionsPlaceholder.append(contentsOf: questions)
        }
        questions = questionsPlaceholder
        questionsPlaceholder.removeAll()
        
        
        // Get a new question
        getNewQuestion()
    }
    
    
    // Show an alert when the user gets the question right
    func showCorrectAnswerAlert() {
        // UIAlertController
        let correctAlert = UIAlertController(title: "Correct", message: "\(currentQuestion.correctAnswer) was the correct answer.", preferredStyle: .actionSheet)
        // UIAlertAction
        let closeAction = UIAlertAction(title: "Close", style: .default) { _ in
            self.questionsPlaceholder.append(self.questions.remove(at: self.randomIndex))
            self.getNewQuestion()
        }
        
        
        // Add the action to the alert controller
        correctAlert.addAction(closeAction)
        
        // Present the alert controller
        self.present(correctAlert, animated: true, completion: nil)
    }
    
    
    // Show an alert when the user gets the question wrong
    func showIncorrectAnswerAlert() {
        // UIAlertController
        let incorrectAlert = UIAlertController(title: "Incorrect", message: "\(currentQuestion.correctAnswer) was the correct answer.", preferredStyle: .actionSheet)
        // UIAlertAction
        let closeAction = UIAlertAction(title: "Close", style: .default) { _ in
            self.questionsPlaceholder.append(self.questions.remove(at: self.randomIndex))
            self.getNewQuestion()
        }
        
        // Add the action to the alert controller
        incorrectAlert.addAction(closeAction)
        
        // Present the alert controller
        self.present(incorrectAlert, animated: true, completion: nil)
        
    }
    
    // Show an alert when the game is over to show the user their final score. The game will be reset when the alert is dismissed.
    func showGameOverAlert() {
        // UIAlertController
        let gameOverAlert = UIAlertController(title: "Results", message: "Game over! Your score was \(score) out of \(questionsPlaceholder.count)", preferredStyle: .actionSheet)
        
        // UIAlertAction
        let resetAction = UIAlertAction(title: "Reset", style: .default) { _ in
            self.resetGame() // The reset function will be called whenever the reset button on the alert is clicked
        }
        
        // Add the action to the alert controller
        gameOverAlert.addAction(resetAction)
        
        // Present the alert controller
        self.present(gameOverAlert, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func answerButtonTapped(_ sender: UIButton)
    {
        if currentQuestion.correctAnswerIndex == sender.tag {
            // They got the question right, so we need to let them know
            showCorrectAnswerAlert()
            score += 1
            
        } else {
            // They got the question wrong, so we need to let them know
            showIncorrectAnswerAlert()
            score -= 1
        }
    }
    
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        resetGame()
    }
    
    
    // Unwind segue to this screen
    @IBAction func unwindToQuizScreen(segue: UIStoryboardSegue) { }
    
    
    
}

