import UIKit

class UserViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedQuestionsData = UserDefaults.standard.data(forKey: "SavedQuestions"),
               let savedQuestions = try? JSONDecoder().decode([Question].self, from: savedQuestionsData) {
                self.questions = savedQuestions
            }
        goBackBtn.isHidden = true
        if questions.count == 0{
            questionLabel.text = "No Questions in the quiz"
            trueButton.isHidden = true
            falseButton.isHidden = true
            progressBar.isHidden = true
            goBackBtn.isHidden = false
        }
        updateUI()
    }
    
    var questions: [Question] = []
    var currentQuestionIndex = 0
    var marks = 0
    
    @IBOutlet weak var goBackBtn: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func trueButtonTapped(_ sender: UIButton) {
        checkAnswer(true)
    }
    
    @IBAction func falseButtonTapped(_ sender: UIButton) {
        checkAnswer(false)
    }
    @IBAction func goBackAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    public func updateUI() {
        if questions.count > 0 {
            questionLabel.text = questions[currentQuestionIndex].question
            
            let progress = Float(currentQuestionIndex) / Float(questions.count)
            progressBar.setProgress(progress, animated: true)
        }else{
            return
        }
    }
    
    func checkAnswer(_ userAnswer: Bool) {
        if questions.count > 0{
            if currentQuestionIndex + 1 == questions.count{
                return showResult()
            }
            let correctAnswer = questions[currentQuestionIndex].answer
            
            if userAnswer == correctAnswer {
                marks += 1
            }
            if currentQuestionIndex + 1 < questions.count {
                currentQuestionIndex += 1
                updateUI()
            } else {
                return showResult()
            }
        }
    }
    
    func showResult() {
        let alert = UIAlertController(title: "Thank You for finishing the quiz", message: "You score is \(marks) out of \(questions.count)!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {(_) in
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeVc = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! ViewController
            self.navigationController?.pushViewController(homeVc, animated: true)
            }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}
