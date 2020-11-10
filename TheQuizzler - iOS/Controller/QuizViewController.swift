//
//  ViewController.swift
//  TheQuizzler - iOS
//
//  Created by Aviad Sabag on 09/11/2020.
//

import UIKit
import Foundation



class QuizViewController: UIViewController, QuizBrainDelegate {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerOption1: UIButton!
    @IBOutlet weak var answerOption2: UIButton!
    @IBOutlet weak var answerOption3: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    

    var scoreCounter = 0   // user's counter score.
    var numOfQuestion = 0 // counter of total questions.
    var numOfOptions = 0 // counter of options
    var quizBrain = QuizBrain() // an instance of struct QuizBrain for following MVC.

    
    var quizArr = [Question]() // array of Q and A
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        quizBrain.performRequest() // Calling the URLRequest.

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizBrain.delegate = self
}


    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        print(quizArr.count)
        guard let userAnswer = sender.currentTitle else { return }
        
        //1)Checking if the user is right:
        let userGotItRight = quizBrain.checkAnswer(userAnswer: userAnswer, correctAnswer: quizArr[numOfQuestion].answer)

        if userGotItRight {
            sender.pulsate()
            scoreCounter = quizBrain.getScore(scoreNum: scoreCounter)
            
            if numOfQuestion + 1 < quizArr.count{
                numOfQuestion = quizBrain.nextQuestion(questionNum: numOfQuestion, numOfQuestions: quizArr.count)
            } else {
                switchScreen() // Once we finis the Quiz, we show the Thanks VC.
            }
        } else {
            sender.shake() // shakes the UIButton once the answer is wrong.
            if numOfQuestion + 1 < quizArr.count{
                numOfQuestion = quizBrain.nextQuestion(questionNum: numOfQuestion, numOfQuestions: quizArr.count)
            } else {
                switchScreen() // Once we finis the Quiz, we show the Thanks VC.
            }
        }
        
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)

    }
    
    
    @objc func updateUI() {
        self.questionLabel.text = self.quizArr[numOfQuestion].text
        
        self.answerOption1.setTitle(self.quizArr[numOfQuestion].options[numOfOptions].value, for: .normal) // Updates option1
        self.answerOption2.setTitle(self.quizArr[numOfQuestion].options[numOfOptions+1].value, for: .normal) // Updates option2
        self.answerOption3.setTitle(self.quizArr[numOfQuestion].options[numOfOptions+2].value, for: .normal) // Updates option3
        
        scoreLabel.text = "Score: \(scoreCounter)/15" // updates the score.
    }
    
    
    
    /// func to update the arr with the JSON decoded questions and answers.
    /// - Parameter questionsArr: an array of question objects.
    func didUpdateQuestionsArray(questionsArr: [Question]) {
        DispatchQueue.main.async {
            self.quizArr = questionsArr
            self.updateUI()
        }
    }
    
    
    
    
    func showAlert() {
        let alert = UIAlertController(title: "Quiz is Over!", message: "The quiz is over, thanks for taking apart!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .destructive, handler: nil))
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    func switchScreen() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "sbThanks") as? UIViewController {
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
}
