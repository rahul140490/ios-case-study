//
//  TempoViewStateSection.swift
//  HarmonyKit
//
//  Copyright © 2016 Target. All rights reserved.
//

import Foundation

public protocol TempoViewStateSection: TempoViewStateItem {
    var header: TempoViewStateItem? { get }
}
