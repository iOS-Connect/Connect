import UIKit

class SettingsViewController: UIViewController {

    @IBAction func selectLocation(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Geofencing", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Map")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}
