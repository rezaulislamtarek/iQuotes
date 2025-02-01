//
//  ContentView.swift
//  iQuotes
//
//  Created by Rezaul Islam on 1/2/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView(content: {
            HStack(content: {
                ForEach(0..<10){ i in
                        Text("5")
                }
            })
        })
    }
}

#Preview {
    ContentView()
}
