//
//  DetailsCoordinator.swift
//  ProductViewer
//
//  Created by Rahul Kumar on 04/04/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import Tempo
import Combine

/*
 Coordinator for the product list
 */
class DetailsCoordinator: TempoCoordinator {
    
    // MARK: Presenters, view controllers, view state.
    
    var productID: UInt
    
    var presenters = [TempoPresenterType]() {
        didSet {
            updateUI()
        }
    }
    
    fileprivate var viewState: DetailsViewState {
        didSet {
            updateUI()
        }
    }
    
    fileprivate func updateUI() {
        viewController.configureView(product: viewState)
    }
    
    let dispatcher = Dispatcher()
    
    lazy var viewController: DetailsViewController = {
        return DetailsViewController.viewControllerFor(coordinator: self)
    }()
    
    private var disposables = Set<AnyCancellable>()
    
    // MARK: Init
    
    required init(productID: UInt) {
        self.productID = productID
        viewState = DetailsViewState(price: "",
                                     description: "",
                                     imageURL: "")
        updateState()
    }
        
    func updateState() {
        ProductClient.requestProductDetails(id: productID)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { value in
                switch value {
                case .failure:
                    print("Request failed with error - \(value)")
                    
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] product in
                guard let self = self else { return }
                
                self.viewState = DetailsViewState(price: product.regularPrice?.displayString,
                                                  description: product.description,
                                                  imageURL: product.imageURL)
            })
            .store(in: &disposables)
    }
}
