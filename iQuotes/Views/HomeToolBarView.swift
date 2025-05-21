//
//  HomeToolBarView.swift
//  iQuotes
//
//  Created by Rezaul Islam on 5/21/25.
//

import SwiftUI

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

#Preview {
    HomeToolBarView()
}
