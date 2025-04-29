//
//  ContentView.swift
//  iQuotes
//
//  Created by Rezaul Islam on 1/2/25.
//

import SwiftUI

struct ContentView: View {
    let quotesProvider: QuoteProvider = QuoteProvider()
    @State private var currentIndex = 0
    private let gradient =  [Color.black.opacity(0.7), .clear,.clear,.clear,.clear, Color.black.opacity(0.2)]
    
    var body: some View{
        GeometryReader{ proxy in
            let size = proxy.size
            
            TabView(selection: $currentIndex){
                
                ForEach(Array(quotesProvider.getQuotes().enumerated()), id: \.element.quote) { index, post in
                    
                    
                    ZStack{
                        
                        ZStack{
                            // if !showComment{
                            Text("")
                            .compositingGroup()
                            // .ignoresSafeArea() // Ensure video covers the screen
                            .aspectRatio(contentMode: .fit) // Ensure the video fills the space
                            
                            //}
                            
                           
                            
                        }
                        .overlay {
                            LinearGradient(colors: gradient, startPoint: .top, endPoint: .bottom)
                        }
                        
                        
                        ZStack{
                            QuoteCardView(quote: post, size : proxy.size)
                        }
                        
                        .frame(width: size.width)
                    }
                    .rotationEffect(Angle(degrees: -90))
                    .ignoresSafeArea(.all, edges: .all)
                    .tag(index)
                    .onTapGesture(count: 1) {
                         
                    }
                     
                    
                    
                }
            }
            .rotationEffect(Angle(degrees: 90))
            .frame(width: proxy.size.height)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(maxWidth: proxy.size.width)
        }
        
        .background(.green)
        .ignoresSafeArea(.all, edges: .all)
    
    }
}
 

#Preview {
    ContentView()
}

struct QuoteCardView: View {
    let quote : Quotes
    let size : CGSize
    var body: some View {
        
        VStack(spacing: 32 ){
            Text(quote.quote ?? "")
                .font(.title2)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment : .center)
                .padding()
            
            Text( "- \(quote.author ?? "")" )
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .multilineTextAlignment(.center)
        .frame(width: size.width, height: size.height)
        .background(.ultraThickMaterial.opacity(0.5))
       
         
        .background(
                    LinearGradient(colors: [.green.opacity(0.4),  .blue.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
        
        
        
        
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
