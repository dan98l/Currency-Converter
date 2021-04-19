//
//  AppCoordinator.swift
//  Сurrencies
//
//  Created by Daniil G on 18.04.2021.
//

import UIKit

class AppCoordinator {
    
    // MARK: - Properties
    
    private let navigationController = UINavigationController()
    private let window: UIWindow
    
    private let centralBank = CentralBankService.shared()
    
    private let homeCoordinator: HomeCoordinator
    
    // MARK: - Functions
    
    init(window: UIWindow) {
        self.window = window
        homeCoordinator = HomeCoordinator(navigationController: navigationController, centralBank: centralBank)
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.showHomeScreen()
    }
    
    private func showHomeScreen() {
        homeCoordinator.start()
    }
}
