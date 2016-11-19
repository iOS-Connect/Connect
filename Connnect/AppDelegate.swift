import UIKit
import PubNub

enum PubNubKeys {
    static let publish = "pub-c-655893d9-dc93-4586-8fc2-7de8885c522e"
    static let subscribe = "sub-c-a73426c2-ae81-11e6-a7bb-0619f8945a4f"
    static let secret = "sec-c-NmI2OTZjYTUtNjI0NC00ZGRlLThiMTktY2YzODUyNmZmY2M2"
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PNObjectEventListener {

    
    var window: UIWindow?
    var client: PubNub!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Initialize and configure PubNub client instance
        let configuration = PNConfiguration(publishKey: "demo", subscribeKey: "demo")
        self.client = PubNub.client(with: configuration)
        self.client.add(self)
        
        // Subscribe to demo channel with presence observation
        self.client.subscribe(toChannels: ["my_channel"], withPresence: true)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


extension AppDelegate {
    func client(_ client: PubNub, didReceiveMessage message: PNMessageResult) {
        
        
        // Handle new message stored in message.data.message
        if message.data.channel != message.data.subscription {
            
            // Message has been received on channel group stored in message.data.subscription.
        }
        else {
            
            // Message has been received on channel stored in message.data.channel.
        }
        
        print("Received message: \(message.data.message) on channel \(message.data.channel) " +
            "at \(message.data.timetoken)")
    }
}

