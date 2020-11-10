//
//  QuizBrain.swift
//  TheQuizzler - iOS
//  The quiz brain struct takes care of all the logic of the app, which follows the M of MVC.
//  Created by Aviad Sabag on 09/11/2020.
//

import Foundation
import UIKit

// MARK: - Struct Protocol
protocol QuizBrainDelegate {
    func didUpdateQuestionsArray(questionsArr: [Question])
}

// MARK: -
struct QuizBrain {
   
    let urlString = "https://5fa952f1c9b4e90016e6a5be.mockapi.io/data"
    
    
    var delegate: QuizBrainDelegate?
    
    
    
    
    // MARK:  API Request.
     func performRequest() {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, respone, error) in
                if error != nil {
                    print("There's an error \(error)")
                }
                if let safeData = data {
                    self.parseJSON(with: safeData)
                    
                }
            }
            task.resume()
        }
    }
    
    
    /// parsing JSON method to parse the JSON
    /// - Parameter data: The data returned by the server
     func parseJSON(with data: Data)  {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Root.self, from: data)
            
            //an array of question objects:
            let quiz = [
                Question(q: decodedData.data.questions[0].question, a: decodedData.data.questions[0].options[1].value,o: decodedData.data.questions[0].options),
                Question(q: decodedData.data.questions[1].question, a: decodedData.data.questions[1].options[0].value, o: decodedData.data.questions[1].options),
                Question(q: decodedData.data.questions[2].question, a: decodedData.data.questions[2].options[1].value, o: decodedData.data.questions[2].options)
                ]
            let thankUMessage = decodedData.data.thank_you_message
            
            
            //passing the quiz arr to our Quiz's VC:
            self.delegate?.didUpdateQuestionsArray(questionsArr: quiz)
            //passing the thank u message to the thanks's vc.
            print(thankUMessage)

        } catch {
            print("There was a problem with parsing JSON \(error)")
        }
    }
    
    
    

    // MARK: - Struct Methods:
    
    /// This func gets the next question everytime we answer the question
    /// - Parameters:
    ///   - questionNum: a counter of the current question number.
    ///   - numOfQuestions: a counter of total amount of questions.
    /// - Returns: returns the new value of questionNum which is the counter of our question number.
     func nextQuestion(questionNum: Int, numOfQuestions: Int) -> Int {
       if questionNum + 1 < numOfQuestions {
        return questionNum + 1
       } else {
        return 0
       }
   }
    
    
    /// Func sets the score of the player
    /// - Parameter scoreNum: the total score number.
    /// - Returns: returns the score with 5 points once the user answers right
    func getScore(scoreNum: Int) ->Int {
        return scoreNum+5
    }
 
    
    
    /// Func checks if the answer of the user is right or not.
    /// - Parameters:
    ///   - userAnswer: this is the user's answer
    ///   - correctAnswer: this is the right answer of each question.
    /// - Returns: returns a boolean value once the user answers the question, true - if the user answered right, false if doesnt.
    func checkAnswer(userAnswer: String, correctAnswer: String) -> Bool {
        if userAnswer == correctAnswer {
            return true
        } else {
            return false
        }
    }
    
}
