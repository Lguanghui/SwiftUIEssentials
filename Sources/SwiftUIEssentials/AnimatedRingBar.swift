//
//  AnimatedRingBar.swift
//  SwiftUIEssentials
//
//  Created by 梁光辉 on 2023/12/23.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

import SwiftUI

public struct AnimatedRingBar: View {
    
    @State private var isLoading = false
    @State public var strokeColor: Color
    @State public var strokeWidth: CGFloat
    @State public var size: CGFloat
    @State private var rotationAngle: CGFloat = 0
    
    public var body: some View {
        Circle()
            .trim(from: 0, to: 0.7)
            .stroke(strokeColor, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round, lineJoin: .round))
            .frame(width: size - 20, height: size - 20)
            .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
            .animation(Animation.default.repeatForever(autoreverses: false), value: isLoading)
            .onAppear() {
                self.isLoading = true
            }
            .onDisappear() {
                self.isLoading = false
            }
    }
}

#Preview {
    LoadingButton(isLoading: .constant(true)) {
        
    } action: {
        
    }
}
