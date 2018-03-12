import UIKit
import FirebaseAuth

class SignInVC: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {return .lightContent}

    @IBOutlet weak var ButtonLayout: NSLayoutConstraint!
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!
    @IBAction func SignInButton(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: EmailTF.text!, password: PasswordTF.text!) { (User, Error) in
            if Error == nil {
                self.performSegue(withIdentifier: "Next", sender: nil)
            }else {
                MessageBox.Show(Message:Error!.localizedDescription , MyVC: self)
                self.EmailTF.text = ""
                self.PasswordTF.text = ""
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpKeyboard()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func GestureToSignUp(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
        
    }
    
}



// Keyboard
extension SignInVC {
    
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
