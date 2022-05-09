//
//  CoinData.swift
//  ByteCoin
//
//  Created by Артем Орлов on 09.05.2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Codable {
    let asset_id_quote: String
    let rate: Double
}
