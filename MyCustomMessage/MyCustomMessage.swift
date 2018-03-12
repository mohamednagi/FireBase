import UIKit

class MyCustomMessageVC: UIViewController {

    var Message : String!
    @IBOutlet weak var Messagelbl: UILabel!
    @IBOutlet weak var BigView: UIView! {
        didSet{
            BigView.layer.cornerRadius = 10
            BigView.layer.borderColor = UIColor.white.cgColor
            BigView.layer.borderWidth = 1
      }
    }
    
    @IBOutlet weak var OkButton: UIButton! {
        didSet{
            OkButton.layer.cornerRadius=10
        }
    }
    
    @IBAction func OkButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Messagelbl.text = Message
    }
}

class MessageBox {
    
    static func Show(Message:String , MyVC : UIViewController) {
        let StoryBoard = UIStoryboard.init(name: "MyStoryBoardMessage", bundle: nil)
        let VC = StoryBoard.instantiateViewController(withIdentifier: "Message") as! MyCustomMessageVC
        VC.modalPresentationStyle = .fullScreen
        VC.modalTransitionStyle = .crossDissolve
        VC.Message = Message
        
        MyVC.present(VC, animated: true, completion: nil)
    }
}
