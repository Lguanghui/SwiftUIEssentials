//
//  ContentView.swift
//  SwiftUIEssentialsDemo
//
//  Created by 梁光辉 on 2024/5/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack(root: {
            List {
                NavigationLink("Dynamic Height Text") {
                    DynamicHeightTextView()
                }
            }
        })
        .padding()
    }
}

#Preview {
    ContentView()
}
