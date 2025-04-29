//
//  LottieView.swift
//  iQuotes
//
//  Created by Rezaul Islam on 4/29/25.
//

import Foundation
import SwiftUI
import Lottie


struct LottieView: UIViewRepresentable {
    typealias UIViewType = UIView
    var filename: String
    var loopMode: LottieLoopMode = .loop
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let animationView = LottieAnimationView()
        animationView.animation = LottieAnimation.named(filename)
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        animationView.play()
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // No need to update the view here
    }
}
