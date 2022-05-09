//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var coinManager = CoinManager()
    
    
    @IBOutlet var bitcoinLabel: UILabel!
    @IBOutlet var currencyLabel: UILabel!
    
    @IBOutlet var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self

    }

}

//MARK: - pickerView

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
func numberOfComponents(in pickerView: UIPickerView) -> Int {
    1
}

func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    coinManager.currencyArray.count
}
func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    coinManager.currencyArray[row]
}
func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let arrayCoin = coinManager.currencyArray[row]
    coinManager.getCoinPrice(for: arrayCoin)
    
}
}
//MARK: - didUpdateCoin

extension ViewController: CoinManagerDelegate {
    
    func didUpdateCoin(_ coinManager: CoinManager, _ coin: CoinModel) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = coin.rateString
            self.currencyLabel.text = coin.currency
        }
    }
    
    func didFailWitchError(error: Error) {
        print(error)
    }
    
    
}

