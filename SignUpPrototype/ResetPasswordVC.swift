import UIKit
import FirebaseAuth

class ResetPasswordVC: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {return .lightContent}
    
    @IBOutlet weak var ButtonLayout: NSLayoutConstraint!
    @IBOutlet weak var EmailTF: UITextField!
    @IBAction func ResetPasswordButton(_ sender: UIButton) {
        Auth.auth().sendPasswordReset(withEmail: EmailTF.text!) { (Error) in
            if Error != nil {
                MessageBox.Show(Message: "Enter Valid Mail", MyVC: self)
            }else {
                MessageBox.Show(Message: "Check Your Mail To Reset Password", MyVC: self)
            }
        }
    }
    
    @IBAction func SignInGestureRecognizer(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpKeyboard()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}
// Keyboard
extension ResetPasswordVC {
    
    func SetUpKeyboard(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.KeybordDidHide(Notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.KeybordDidShow(Notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
    }
    
    @objc func KeybordDidShow(Notification:NSNotification){
        guard let dictionary = Notification.userInfo as? [String:AnyObject] else {return}
        guard let keybordsize=dictionary[UIKeyboardFrameEndUserInfoKey] as? CGRect else {return}
        ButtonLayout.constant = keybordsize.height + 16
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        
    }
    @objc func KeybordDidHide(Notification:NSNotification){
        ButtonLayout.constant = 150
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
}
