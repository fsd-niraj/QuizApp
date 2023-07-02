import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var adminButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adminButton.addTarget(self, action: #selector(adminButtonTapped), for: .touchUpInside)
        userButton.addTarget(self, action: #selector(userButtonTapped), for: .touchUpInside)
    }
    
    @objc func adminButtonTapped() {
        let adminViewController = AdminViewController()
        navigationController?.pushViewController(adminViewController, animated: true)
    }
    
    @objc func userButtonTapped() {
        let userViewController = UserViewController()
        navigationController?.pushViewController(userViewController, animated: true)
    }
}
