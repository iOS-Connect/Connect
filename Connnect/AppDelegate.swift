import UIKit
import MapKit
import PubNub
import CoreLocation


enum AppColors {
    static let TenderShoots = UIColor(colorLiteralRed: 179/255,
                                      green: 230/255, blue: 18/255, alpha: 1)
    static let JadeCream = UIColor(colorLiteralRed: 97/255,
                                   green: 189/255, blue: 147/255, alpha: 1)
    static let Cayenne = UIColor(colorLiteralRed: 224/255,
                                 green: 73/255, blue: 81/255, alpha: 1)
    static let LightGray = UIColor(colorLiteralRed: 219/255,
                                   green: 217/255, blue: 206/255, alpha: 1)
}

// not optimal but works for the moment
let pnh = PubNubHandler()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PNObjectEventListener {

    static let shared = UIApplication.shared.delegate as! AppDelegate

    var locationManager = CLLocationManager()
    let themeColor = AppColors.LightGray

    var window: UIWindow?
    var myMessages = [String]()
    var notification = NotificationCenter.default
    let notificationName = Notification.Name("NewMessage")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configurePubNubReciveHandler()
        window?.tintColor = AppColors.JadeCream
        UINavigationBar.appearance().barTintColor = themeColor

        let currentChannels = (UserDefaults.standard.array(forKey: channelKey) ?? []) as! [String]
        if currentChannels.isEmpty {
            let newChannelStorybard = UIStoryboard(name: "EditChannel", bundle: nil)
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = newChannelStorybard.instantiateInitialViewController()!
        } else {
            pnh.client.subscribe(toChannels: currentChannels, withPresence: true)
            var current = (UserDefaults.standard.array(forKey: channelKey) ?? [Any]()) as? [String]
            if current == nil {
                current = [String]()
            }
            for channel in currentChannels {
                current!.append(channel)
            }
            UserDefaults.standard.set(current!, forKey: channelKey)
        }

        return true
    }

    func openMainViewController() {
        let main = UIStoryboard(name: "Main", bundle: nil)
        window?.rootViewController = main.instantiateInitialViewController()
    }

    func configurePubNubReciveHandler() {
        pnh.receiveHandler = { (message: PNMessageResult) in
        guard let theMessage = message.data.message as? String else {return}
        self.myMessages.insert(theMessage, at: 0)
        let note = Notification(name: self.notificationName)
        self.notification.post(note)
        print("Received message: \(message.data.message) on channel \(message.data.actualChannel) " +
            "at \(message.data.timetoken)")
        }

    }

}

extension AppDelegate: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("I just enetered this location")
        let targetChannel = pnh.client.channels().last!
        pnh.client.publish("Just Got to Work", toChannel: targetChannel , withCompletion: nil)
    }
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("I just exited this location")
        let targetChannel = pnh.client.channels().last!
        pnh.client.publish("Just Left From Work", toChannel: targetChannel , withCompletion: nil)
    }
}



