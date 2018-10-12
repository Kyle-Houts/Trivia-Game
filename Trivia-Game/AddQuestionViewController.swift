//
//  AddQuestionViewController.swift
//  Trivia-Game
//
//  Created by Kyle Houts on 10/11/18.
//  Copyright © 2018 Kyle Houts. All rights reserved.
//

import UIKit

class AddQuestionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var correctAnswerSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var questionTextField: UITextField!
    
    @IBOutlet weak var answer1TextField: UITextField!
    
    
    @IBOutlet weak var answer2TextField: UITextField!
    
    @IBOutlet weak var answer3TextField: UITextField!
    

    @IBOutlet weak var answer4TextField: UITextField!
    
    var newQuestion: TriviaQuestion!
    
    
    @IBOutlet weak var submitButton: UIButton!
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new vidw controller using segue.destionation.
        // Pass the selected object ot the new view controller
        if let destination = segue.destination as? ViewController {
            //Append the new question to the questions array
            destination.questions.append(newQuestion)
            
        }
    
    }
    

    
    
    
    func showErrorAlert() {
        let errorAlert = UIAlertController(title: "Error", message: "Please enter text in all fields, or hit the back button to go back to the quiz.", preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Close", style: .default, handler: nil)
        errorAlert.addAction(dismissAction)
        self.present(errorAlert, animated: true, completion: nil)
        
    }
    

    @IBAction func submitButtonTapped(_ sender: Any) {
        //Make sure each of the text field has text
        guard let question = questionTextField.text, !question.isEmpty,
        let answer1 = answer1TextField.text, !answer1.isEmpty,
        let answer2 = answer2TextField.text, !answer2.isEmpty,
        let answer3 = answer3TextField.text, !answer3.isEmpty,
        let answer4 = answer4TextField.text, !answer4.isEmpty else {
                showErrorAlert()
                return
        }
        
        
        
        let newQuestion = TriviaQuestion(question: question, answers: [answer1, answer2, answer3, answer4],
            correctAnswerIndex: correctAnswerSegmentedControl.selectedSegmentIndex)
        
        
        self.performSegue(withIdentifier: "unwindToQuizScreen", sender: self)
    }
    
    
    
    
}
