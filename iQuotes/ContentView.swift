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
        VStack {
            Spacer()
            ScrollView( .horizontal, showsIndicators: false, content: {
                LazyHStack(content: {
                    
                    ForEach(quotesProvider.getQuotes(), id: \.self.quote){ quote in
                        VStack(spacing: 32 ){
                            Text(quote.quote ?? "")
                                .font(.title2)
                                .frame(maxWidth: .infinity, alignment : .center)
                            Text( "- \(quote.author ?? "")" )
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .multilineTextAlignment(.center)
                        .frame(width: UIScreen.main.bounds.width - 42, height: 400, alignment: .leading)
                        .padding()
                        .background(.ultraThickMaterial)
                        .cornerRadius(16)
                        .padding(.horizontal, 4)
                        .onAppear{
                            print("iQuote App : \(quote.author)")
                        }
                        .onDisappear{
                            print("iQuote DisApp : \(quote.author)")
                        }
                        
                    }
                })
            })
            .fontDesign(.serif)
            .scrollTargetLayout()
            .scrollTargetBehavior(.viewAligned)
            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            
            Spacer()
        }
        .background(
            LinearGradient(colors: [.green,.blue], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        
    }
}

#Preview {
    ContentView()
}
