//
//  ContentView.swift
//  iQuotes
//
//  Created by Rezaul Islam on 1/2/25.
//

import SwiftUI

struct ContentView: View {
    let quotesProvider : QuoteProvider = QuoteProvider()
    var body: some View {
        ScrollView( .horizontal, content: {
            LazyHStack(content: {
                 
                ForEach(quotesProvider.getQuotes(), id: \.self.quote){ quote in
                    VStack(spacing: 32 ){
                        Text(quote.quote ?? "")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment : .leading)
                        Text( "- \(quote.author ?? "")" )
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .multilineTextAlignment(.center)
                    .frame(width: UIScreen.main.bounds.width - 42, height: 400, alignment: .leading)
                    .padding()
                    .background(.ultraThickMaterial)
                    .cornerRadius(16)
                    .padding(.horizontal, 4)
                }
            })
        })
        .fontDesign(.serif)
         
    }
}

#Preview {
    ContentView()
}
