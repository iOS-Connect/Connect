import UIKit

class SendViewController: UIViewController {

    lazy var textDelegate:MessageTextDelegate = {
        let del = MessageTextDelegate(msgHandler: { (message) in
            let pub = AppDelegate.shared.client
            pub?.publish(message, toChannel:"my_channel",
                         compressed: false, withCompletion: nil)
        })
        return del
    }()

    @IBOutlet weak var messageTextField: UITextField! {
        didSet {
            self.messageTextField.delegate = self.textDelegate
        }
    }

    override func viewDidLoad() {
        navigationItem.title = "Send Message"
        

    }

}


class MessageTextDelegate: NSObject, UITextFieldDelegate {

    let callback: ((_ text:String) -> Void)

    init(msgHandler: @escaping (String) -> Void) {
        callback = msgHandler
    }


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let message = textField.text else { return false }
        callback(message)
        print("Send Message: \(message)")
        textField.resignFirstResponder()

        textField.text = ""
        return true
    }
}
