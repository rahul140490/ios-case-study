//
//  ProductListComponent.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import UIKit
import Tempo

final class ProductListView: UIView {
    //MARK:- IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var aisleButton: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var dividerView: UIView!

    //MARK:- View LifeCycle
    override func awakeFromNib() {
        // initial UI customizations
        layer.cornerRadius = 10.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.targetStrokeGrayColor.cgColor
        
        aisleButton.layer.cornerRadius = aisleButton.bounds.width / 2
        aisleButton.layer.borderWidth = 2.0
        aisleButton.layer.borderColor = UIColor.targetStrokeGrayColor.cgColor
        
        dividerView.backgroundColor = .targetStrokeGrayColor
    }
}

extension ProductListView: ReusableNib {
    @nonobjc static let nibName = "ProductListView"
    @nonobjc static let reuseID = "ProductListViewIdentifier"

    @nonobjc func prepareForReuse() {
        
    }
}
