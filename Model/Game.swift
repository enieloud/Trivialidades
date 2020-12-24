//
//  Game.swift
//  Trivialidades
//
//  Created by Enrique Nieloud on 23/12/2020.
//

import Foundation

//enum GameErrors: Error {
//    case gameFinished
//}

// MARK: - Game
class Game {
    func newGame(completion: @escaping (_ succeed: Bool) -> Void)
    {
        self.score = 0
        self.currentStep = 0
        readGame(difficulty: self.difficulty,
                 type: self.type,
                 amount: self.amount,
                 categoryId: self.categoryId) {
                 (q: QuestionsAndAnswers?) in
                    if let qa = q {
                        self.questionsAndAnswers = qa
                        self.setupPossibleAnswers()
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
    }
    
    func setupPossibleAnswers() {
        if self.questionsAndAnswers.results.count > 0 {
            if self.questionsAndAnswers.results[self.currentStep].type == .boolean {
                self.possibleAnswers = ["true","false"]
                self.possibleAnswers.shuffle()
            } else {
                self.possibleAnswers = self.questionsAndAnswers.results[self.currentStep].incorrectAnswers
                self.possibleAnswers.append(self.questionsAndAnswers.results[self.currentStep].correctAnswer)
                self.possibleAnswers.shuffle()
            }
        } else {
            self.possibleAnswers = []
        }
    }
    
    func isFinihed() -> Bool {
        currentStep == self.questionsAndAnswers.results.count-1
    }
    
    func next() {
        assert(!isFinihed());
        currentStep += 1
        setupPossibleAnswers()
    }
    
    func evalAnswer(index: Int) -> Bool {
        if let q = questionsAndAnswers {
            let answer = self.possibleAnswers[index]
            let correctAnswer = q.results[currentStep].correctAnswer.uppercased() == answer.uppercased()
            if correctAnswer {
                score+=1
            }
            return correctAnswer
        } else {
            return false
        }
    }

    var currentStepStr: String {
        get {
            if let q = questionsAndAnswers {
                let totalSteps = q.results.count
                return "\(currentStep+1) of \(totalSteps)"
            } else {
                return "0 of 0"
            }
        }
    }
    
    var scoreStr: String {
        get {
            return "\(score) pts"
        }
    }

    var questionStr: String {
        get {
            if let q = questionsAndAnswers {
                if q.results.count > currentStep {
                    return String(htmlEncodedString: q.results[currentStep].question)!
                } else {
                    return ""
                }
            } else {
                return ""
            }
        }
    }

    var categoryStr: String {
        get {
            if let q = questionsAndAnswers {
                if q.results.count > currentStep {
                    return q.results[currentStep].category
                } else {
                    return ""
                }
                
            } else {
                return ""
            }
        }
    }
    var difficulty: Difficulty = .easy
    var type: QuestionType = .multiple
    var amount: Int = 10
    var categoryId: Int = 9
    var possibleAnswers: [String] = []
    var questionsAndAnswers: QuestionsAndAnswers!
    var score: Int = 0
    var currentStep: Int = 0
}

// MARK: - QuestionsAndAnswers
class QuestionsAndAnswers: Codable {
    let responseCode: Int
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results
    }
}

// MARK: - Result
struct Result: Codable {
    let category: String
    let type: QuestionType
    let difficulty: Difficulty
    let question, correctAnswer: String
    let incorrectAnswers: [String]

    enum CodingKeys: String, CodingKey {
        case category, type, difficulty, question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}

enum Difficulty: String, CaseIterable, Codable {
    case easy = "easy"
    case hard = "hard"
    case medium = "medium"
}

enum QuestionType: String, CaseIterable, Codable {
    case boolean = "boolean"
    case multiple = "multiple"
}

func readGame(
    difficulty: Difficulty,
    type: QuestionType,
    amount: Int,
    categoryId: Int,
    completion: @escaping (QuestionsAndAnswers?) -> Void)
{
    let urlStr = "https://opentdb.com/api.php?amount=\(amount)&category=\(categoryId)&difficulty=\(difficulty.rawValue)&type=\(type.rawValue)"
    let url = URL(string: urlStr)!
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let jsonData = data else {
            completion(nil)
            return
        }
        do {
            let game: QuestionsAndAnswers = try JSONDecoder().decode(QuestionsAndAnswers.self, from: jsonData)
            completion(game)
        } catch {
            completion(nil)
        }
    }
    task.resume()
}
