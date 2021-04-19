//
//  СurrencySelectionScreenViewModel.swift
//  Сurrencies
//
//  Created by Даниил Голубятников on 19.04.2021.
//

import UIKit

class СurrencySelectionScreenViewController: UIViewController, AutoLoadable {

    // MARK: - IBOutlets
    
    @IBOutlet weak var baseСurrency: UIPickerView!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var warningImage: UIImageView!
    
    @IBAction func conversionButton(_ sender: Any) {
        if viewModel.conversion() {
            viewModel.didTapСonversionButton()
        } else {
            warningImage.isHidden = false
            warningLabel.isHidden = false
        }
    }
    
    // MARK: - Properties
    
    var viewModel:  СurrencySelectionScreenViewModel!
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - PickerView DataSource, Delegate
extension СurrencySelectionScreenViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.currenciesCount()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let viewModel = viewModel else { return nil}
        return viewModel.componentString(index: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let viewModel = viewModel else { return }
        viewModel.didSelectCurrency(row: row, component: component)
    }
}
