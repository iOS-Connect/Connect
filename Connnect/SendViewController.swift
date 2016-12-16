import UIKit

class SendViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let pub = AppDelegate.shared.client
    var textDelegate = MessageTextDelegate()
    
 
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var messageTextField: UITextField! {
        didSet {
            self.messageTextField.delegate = self.textDelegate
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let allChannels = pub?.channels()
        return allChannels?[row]
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
        return pub?.channels().count ?? 0
        
    
    }
    override func viewDidLoad() {
        navigationItem.title = "Send Message"

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "NewBack")!)
        
        textDelegate.callback = self.helper
        
        
        

    }
    
    func helper (message: String){
        
    
        let selectedIndex = picker.selectedRow(inComponent: 0)
        
        let allChannels = pub!.channels()
        
        let targetChannel = allChannels[selectedIndex]
        
        pub?.publish(message, toChannel:targetChannel,
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
