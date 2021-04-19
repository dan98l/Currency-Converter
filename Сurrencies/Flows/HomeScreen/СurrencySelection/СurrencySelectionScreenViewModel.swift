//
//  СalculatorScreenViewModel.swift
//  Сurrencies
//
//  Created by Даниил Голубятников on 19.04.2021.
//

import Foundation

protocol СurrencySelectionScreenViewModelDelegate: class {
    func didTapСonversionButton(_ viewModel: СurrencySelectionScreenViewModel, baseСurrency: Currency, quotedСurrency: Currency)
}

class СurrencySelectionScreenViewModel {
    
    // MARK: - Properties
        
    private var currencies = [Currency]()
    weak var delegate: СurrencySelectionScreenViewModelDelegate?
    private var baseСurrency: Currency?
    private var quotedСurrency: Currency?
    private var conversionState = false
    
    // MARK: - Functions
    
    init(currencies: [Currency]) {
        self.currencies = currencies
        if let baseСurrency = currencies.first, let quotedСurrency = currencies.first {
            self.baseСurrency = baseСurrency
            self.quotedСurrency = quotedСurrency
        }
    }
    
    func currenciesCount() -> Int {
        currencies.count
    }
    
    private func component(index: Int) -> Currency {
        currencies[index]
    }
    
    func componentString(index: Int) -> String {
        currencies[index].charCode ?? ""
    }
    
    func didTapСonversionButton() {
        if let baseСurrency = baseСurrency, let quotedСurrency = quotedСurrency {
            delegate?.didTapСonversionButton(self, baseСurrency: baseСurrency, quotedСurrency: quotedСurrency)
        }
    }
    
    func didSelectCurrency(row: Int, component: Int) {
        if component == 0 {
            baseСurrency = self.component(index: row)
        } else {
            quotedСurrency = self.component(index: row)
        }
        
        checkState()
    }
    
    private func checkState() {
        if let baseСurrency = baseСurrency, let quotedСurrency = quotedСurrency {
            if baseСurrency.charCode != quotedСurrency.charCode {
                conversionState = true
            } else {
                conversionState = false
            }
        }
    }
    
    func conversion() -> Bool {
        conversionState
    }
}
