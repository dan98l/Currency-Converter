//
//  ConverterScreenViewModel.swift
//  Сurrencies
//
//  Created by Даниил Голубятников on 19.04.2021.
//

import Foundation

enum Сurrency {
    case base
    case quoted
}

class ConverterScreenViewModel {
    // MARK: - Properties
    
    private var baseСurrency: Currency
    private var quotedСurrency: Currency
    
    private var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        return formatter
    }
    
    // MARK: - Functions
    
    init(baseСurrency: Currency, quotedСurrency: Currency ) {
        self.baseСurrency = baseСurrency
        self.quotedСurrency = quotedСurrency
    }
    
    func settingLabel() -> (baseСurrency: String, quotedСurrency: String) {
        guard let baseСurrency = baseСurrency.charCode, let quotedСurrency = quotedСurrency.charCode else {
            return (baseСurrency: "", quotedСurrency: "")
        }
        return (baseСurrency: baseСurrency, quotedСurrency: quotedСurrency)
    }
    
    func didTapСonversionButton(value: String, currency: Сurrency, completion: @escaping (String) -> ()) {
        
        guard let baseСurrency = baseСurrency.value else { return }
        guard let quotedСurrency = quotedСurrency.value else { return }
        guard let quoted = formatter.number(from: quotedСurrency) else { return }
        guard let base = formatter.number(from: baseСurrency) else { return }
        
        switch currency {
        case .base:
            completion("\(Double(truncating: base) / Double(truncating: quoted))".substring(to: 6))
        case .quoted:
            completion("\(Double(truncating: quoted) / Double(truncating: base))".substring(to: 6))
        }
    }
}
