PeerConnectivity
================

[![Platform: iOS 8+](https://img.shields.io/badge/platform-iOS%208%2B-blue.svg?style=flat)]()
[![Language: Swift 3](https://img.shields.io/badge/language-swift3-f48041.svg?style=flat)](https://developer.apple.com/swift)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Cocoapods compatible](https://cocoapod-badges.herokuapp.com/v/PeerConnectivity/badge.png)](https://cocoapods.org/pods/PeerConnectivity)
[![Docs](https://img.shields.io/cocoapods/metrics/doc-percent/PeerConnectivity.svg)](http://cocoadocs.org/docsets/PeerConnectivity)
[![License: MIT](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)]()

####A functional wrapper for the MultipeerConnectivity framework. 

######PeerConnectivity is meant to have a lightweight easy to use syntax, be extensible and flexible, and handle the heavy lifting and edge cases of the MultipeerConnectivity framework quietly in the background. 

######Please open an issue or submit a pull request if you have any suggestions!

######Check out the Playground!


### Installation

####Cocoapods

```ruby
pod 'PeerConnectivity'
```

####Carthage

```ruby
github "rchatham/PeerConnectivity"
```


### Creating/Stopping/Starting

```swift
var pcm = PeerConnectionManager(serviceType: "local")

// Start
pcm.start()

// Stop
//  - You should always stop the connection manager 
//    before attempting to create a new one
pcm.stop()

// Can join chatrooms using PeerConnectionType.Automatic, .InviteOnly, and .Custom
//  - .Automatic : automatically searches and joins other devices with the same service type
//  - .InviteOnly : provides a browserViewController and invite alert controllers
//  - .Custom : no default behavior is implemented

// The manager can be initialized with a contructed peer representing the local user
// with a custom displayName

pcm = PeerConnectionManager(serviceType: "local", connectionType: .Automatic, displayName: "I_AM_KING")

// Start again at any time
pcm.start() {
    // Do something when finished starting the session
}
```

### Sending Events to Peers

```swift
let event: [String: Any] = [
    "EventKey" : Date()
]

// Sends to all connected peers
pcm.sendEvent(event)


// Use this to access the connectedPeers
let connectedPeers: [Peer] = pcm.connectedPeers

// Events can be sent to specific peers
if let somePeerThatIAmConnectedTo = connectedPeers.first {
   pcm.sendEvent(event, toPeers: [somePeerThatIAmConnectedTo])
}
```

### Listening for Events

```swift
// Listen to an event
pcm.listenOn({ event in
    switch event {
    case .ReceivedEvent(let peer, let eventInfo):
        print("Received some event \(eventInfo) from \(peer.displayName)")
        guard let date = eventInfo["EventKey"] as? Date else { return }
        print(date)
    default: break
    }
}, withKey: "SomeEvent")

// Stop listening to an event
pcm.removeListenerForKey("SomeEvent")
```

###Initializer

```swift
init(serviceType: ServiceType, 
  connectionType: PeerConnectionType = .automatic, 
     displayName: String = UIDevice.currentDevice().name)
```

###Properties

```swift
connectionType : PeerConnectionType { get }

peer : Peer { get }

connectedPeers : [Peer] { get }

displayNames : [String] { get }

foundPeers: [Peer] { get }
```

###Methods

```swift
start(completion: (Void->Void)? = nil)

browserViewController(callback: PeerBrowserViewControllerEvent->Void) -> UIViewController?

invitePeer(peer: Peer, withContext context: Data? = nil, timeout: TimeInterval = 30)

sendData(data: Data, toPeers peers: [Peer] = [])

sendEvent(eventInfo: [String:Any], toPeers peers: [Peer] = [])

sendDataStream(streamName name: String, toPeer peer: Peer) throws -> OutputStream

sendResourceAtURL(resourceURL: URL,
                        withName name: String,
                        toPeers peers: [Peer] = [],
     withCompletionHandler completion: ((Error?) -> Void)? ) -> [Peer:Progress?]
             
refresh(completion: (Void->Void)? = nil)

stop()
```

#####In addition to these methods there is a full range of listeners that give you total control over the entire range of MultipeerConnectivity options.

```swift
listenOn(listener: PeerConnectionEventListener, performListenerInBackground background: Bool = false, withKey key: String)
        
removeListenerForKey(key: String)

removeAllListeners()
```
