import UIKit

class AddEditViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        questionInput.text = incomingData
    }
    
    var incomingData: String = ""
    
    var questions = [Question]()
    
    @IBOutlet weak var questionInput: UITextField!
    var answer:Bool = false;
    
    @IBAction func trueClicked(_ sender: Any) {
        answer = true
    }
    @IBAction func falseClicked(_ sender: Any) {
        answer = false
    }
    
    @IBAction func saveToQuiz(_ sender: Any) {
        guard let questionText = questionInput.text,
              let answerText = answer as Bool? else {
            return
        }
        
        let newQuestion = Question(question: questionText, answer: answerText)
        if let savedQuestionsData = UserDefaults.standard.data(forKey: "SavedQuestions"),
           var savedQuestions = try? JSONDecoder().decode([Question].self, from: savedQuestionsData) {
            savedQuestions.append(newQuestion)
            
            if let encodedQuestions = try? JSONEncoder().encode(savedQuestions) {
                UserDefaults.standard.set(encodedQuestions, forKey: "SavedQuestions")
            }
        } else {
            let newQuestions = [newQuestion]
            
            if let encodedQuestions = try? JSONEncoder().encode(newQuestions) {
                UserDefaults.standard.set(encodedQuestions, forKey: "SavedQuestions")
            }
        }
        let adminVc = AdminViewController()
        navigationController?.pushViewController(adminVc, animated: true)
    }
    @IBAction func cancleButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
