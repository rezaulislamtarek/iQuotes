//
//  ContentView.swift
//  iQuotes
//
//  Created by Rezaul Islam on 1/2/25.
//

import SwiftUI

struct ContentView: View {
    let quotesProvider : QuoteProvider = QuoteProvider()
    @State private var currentIndex = 0
    
    
    
    var body: some View {
        
        GeometryReader{ proxy in
            let size = proxy.size
            TabView(selection: $currentIndex) {
                ForEach(Array(quotesProvider.getQuotes().enumerated()), id: \.element.author) { index, quote in
                    ZStack{
                        Color.green
                        QuoteCardView(quote: quote)
                        
                    }
                    .frame(width: size.width)
                    .tag(index)
                    .rotationEffect(.degrees(-90))
                    
                    
                }
            }
            .rotationEffect(.degrees(90))
            .frame(width: proxy.size.height, alignment: .trailing)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(maxWidth: proxy.size.width)
        }
        .ignoresSafeArea(.all, edges: .all)
        
        
        .background(
            LinearGradient(colors: [.green.opacity(0.4),  .blue.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .fontDesign(.serif)
        
    }
    
    
    
}



#Preview {
    ContentView()
}

struct QuoteCardView: View {
    let quote : Quotes
    let size = UIScreen.main.bounds.size
    var body: some View {
        
        VStack(spacing: 32 ){
            Text(quote.quote ?? "")
                .font(.title2)
                .frame(maxWidth: .infinity, alignment : .center)
            Text( "- \(quote.author ?? "")" )
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .multilineTextAlignment(.center)
        .padding()
        .frame(width: size.width, height: size.height)
        .background(.ultraThickMaterial.opacity(0.5))
        .background(.pink)
        .ignoresSafeArea(.all)
        
        
        
        
    }
}

struct HomeToolBarView: View {
    var body: some View {
        VStack{
            Text("iQuotes")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .foregroundColor(.primary)
            Text("Inspire, Create, Share.")
                .font(.callout)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .foregroundColor(.primary)
        }.padding()
        
    }
}
