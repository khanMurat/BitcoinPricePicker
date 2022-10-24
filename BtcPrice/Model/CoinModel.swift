//
//  CoinModel.swift
//  BtcPrice
//
//  Created by Murat on 24.10.2022.
//

import Foundation

struct CoinModel {
    let currencyPrice : Double
    
    var stringPrice: String {
        
        String(format: "%.2f", currencyPrice)
    }
}
