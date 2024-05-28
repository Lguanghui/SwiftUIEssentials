//
//  DynamicHeightTextView.swift
//  SwiftUIEssentialsDemo
//
//  Created by 梁光辉 on 2024/5/28.
//

import SwiftUI
import SwiftUIEssentials

struct DynamicHeightTextView: View {
    @State var text: String = ""
    @State var timer: Timer?
    @State var count = 0
    var body: some View {
        DynamicHeightText(minHeight: 50, maxHeight: 200, content: $text)
        .onAppear(perform: {
            Task {
                timer = Timer(timeInterval: 0.5, repeats: true, block: { timer in
                    count += 1
                    text = text + "\(count)"
                })
                RunLoop.current.add(timer!, forMode: .common)
                timer?.fire()
            }
        })
        .textSelection(.enabled)
        .multilineTextAlignment(.leading)
        .frame(maxWidth: 50, alignment: .topLeading)
        .padding(.all, 4)
        .font(.system(size: 16))
        .foregroundStyle(.red)
        .background(.gray)
        .clipShape(.rect(cornerRadius: 8))
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 23, trailing: 16))
    }
}

#Preview {
    DynamicHeightTextView()
}
