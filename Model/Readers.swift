//
//  Readers.swift
//  Trivialidades
//
//  Created by Enrique Nieloud on 24/12/2020.
//

import Foundation

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

func readTriviaCategories(completion: @escaping (TriviaCategories?) -> Void)
{
    let url = URL(string: "https://opentdb.com/api_category.php")!
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let jsonData = data else {
            completion(nil)
            return
        }
        do {
            let triviaCategories = try JSONDecoder().decode(TriviaCategories.self, from: jsonData)
            completion(triviaCategories)
        } catch {
            completion(nil)
        }
    }
    task.resume()
}
