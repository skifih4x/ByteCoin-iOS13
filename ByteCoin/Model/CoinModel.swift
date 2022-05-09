//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Артем Орлов on 09.05.2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let currency: String
    let rateModel: Double
    
    var rateString: String {
        String(format: "%.5f", rateModel)
    }
}
