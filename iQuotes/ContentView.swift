//
//  ContentView.swift
//  iQuotes
//
//  Created by Rezaul Islam on 1/2/25.
//

import SwiftUI

struct ContentView: View {
    let quotesProvider : QuoteProvider = QuoteProvider()
    let size = UIScreen.main.bounds.size
    var body: some View {
        VStack {
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
                        .frame( width: size.width - 84 , height: 400, alignment: .leading)
                        .padding()
                        .background(.ultraThickMaterial.opacity(0.5))
                        .cornerRadius(16)
                        .padding(.horizontal, 4)
                         
                        
                    }
                })
            })
            .padding()
            .scrollTargetLayout()
            .scrollTargetBehavior(.viewAligned)
            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            
            Spacer()
        }
        .background(
            LinearGradient(colors: [.green.opacity(0.4),  .blue.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .fontDesign(.serif)
        
    }
}

#Preview {
    ContentView()
}
