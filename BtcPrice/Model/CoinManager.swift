//
//  CoinManager.swift
//  BtcPrice
//
//  Created by Murat on 24.10.2022.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdatePrice(_ coinManager:CoinManager, coinModel: CoinModel)
    func didErrorWihFail(_ error:Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "400594B8-422D-4A9A-A7FE-078596BDFA24"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    
    func fetchData(with currency:String){
        
        let stringURL = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: stringURL)
    }
    
    func performRequest(with stringURL:String){
        
        if let url = URL(string: stringURL){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let coinM = parseJSON(with: safeData){
                        self.delegate?.didUpdatePrice(self, coinModel: coinM)
                    }
                }
            }
            
            task.resume()
        }
        
    }
    
    func parseJSON(with coinData:Data) -> CoinModel? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let price = decodedData.rate
            let model = CoinModel(currencyPrice: price)
            return model
        }
        catch {
            delegate?.didErrorWihFail(error)
            return nil
        }
    }
    
    
}
