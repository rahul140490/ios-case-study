//
//  ListViewState.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Tempo

/// List view state
struct ListViewState: TempoViewState, TempoSectionedViewState {
    var listItems: [TempoViewStateItem]
    
    var sections: [TempoViewStateItem] {
        return listItems
    }
}

/// View state for each list item.
struct ListItemViewState: TempoViewStateItem, Equatable {
    let id: UInt?
    let title: String?
    let price: String?
    let imageURL: String?
    let aisle: String?
}

func ==(lhs: ListItemViewState, rhs: ListItemViewState) -> Bool {
    return lhs.id == rhs.id
        && lhs.title == rhs.title
        && lhs.price == rhs.price
        && lhs.imageURL == rhs.imageURL
        && lhs.aisle == rhs.aisle
}
