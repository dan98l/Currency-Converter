//
//  CurrencyTableViewCellModel.swift
//  Сurrencies
//
//  Created by Даниил Голубятников on 18.04.2021.
//

import Foundation

class CurrencyTableViewCellModel {
    
    // MARK: - Properties
        
    var name: String
    var charCode: String
    var value: String
    
    // MARK: - Functions
    
    init() {
        self.name = ""
        self.charCode = ""
        self.value = ""
    }
    
    init(name: String, charCode: String, value: String) {
        self.name = name
        self.charCode = charCode
        self.value = value
    }
}
