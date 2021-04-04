//
//  TempoCoordinator.swift
//  HarmonyKit
//
//  Copyright © 2016 Target. All rights reserved.
//

import Foundation

public protocol TempoCoordinator {
    var presenters: [TempoPresenterType] { get set }
    var dispatcher: Dispatcher { get }
}
