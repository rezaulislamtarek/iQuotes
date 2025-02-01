//
//  QuoteProvider.swift
//  iQuotes
//
//  Created by Rezaul Islam on 1/2/25.
//

import Foundation

class QuoteProvider {
    private var quotes: [Quotes]?
    
    init() {
        loadQuotes()
    }
    
    func getQuotes() -> [Quotes]{
        return quotes ?? []
    }
    
    private func loadQuotes() {
        guard let url = Bundle.main.url(forResource: "quotes", withExtension: "json") else {
            print("Quotes JSON file not found.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            self.quotes = try decoder.decode([Quotes].self, from: data)
        } catch {
            print("Failed to load quotes: \(error.localizedDescription)")
        }
    }
    
     
}
