//
//  CentralBankService.swift
//  Сurrencies
//
//  Created by Даниил Голубятников on 18.04.2021.
//

import Foundation
import Alamofire
import SWXMLHash

protocol CentralBank {
    func currency(index: Int) -> Currency
    func currencies() -> [Currency]
    func loadCurrencies(completion: @escaping () -> Void)
    func currencyUSD() -> String?
    func currencyEUR() -> String?
}

class CentralBankService {
    // MARK: - Properties
    
    private let url = "https://www.cbr.ru/scripts/XML_daily.asp"
    private static let sharedInstance = CentralBankService()
    private var currenciesArray = [Currency]()
    static func shared() -> CentralBankService { sharedInstance }
    
    // MARK: - Functions
    
    private init() {
        
    }
}

extension CentralBankService: CentralBank {
    
    func loadCurrencies(completion: @escaping () -> ()) {
        AF.request(url, method: .get).response { response in

            switch response.result {
                case .success(let data):
                    guard let data = data else { return }
                    let xml = SWXMLHash.parse(data)
                    
                    for currency in xml["ValCurs"]["Valute"].all {
                        self.currenciesArray.append(Currency(charCode: currency["CharCode"].element?.text,
                                                        name: currency["Name"].element?.text,
                                                        value: currency["Value"].element?.text))
                    }
                    completion()
                case .failure(_):
                    print("unadable decode data")
                    return
                }
        }
    }
    
    func currencies() -> [Currency] {
        return currenciesArray
    }
    
    func currency(index: Int) -> Currency {
        return currenciesArray[index]
    }
    
    func currencyUSD() -> String? {
        currenciesArray.filter{$0.charCode == "USD"}.first?.value ?? nil
    }
    
    func currencyEUR() -> String? {
        currenciesArray.filter{$0.charCode == "EUR"}.first?.value ?? nil
    }
}
