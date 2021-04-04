//
//  TempoFocus.swift
//  HarmonyKit
//
//  Copyright © 2016 Target. All rights reserved.
//

import Foundation

/**
 *  Indicates how focus should be applied to a Tempo view state.
 */
public struct TempoFocus: Equatable {
    public enum Position {
        case centeredHorizontally
        case centeredVertically
    }

    public let indexPath: IndexPath
    public let position: Position
    public let animated: Bool

    public init(indexPath: IndexPath, position: Position, animated: Bool) {
        self.indexPath = indexPath
        self.position = position
        self.animated = animated
    }
}

public func ==(lhs: TempoFocus, rhs: TempoFocus) -> Bool {
    return lhs.indexPath == rhs.indexPath
        && lhs.position == rhs.position
        && lhs.animated == rhs.animated
}
