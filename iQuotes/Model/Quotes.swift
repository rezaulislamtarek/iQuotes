//
//  Quotes.swift
//  iQuotes
//
//  Created by Rezaul Islam on 1/2/25.
//

import Foundation

struct QuoteResponse : Codable {
    let data : [Quotes]?
}

struct Quotes : Codable {
    let quote : String?
    let author : String?
    let category : String?
}
/*
"quote": "The way to get started is to quit talking and begin doing.",
"author": "Walt Disney",
"category": "Motivation & Success"
*/
