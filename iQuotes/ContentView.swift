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
    @State private var tapCount = 0 // Count the number of taps
    @State private var tapTimer: Timer? = nil // Timer to track the delay for tap recognition
    @State private var showLikeAnimation = false
    
    var body: some View{
        GeometryReader{ proxy in
            let size = proxy.size
            
            TabView(selection: $currentIndex){
                
                ForEach(Array(quotesProvider.getQuotes().enumerated()), id: \.element.quote) { index, post in
                    
                    ZStack{
                        QuoteCardView(quote: post, size : proxy.size)
                            .frame(width: size.width)
                    }
                    .rotationEffect(Angle(degrees: -90))
                    .ignoresSafeArea(.all, edges: .all)
                    .tag(index)
                    .onTapGesture(count: 1) {
                        handleTap()
                    }
                }
            }
            .rotationEffect(Angle(degrees: 90))
            .frame(width: proxy.size.height)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(maxWidth: proxy.size.width)
            .overlay {
                LottieView(filename: "love_lottie")
                    .opacity(showLikeAnimation == true ? 1 : 0)
            }
        }
        .ignoresSafeArea(.all, edges: .all)
        .overlay (alignment: .top){
            HomeToolBarView()
        }
        
    }
    
    func handleTap() {
        tapCount += 1
        
        // Invalidate existing timer to reset the delay for detecting taps
        tapTimer?.invalidate()
        
        // Set a new timer for tap detection
        tapTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
            // Handle single tap action
            if self.tapCount == 1 {
                
            }
            
            // Reset tap count after the action
            self.tapCount = 0
        }
        
        // Handle double tap or more taps
        if tapCount == 2 {
            showLikeAnimation = true // Show like animation for double taps
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showLikeAnimation = false // Hide like animation after 1 second
            }
        } else if tapCount > 2 {
            showLikeAnimation = true // Show animation for additional taps
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showLikeAnimation = false // Hide like animation after 1 second
            }
        }
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
                .frame(maxWidth: .infinity, alignment : .center)
                .padding()
            
            Text( "- \(quote.author ?? "")" )
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .fontDesign(.serif)
        
        .foregroundStyle(.iqTextc)
        .multilineTextAlignment(.center)
        .padding()
        .padding(.vertical, 80)
        .background(.ultraThickMaterial)
        //.background(.ultraThickMaterial.opacity(0.5))
        .cornerRadius(20)
        .padding()
        .frame(width: size.width, height: size.height)
        .background(.iqBgc)
         
        
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
