import UIKit
import FirebaseAuth

class SecondVC: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle{return .lightContent}
    
    @IBAction func SignOutButton(_ sender: Any) {
        try? Auth.auth().signOut()
        dismiss(animated: true, completion: nil)
    }
    
}
