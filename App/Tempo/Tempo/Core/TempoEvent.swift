//
//  TempoLifecycleEvent
//  HarmonyKit
//
//  Copyright © 2016 Target. All rights reserved.
//

import Foundation

public struct TempoLifecycleEvent {
    public struct ViewDidAppear: EventType {
        public init() {}
    }

    public struct ViewWillAppear: EventType {
        public init() {}
    }
    
    public struct ViewWillDisappear: EventType {
        public init() {}
    }

    public struct ViewDidLoad: EventType {
        public init() {}
    }
}

public struct TempoEvent {
    public struct CollectionViewUpdatesComplete: EventType {
        public init() {}
    }
}
