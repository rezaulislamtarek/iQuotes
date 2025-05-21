//
//  QuoteCardView.swift
//  iQuotes
//
//  Created by Rezaul Islam on 5/21/25.
//

import SwiftUI

struct QuoteCardView: View {
    let quote : Quotes
    var body: some View {
        
        VStack(spacing: 32 ){
            Text(quote.quote ?? "")
                .font(.title2)
                .frame(maxWidth: .infinity, alignment : .center)
                .padding()
            
            Text( "- \(quote.author ?? "")" )
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .foregroundStyle(.iqTextc)
        .multilineTextAlignment(.center)
        .padding()
        .padding(.vertical, 80)
        .background(.ultraThickMaterial)
        .cornerRadius(20)
        .padding()
    }
}


#Preview {
    QuoteCardView(quote: QuoteProvider().getQuotes().first!)
}
