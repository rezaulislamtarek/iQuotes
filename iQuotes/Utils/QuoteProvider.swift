//
//  QuoteProvider.swift
//  iQuotes
//
//  Created by Rezaul Islam on 1/2/25.
//

import Foundation

class QuoteProvider {
    private var quotesResponse : QuoteResponse?
    
    init() {
        loadQuotes()
    }
    
    func getQuotes() -> [Quotes]{
        return quotesResponse?.data ?? []
    }
    
    private func loadQuotes() {
        guard let url = Bundle.main.url(forResource: "quotes", withExtension: "json") else {
            print("Quotes JSON file not found.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            self.quotesResponse = try decoder.decode(QuoteResponse.self, from: data)
        } catch {
            print("Failed to load quotes: \(error.localizedDescription)")
        }
    }
    
     
}
