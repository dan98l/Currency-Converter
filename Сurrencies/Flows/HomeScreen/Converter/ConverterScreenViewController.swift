//
//  ConverterScreenViewController.swift
//  Сurrencies
//
//  Created by Даниил Голубятников on 19.04.2021.
//

import UIKit
import Lottie

class ConverterScreenViewController: UIViewController, AutoLoadable, UITextFieldDelegate {

    // MARK: - IBOutlets
    
    @IBOutlet weak var baseСurrency: UITextField!
    @IBOutlet weak var quotedСurrency: UITextField!
    @IBOutlet weak var baseСurrencyLabel: UILabel!
    @IBOutlet weak var quotedСurrencyLabel: UILabel!
    @IBOutlet weak var lottieView: UIView!
    
    // MARK: - Properties
    
    var viewModel:  ConverterScreenViewModel!
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingAnimation()
        settingLabel()
        baseСurrency.delegate = self
        quotedСurrency.delegate = self
    }
    
    private func settingAnimation() {
        let animation = Animation.named("animation")
        let animationView = AnimationView(animation: animation)
        animationView.frame = CGRect(x: view.frame.size.width / 2 - 100, y: 0, width: 200, height: 200)
        
        lottieView.addSubview(animationView)

        animationView.loopMode = .loop
        animationView.play()
    }
    
    private func settingLabel() {
        guard let viewModel = viewModel else { return }
        baseСurrencyLabel.text = viewModel.settingLabel().baseСurrency
        quotedСurrencyLabel.text = viewModel.settingLabel().quotedСurrency
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let viewModel = viewModel else { return }
        if textField == baseСurrency {
            viewModel.didTapСonversionButton(value: textField.text!, currency: .base) {  quoted in
                self.quotedСurrency.text = quoted
            }
        } else if textField == quotedСurrency {
            viewModel.didTapСonversionButton(value: textField.text!, currency: .quoted) { base in
                self.baseСurrency.text = base
            }
        }
    }
}
