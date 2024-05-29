//
//  DynamicHeightTextView.swift
//  SwiftUIEssentialsDemo
//
//  Created by 梁光辉 on 2024/5/28.
//

import SwiftUI
import SwiftUIEssentials

fileprivate let totalText: String = "Welcome to the GitHub Privacy Statement. This is where we describe how we handle your “Personal Data”, which is information that is directly linked or can be linked to you. It applies to the Personal Data that GitHub, Inc. or GitHub B.V., processes as the “Data Controller” when you interact with websites, applications, and services that display this Statement (collectively, “Services”). This Statement does not apply to services or products that do not display this Statement, such as Previews, where relevant."

struct DynamicHeightTextView: View {
    @State var text: String = ""
    @State var timer: Timer?
    @State var count = -1
    let totalCount = totalText.count
    var body: some View {
        DynamicHeightText(minHeight: 50, maxHeight: 200, content: $text)
        .onAppear(perform: {
            Task {
                timer = Timer(timeInterval: 0.05, repeats: true, block: { timer in
                    count += 1
                    if count >= totalCount {
                        timer.invalidate()
                        return
                    }
                    let chr = Array(totalText)[count]
                    text = text + String(chr)
                })
                RunLoop.current.add(timer!, forMode: .common)
                timer?.fire()
            }
        })
        .textSelection(.enabled)
        .multilineTextAlignment(.leading)
        .frame(maxWidth: 200, alignment: .topLeading)
        .padding(.all, 4)
        .font(.system(size: 16))
        .foregroundStyle(.black)
        .clipShape(.rect(cornerRadius: 8))
        .border(.black)
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 23, trailing: 16))
    }
}

#Preview {
    DynamicHeightTextView()
}
