import UIKit
import PubNub

class MessageTVC: UITableViewController {
    
    let notificationName = Notification.Name("NewMessage")

    @IBAction func settingsButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Geofencing", bundle: nil)
        let settingVC = storyboard.instantiateViewController(withIdentifier: "Settings")
        self.navigationController?.pushViewController(settingVC, animated: true)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(MessageTVC.updateMessage), name: notificationName, object: nil)
        tableView.tableFooterView = UIView()
        let imageView = UIImageView(image: UIImage(named: "NewBack"))
        self.tableView.backgroundView = imageView

    }
    
    func updateMessage()  {
        print("new message reveived by table view controller")
        tableView.reloadData()
    }

    
}


extension MessageTVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppDelegate.shared.myMessages.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        
        cell.textLabel?.text = AppDelegate.shared.myMessages[indexPath.row]
//        
//        cell.layer.cornerRadius = 20
//        cell.clipsToBounds = true
//        
        
        cell.contentView.backgroundColor = UIColor.clear
        
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 0, y: 10, width: self.view.frame.size.width, height: 120))
        
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 20.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.2
        whiteRoundedView.clipsToBounds = true
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
        cell.layer.cornerRadius = 20.0
        cell.clipsToBounds = true
        return cell
    }
    
}
