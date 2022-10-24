//
//  ViewController.swift
//  BtcPrice
//
//  Created by Murat on 24.10.2022.
//

import UIKit

class ViewController: UIViewController {
    

    var coinManager = CoinManager()
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        coinManager.delegate = self
        super.viewDidLoad()
    }
    
    

}

//MARK: - UIPickerViewData
extension ViewController : UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }

}

//MARK: - PickerViewDelegate
extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let currencyString = (coinManager.currencyArray[row].description)
        
        currencyLabel.text = currencyString
        
        coinManager.fetchData(with: currencyString)

    }
    
}
//MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate {
    
    func didUpdatePrice(_ coinManager: CoinManager, coinModel: CoinModel) {
        DispatchQueue.main.async {
            self.priceLabel.text = coinModel.stringPrice
        }
        
    }
    
    func didErrorWihFail(_ error: Error) {
        print(error)
    }
    
}
