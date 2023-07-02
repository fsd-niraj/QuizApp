import Foundation

class Question: Codable {
    let question: String
        let answer: Bool
        
        init(question: String, answer: Bool) {
            self.question = question
            self.answer = answer
        }
        
        private enum CodingKeys: String, CodingKey {
            case question
            case answer
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(question, forKey: .question)
            try container.encode(answer, forKey: .answer)
        }
}
