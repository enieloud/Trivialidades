import Foundation

// MARK: - Categories
class TriviaCategories: Codable {
    let triviaCategories: [TriviaCategory]
    
    func findById(_ id: Int)->String {
        for tc in triviaCategories {
            if tc.id == id {
                return tc.name
            }
        }
        return ""
    }

    enum CodingKeys: String, CodingKey {
        case triviaCategories = "trivia_categories"
    }
}

// MARK: - TriviaCategory
struct TriviaCategory: Codable {
    let id: Int
    let name: String
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
