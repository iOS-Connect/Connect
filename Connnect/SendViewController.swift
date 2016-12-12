import UIKit

class SendViewController: UIViewController {

    var textDelegate = MessageTextDelegate()
    
    
 
    @IBOutlet weak var messageTextField: UITextField! {
        didSet {
            self.messageTextField.delegate = self.textDelegate
        }
    }

    override func viewDidLoad() {
        navigationItem.title = "Send Message"

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "NewBack")!)
        
        textDelegate.callback = self.helper
        
        

    }
    
    func helper (message: String){
            let pub = AppDelegate.shared.client
    
            let targetChannel = pub?.channels().last!
            pub?.publish(message, toChannel:targetChannel!,
                             compressed: false, withCompletion: nil)
    }

}


class MessageTextDelegate: NSObject, UITextFieldDelegate {

    var callback: ((_ text:String) -> Void)? = nil

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let message = textField.text else { return false }
        callback?(message)
        print("Send Message: \(message)")
        textField.resignFirstResponder()

        textField.text = ""
        return true
    }
}
