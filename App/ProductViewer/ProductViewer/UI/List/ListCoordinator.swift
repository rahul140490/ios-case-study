//
//  ListCoordinator.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Foundation
import Tempo
import Combine

/*
 Coordinator for the product list
 */
class ListCoordinator: TempoCoordinator {
    
    // MARK: Presenters, view controllers, view state.
    
    var presenters = [TempoPresenterType]() {
        didSet {
            updateUI()
        }
    }
    
    fileprivate var viewState: ListViewState {
        didSet {
            updateUI()
        }
    }
    
    fileprivate func updateUI() {
        for presenter in presenters {
            presenter.present(viewState)
        }
    }
    
    let dispatcher = Dispatcher()
    
    lazy var viewController: ListViewController = {
        return ListViewController.viewControllerFor(coordinator: self)
    }()
    
    private var disposables = Set<AnyCancellable>()
    
    
    // MARK: Init
    
    required init() {
        viewState = ListViewState(listItems: [])
        updateState()
        registerListeners()
    }
    
    // MARK: ListCoordinator
    
    fileprivate func registerListeners() {
        dispatcher.addObserver(ListItemPressed.self) { [weak self] event in
            if let productID = event.item.id {
                let viewController = DetailsCoordinator(productID: productID).viewController
                
                self?.viewController.present(viewController, animated: true, completion: nil)
            }
        }
    }
    
    func updateState() {
        ProductClient.resquestProductList()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { value in
                switch value {
                case .failure:
                    print("Request failed with error - \(value)")
                    
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] object in
                guard let self = self else { return }
                
                if let products = object.products {
                    self.viewState.listItems = products.map { product in
                        ListItemViewState(id: product.id,
                                          title: product.title?.capitalized,
                                          price: product.regularPrice?.displayString,
                                          imageURL: product.imageURL,
                                          aisle: product.aisle)
                    }
                }
            })
            .store(in: &disposables)
    }
}
