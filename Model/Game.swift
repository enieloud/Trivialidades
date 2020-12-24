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
    
    func currentCategDescription() -> String {
        if let c = self.categ {
            return c.findById(self.categoryId)
        } else {
            return ""
        }
    }
    
    func gameDescription() -> String {
        return "\"\(self.currentCategDescription())\", \n \"\(difficultyDescription(self.difficulty)) level\", \n \"\(questionTypedescription(self.type))\"\n\n"
    }
    
    func readCategories(completion completionHandler: @escaping (Bool)->Void) {
        readTriviaCategories( completion: { (categ: TriviaCategories?) in
            self.categ = categ
            if self.categ != nil {
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        })
    }

    var difficulty: Difficulty = .easy
    var type: QuestionType = .multiple
    var amount: Int = 10
    var categoryId: Int = 9
    var possibleAnswers: [String] = []
    var questionsAndAnswers: QuestionsAndAnswers!
    var score: Int = 0
    var currentStep: Int = 0
    var categ: TriviaCategories?
}

func questionTypedescription(_ qt: QuestionType) -> String {
    if qt == .boolean {
        return "True or False question"
    } else {
        return "Multiple Choice"
    }
}

func difficultyDescription(_ df: Difficulty) -> String {
    return df.rawValue.capitalizingFirstLetter()
}
