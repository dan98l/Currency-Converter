//
//  HomeScreenViewModel.swift
//  Сurrencies
//
//  Created by Даниил Голубятников on 18.04.2021.
//

import Foundation

protocol HomeScreenViewModelDelegate: class {
    func updateTimeLabel(time: String)
    func didTapСonversionButton(_ viewModel: HomeScreenViewModel)
}

class HomeScreenViewModel {
    
    // MARK: - Properties
    
    weak var delegate: HomeScreenViewModelDelegate?
    private let centralBank: CentralBankService
    private var currencies = [Currency]()
    
    private var timer = Timer()
    
    // MARK: - Functions

    init(centralBank: CentralBankService) {
        self.centralBank = centralBank
    }
    
    func setupTable(completion: @escaping() -> ()) {
        self.currencies = self.centralBank.currencies()
        completion()
    }
    
    func currenciesCount() -> Int {
        currencies.count
    }
    
    func tableCell(index: Int) -> CurrencyTableViewCellModel {
        let currency = centralBank.currency(index: index)
        
        if let name = currency.name, let charCode = currency.charCode, let value = currency.value {
            return CurrencyTableViewCellModel(name: name, charCode: charCode, value: value)
        }
        return CurrencyTableViewCellModel()
    }
    
    func setupLabelTime() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.currentTime) , userInfo: nil, repeats: true)
    }

    @objc func currentTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        delegate?.updateTimeLabel(time: formatter.string(from: Date()))
    }
    
    func setupCurrenciesLabel() -> (usd: String, eur: String) {
        if let usd = centralBank.currencyUSD(), let eur = centralBank.currencyEUR() {
            return (usd: usd, eur: eur)
        }
        return (usd: "", eur: "")
    }
    
    func didTapСonversionButton() {
        delegate?.didTapСonversionButton(self)
    }
}
