//
//  Quotes.swift
//  iQuotes
//
//  Created by Rezaul Islam on 1/2/25.
//

import Foundation

struct Quotes : Codable, Identifiable {
    var id = UUID().uuidString
    let quote : String
    let author : String
    let category : String
}
