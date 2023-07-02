import UIKit

class AdminViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    class QuestionTableViewCell: UITableViewCell {
        @IBOutlet weak var questionLabel: UILabel!
        
        func configure(with question: Question) {
            questionLabel.text = question.question
        }
    }

    @IBOutlet weak var tableView: UITableView!
    var questions: [Question] = []
    
    class QuestionViewCell: UITableViewCell {
        @IBOutlet weak var questionText: UILabel!
        override func awakeFromNib() {
            super.awakeFromNib()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "QuestionCell")
        loadQuestions()
    }
    
    func loadQuestions() {
            if let savedQuestions = UserDefaults.standard.value(forKey: "SavedQuestions") as? Data {
                let decoder = JSONDecoder()
                if let loadedQuestions = try? decoder.decode([Question].self, from: savedQuestions) {
                    questions = loadedQuestions
                }
            }
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return questions.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath)
            
            let question = questions[indexPath.row]
            cell.textLabel?.text = question.question
            
            return cell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedQuestion = questions[indexPath.row]
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let editVc = storyBoard.instantiateViewController(withIdentifier: "AddEditViewController") as! AddEditViewController
        editVc.questionInput.text = selectedQuestion.question
        editVc.title = "Editing Question no."
        self.present(editVc, animated: true, completion: nil)
    }
    
    @IBAction func cancleButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func addNewQuestion(_ sender: Any) {
        let addEditVc = AddEditViewController()
        navigationController?.pushViewController(addEditVc, animated: true)
    }
}
