//
//  CurrencyTableViewCell.swift
//  Сurrencies
//
//  Created by Даниил Голубятников on 18.04.2021.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var charCode: UILabel!
    @IBOutlet weak var stackLabel: UIStackView!
    
    // MARK: - Properties
    
    var viewModel: CurrencyTableViewCellModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            self.name.text = viewModel.name
            self.value.text = viewModel.value
            self.charCode.text = viewModel.charCode
            
            self.setupShadow()
        }
    }
    
    // MARK: - Functions
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    public func setupShadow() {
        self.stackLabel.layer.cornerRadius = 8
        self.stackLabel.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.stackLabel.layer.shadowRadius = 3
        self.stackLabel.layer.shadowOpacity = 0.3
        self.stackLabel.layer.shadowColor = UIColor.black.cgColor
    }
}
