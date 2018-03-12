import UIKit
import FirebaseAuth

class ViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
 
   // override var prefersStatusBarHidden: Bool{return true}
    override var preferredStatusBarStyle: UIStatusBarStyle {return .lightContent}
    let ImagePicker = UIImagePickerController()
    @IBOutlet weak var TopLayoutImageView: NSLayoutConstraint!
    @IBOutlet weak var DownLayoutImageView: NSLayoutConstraint!
    @IBOutlet weak var ImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var FromGetStartedToStackView: NSLayoutConstraint!
    @IBOutlet weak var DownConstraintOfButton: NSLayoutConstraint!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet var TextFieldS: [UITextField]!
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!
    @IBOutlet weak var ConfirmPasswordTF: UITextField!
    
    @IBAction func GetStartedButton(_ sender: UIButton) {
        if PasswordTF.text != ConfirmPasswordTF.text {
            MessageBox.Show(Message: "Wrong Confirm", MyVC: self)
            return
        }
        Auth.auth().createUser(withEmail: EmailTF.text!, password: PasswordTF.text!) { (User, Error) in
            if Error == nil{
                self.performSegue(withIdentifier: "Next", sender: nil)
            } else {
                MessageBox.Show(Message: Error!.localizedDescription, MyVC: self)
                self.EmailTF.text = ""
                self.PasswordTF.text = ""
            }
        }
        EmailTF.text = ""
        PasswordTF.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpKeyboard()
        SettingUpImageView()
        for one in TextFieldS{
            one.delegate=self
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


// image view
extension ViewController {
    
    func SettingUpImageView(){
        let TapGuestreRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.ChooseImage))
        ImageView.addGestureRecognizer(TapGuestreRecognizer)
        ImageView.isUserInteractionEnabled = true
        
    }
    @objc func ChooseImage(){
        let AlertController = UIAlertController(title: "choose", message: "choose your image source", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default) { (AlertController) in
            self.ImagePicker.sourceType = .camera
        }
        let Library = UIAlertAction(title: "Library", style: .default) { (AlertController) in
            self.ImagePicker.sourceType = .photoLibrary
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
                self.ImagePicker.delegate = self
                self.ImagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                self.ImagePicker.allowsEditing = true
                self.present(self.ImagePicker, animated: true, completion: nil)
            }
        }
        let Cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        AlertController.addAction(camera)
        AlertController.addAction(Library)
        AlertController.addAction(Cancel)
        present(AlertController, animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        let TheImage = info[UIImagePickerControllerEditedImage] as! UIImage
        ImageView.image = TheImage
        dismiss(animated: true, completion: nil)
    }
    
}

//TextFieldDelegate
extension ViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        for one in TextFieldS{
            if one.tag == textField.tag + 1 {
                one.becomeFirstResponder()
            }
        }
        return true
    }
}

// Keyboard
extension ViewController {
   
    func SetUpKeyboard(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.KeybordDidHide(Notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.KeybordDidShow(Notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
    }
    
    @objc func KeybordDidShow(Notification:NSNotification){
        guard let dictionary = Notification.userInfo as? [String:AnyObject] else {return}
        guard let keybordsize=dictionary[UIKeyboardFrameEndUserInfoKey] as? CGRect else {return}
        StartAnimation(KeybordHeight: keybordsize.height)
    }
    @objc func KeybordDidHide(Notification:NSNotification){
        StopAnimation()
    }
}

// Animation
extension ViewController{
    
    func StartAnimation(KeybordHeight:CGFloat){
        TopLayoutImageView.constant=0
        ImageViewHeight.constant=0
        DownLayoutImageView.constant=30
        DownConstraintOfButton.constant = KeybordHeight + 8
        UIView.animate(withDuration: 0.2){
            self.view.layoutIfNeeded()
        }
    }
    func StopAnimation(){
        TopLayoutImageView.constant=60
        ImageViewHeight.constant=100
        DownLayoutImageView.constant=50
        DownConstraintOfButton.constant = 90
        UIView.animate(withDuration: 0.2){
            self.view.layoutIfNeeded()
    }
    }
}
