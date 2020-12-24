import Foundation

// MARK: - Categories
class TriviaCategories: Codable {
    let triviaCategories: [TriviaCategory]

    enum CodingKeys: String, CodingKey {
        case triviaCategories = "trivia_categories"
    }
}

// MARK: - TriviaCategory
struct TriviaCategory: Codable {
    let id: Int
    let name: String
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

