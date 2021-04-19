//
//  HomeCoordinator.swift
//  Сurrencies
//
//  Created by Daniil G on 18.04.2021.
//

import UIKit

protocol HomeCoordinatorlDelegate: class {
    
}

class HomeCoordinator: HomeScreenViewModelDelegate, СurrencySelectionScreenViewModelDelegate {

    // MARK: - Properties
    
    private let centralBank: CentralBankService
    
    private let navigationController: UINavigationController
    private var homeScreenViewController: HomeScreenViewController?
    private var currencySelectionScreenViewModel: СurrencySelectionScreenViewModel?
    weak var delegate: HomeCoordinatorlDelegate?
    
    // MARK: - Functions
    
    init(navigationController: UINavigationController, centralBank: CentralBankService) {
        self.navigationController = navigationController
        self.centralBank = centralBank
    }
    
    func start() {
        centralBank.loadCurrencies {
            self.showHomeScreen()
        }
    }
        
    private func showHomeScreen() {
        let homeScreenViewModel = HomeScreenViewModel(centralBank: centralBank)
        homeScreenViewModel.delegate = self
        
        homeScreenViewController = HomeScreenViewController.instantiate(from: "HomeScreen")
        guard let homeScreenViewController = homeScreenViewController else { return }
        homeScreenViewController.viewModel = homeScreenViewModel
        
        navigationController.pushViewController(homeScreenViewController, animated: true)
    }
    
    func updateTimeLabel(time: String) {
        guard let homeScreenViewController = homeScreenViewController else { return }
        homeScreenViewController.updateTimeLabel(time: time)
    }
    
    func didTapСonversionButton(_ viewModel: HomeScreenViewModel) {
        showСurrencySelectionScreen()
    }
    
    private func showСurrencySelectionScreen() {
        currencySelectionScreenViewModel = СurrencySelectionScreenViewModel(currencies: centralBank.currencies())
        guard let currencySelectionScreenViewModel = currencySelectionScreenViewModel else { return }
        currencySelectionScreenViewModel.delegate = self
        
        let currencySelectionScreenViewController = СurrencySelectionScreenViewController.instantiate(from: "HomeScreen")
        currencySelectionScreenViewController.viewModel = currencySelectionScreenViewModel
        
        navigationController.present(currencySelectionScreenViewController, animated: true, completion: nil)
    }
    
    func didTapСonversionButton(_ viewModel: СurrencySelectionScreenViewModel, baseСurrency: Currency, quotedСurrency: Currency) {
        navigationController.dismiss(animated: true) {
            self.showConverterScreen(baseСurrency: baseСurrency, quotedСurrency: quotedСurrency)
        }
    }
    
    private func showConverterScreen(baseСurrency: Currency, quotedСurrency: Currency) {
        let converterScreenViewModel = ConverterScreenViewModel(baseСurrency: baseСurrency, quotedСurrency: quotedСurrency)
        
        let converterScreenViewController = ConverterScreenViewController.instantiate(from: "HomeScreen")
        converterScreenViewController.viewModel = converterScreenViewModel
        
        navigationController.pushViewController(converterScreenViewController, animated: true)
    }
}
