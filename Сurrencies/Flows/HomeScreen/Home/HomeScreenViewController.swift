//
//  HomeScreenViewController.swift
//  Сurrencies
//
//  Created by Даниил Голубятников on 18.04.2021.
//

import UIKit

class HomeScreenViewController: UIViewController, AutoLoadable, LabelHandler {

    // MARK: - IBOutlets
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var currenciesTable: UITableView!
    @IBOutlet weak var conversionView: UIView!
    
    @IBAction func conversionButton(_ sender: Any) {
        viewModel.didTapСonversionButton()
    }
    
    // MARK: - Properties
    
    var viewModel: HomeScreenViewModel!
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupShadow()
    }
    
    private func setupTable() {
        guard let viewModel = viewModel else { return }
        
        viewModel.setupLabelTime()
        viewModel.setupTable {
            self.currenciesTable.delegate = self
            self.currenciesTable.dataSource = self
            self.currenciesTable.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func updateTimeLabel(time: String) {
        self.time.text = time
    }
    
    public func setupShadow() {
        self.conversionView.layer.cornerRadius = 8
        self.conversionView.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.conversionView.layer.shadowRadius = 3
        self.conversionView.layer.shadowOpacity = 0.3
        self.conversionView.layer.shadowColor = UIColor.black.cgColor
    }
}

// MARK: - TableView DataSource, Delegate
extension HomeScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.currenciesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell",
                                                 for: indexPath) as! CurrencyTableViewCell
        cell.viewModel = viewModel?.tableCell(index: indexPath.row)
        return cell
    }
}

