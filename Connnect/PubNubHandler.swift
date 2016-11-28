//
//  File.swift
//  Connect1
//
//  Created by Peer Dampmann on 11/19/16.
//  Copyright © 2016 Peer Dampmann. All rights reserved.
//

import UIKit
import PubNub

let channelKey = "CHANNELS"

enum PubNubKeys {
    static let publish = "pub-c-655893d9-dc93-4586-8fc2-7de8885c522e"
    static let subscribe = "sub-c-a73426c2-ae81-11e6-a7bb-0619f8945a4f"
}

class PubNubHandler : NSObject, PNObjectEventListener {
    var channel: String
    var message: String
    let configuration = PNConfiguration(publishKey: PubNubKeys.publish, subscribeKey: PubNubKeys.subscribe)
    var client: PubNub
    var receiveHandler:((PNMessageResult) -> Void)?
    
    override init() {
        self.message = "unchanged"
        self.channel = "my_channel"
        self.client = PubNub.client(with: configuration)
        super.init()
        self.client.add(self)
        self.client.subscribe(toChannels: [self.channel], withPresence: true)
        var current = (UserDefaults.standard.array(forKey: channelKey) ?? [Any]()) as? [String]
        if current == nil {
            current = [String]()
        }
        current!.append(self.channel)
        UserDefaults.standard.set(current!, forKey: "CHANNELS")
    }

    func setMessage(msg: String) -> Void {
        print("set message \(msg)")
        self.message = msg
    }
    
    func sendMessage() -> Void {
        print("send \(self.message) \(self.channel)")
        if self.message != "" {
            self.client.publish(self.message, toChannel: self.channel, withCompletion: { (publishStatus) -> Void in
                if !publishStatus.isError {
                    print("good")
                } else {
                    print("bad")
                    dump(publishStatus)
                }
            })
        }
    }
    
    func setChannel(channel: String) {
        self.channel = channel
        self.client.subscribe(toChannels: [self.channel], withPresence: true)
        var current = (UserDefaults.standard.array(forKey: channelKey) ?? [Any]()) as? [String]
        if current == nil {
            current = [String]()
        }
        current!.append(self.channel)
        UserDefaults.standard.set(current!, forKey: channelKey)
    }

    func client(_ client: PubNub, didReceiveMessage message: PNMessageResult) {
        print("didReceiveMessage")
        dump(message)
        receiveHandler?(message)
    }
    
    func client(_ client: PubNub, didReceivePresenceEvent event: PNPresenceEventResult) {
        print("didReceivePresenceEvent")
        dump(event)
    }
    
    func client(_ client: PubNub, didReceive status: PNStatus) {
        print("didReceiveStatus")
        dump(status)
    }
}
