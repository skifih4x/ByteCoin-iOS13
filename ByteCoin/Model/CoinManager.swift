//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoin (_ coinManager: CoinManager, _ coin: CoinModel)
    func didFailWitchError(error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "EF78EE88-8D54-4F0C-B9B2-1730C5BBAB88"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)\(currency)?apikey=\(apiKey)"
        performRequest(urlString: urlString)
    }
    
    func performRequest (urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWitchError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let coin = self.parseJSON(coinData: safeData) {
                        delegate?.didUpdateCoin(self, coin)
                        
                    }
                    
                    
                }
            }
            task.resume()
        }
    }
    
    func parseJSON (coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let rate = decodedData.rate
            let currency = decodedData.asset_id_quote
            
            let coin = CoinModel(currency: currency, rateModel: rate)
            return coin
        } catch {
            delegate?.didFailWitchError(error: error)
            return nil
        }
    }
}
