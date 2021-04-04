//
//  DetailsViewController.swift
//  ProductViewer
//
//  Created by Rahul Kumar on 04/04/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit
import Tempo

class DetailsViewController: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var addToListButton: UIButton!
    
    //MARK:- Properties
    fileprivate var coordinator: TempoCoordinator!
    
    //MARK:- View LifeCycle
    class func viewControllerFor(coordinator: TempoCoordinator) -> DetailsViewController {
        let viewController = DetailsViewController(nibName: "DetailsViewController",
                                                   bundle: nil)
        viewController.coordinator = coordinator
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // initial UI setup
        priceLabel.font = UIFont.systemFont(ofSize: 24.0, weight: .semibold)
        descriptionLabel.font = UIFont.systemFont(ofSize: 12.0, weight: .medium)
        
        addToCartButton.setTitle("add to cart", for: .normal)
        addToCartButton.setTitleColor(.white, for: .normal)
        addToCartButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        addToCartButton.backgroundColor = .targetBullseyeRedColor
        
        addToListButton.setTitle("add to list", for: .normal)
        addToListButton.setTitleColor(.black, for: .normal)
        addToListButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        addToListButton.backgroundColor = .targetStrokeGrayColor
    }
    
    //MARK:- Helper Functions
    func configureView(product: DetailsViewState) {
        priceLabel.text = product.price
        descriptionLabel.text = product.description
        
        // load remote image
        DispatchQueue.global().async {
            if let imageURLString = product.imageURL,
               let imageURL = URL(string: imageURLString),
               let imageData = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async { [weak self] in
                    self?.productImageView.image = UIImage(data: imageData)
                }
            }
        }
    }}
