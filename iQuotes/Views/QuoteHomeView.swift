//
//  ContentView.swift
//  iQuotes
//
//  Created by Rezaul Islam on 1/2/25.
//

import SwiftUI

struct QuoteHomeView: View {
    @State private var speakWorkItem: DispatchWorkItem?
    let quotesProvider: QuoteProvider = QuoteProvider()
    @State private var currentIndex = 0
    @State private var tapCount = 0 // Count the number of taps
    @State private var tapTimer: Timer? = nil // Timer to track the delay for tap recognition
    @State private var showLikeAnimation = false
    @State private var isMoving = false
    @State private var disableSwipeView = false
    
    var body: some View{
        GeometryReader{ proxy in
            let size = proxy.size
            
            let height = size.height
            let width = size.width
            
            TabView(selection: $currentIndex){
                ForEach(Array(quotesProvider.getQuotes().enumerated()), id: \.element.quote) { index, post in
                    QuoteCardView(quote: post)
                        .frame(width: width)
                        .rotationEffect(Angle(degrees: -90))
                        .tag(index)
                        .onTapGesture(count: 1) {
                            handleTap()
                        }
                }
            }
            .rotationEffect(Angle(degrees: 90))
            .frame(width: height)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: width)
            .overlay {
                LottieView(filename: "love_lottie")
                    .opacity(showLikeAnimation == true ? 1 : 0)
            }
            .overlay(alignment: .bottom) {
                VStack{
                    Image(systemName: "arrow.up")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24 )
                        .padding(16)
                        .offset(y: isMoving ? 20 : 0)
                        .animation(Animation.easeInOut(duration: 1.0)
                            .repeatForever(autoreverses: true),
                                   value: isMoving
                        )
                    Text("Swap up to read more quotes")
                }
                .onChange(of: currentIndex, { oldValue, newValue in
                    withAnimation(.easeInOut(duration: 0.8)) {
                        disableSwipeView = currentIndex >= 2
                    }
                })
                .padding(.bottom, 32)
                .onTapGesture {
                    withAnimation {
                        currentIndex += 1
                    }
                }
                .opacity(disableSwipeView ? 0 : 1 )
            }
        }
        .onChange(of: currentIndex) { newValue in
            print("Current Index: \(newValue)")
            speakWorkItem?.cancel()
            
            let newWorkItem = DispatchWorkItem {
                quotesProvider.getQuotes()[newValue].quote?.speak()
            }
            speakWorkItem = newWorkItem
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute : newWorkItem)
        }
        
        .overlay (alignment: .top){
            HomeToolBarView()
        }
        .fontDesign(.serif)
        .onAppear {
            // Start the animation when view appears
            isMoving = true
        }
    }
    
}

extension QuoteHomeView {
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
    QuoteHomeView()
}

