//
//  ProductListComponent.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Tempo

struct ProductListComponent: Component {
    var dispatcher: Dispatcher?

    func prepareView(_ view: ProductListView, item: ListItemViewState) {
        // Called on first view or ProductListView
    }
    
    func configureView(_ view: ProductListView, item: ListItemViewState) {
        view.titleLabel.text = item.title
        view.priceLabel.text = item.price
        view.aisleButton.setTitle(item.aisle?.capitalized, for: .normal)
        
        // load remote image
        DispatchQueue.global().async {
            if let imageURLString = item.imageURL,
               let imageURL = URL(string: imageURLString),
               let imageData = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    view.productImage.image = UIImage(data: imageData)
                }
            }
        }
    }
    
    func selectView(_ view: ProductListView, item: ListItemViewState) {
        dispatcher?.triggerEvent(ListItemPressed(item: item))
    }
}

extension ProductListComponent: HarmonyLayoutComponent {
    func heightForLayout(_ layout: HarmonyLayout, item: TempoViewStateItem, width: CGFloat) -> CGFloat {
        return 150.0
    }
    
    func sectionMarginsForLayout(_ layout: HarmonyLayout) -> HarmonyLayoutMargins {
        HarmonyLayoutMargins(top: .quarter,
                             right: .quarter,
                             bottom: .quarter,
                             left: .quarter)
    }
}
