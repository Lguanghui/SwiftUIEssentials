//
//  AnimatedRingBar.swift
//  SwiftUIEssentials
//
//  Created by 梁光辉 on 2023/12/23.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

import SwiftUI

public struct AnimatedRingBar: View {
    
    @State private var isAnimating = false
    @State public var strokeColor: Color
    @State public var strokeWidth: CGFloat
    @State public var size: CGFloat
    @State private var rotationAngle: CGFloat = 0
    
    public init(strokeColor: Color, strokeWidth: CGFloat, size: CGFloat, rotationAngle: CGFloat = 0) {
        self.strokeColor = strokeColor
        self.strokeWidth = strokeWidth
        self.size = size
        self.rotationAngle = rotationAngle
    }
    
    public var body: some View {
        Circle()
            .trim(from: 0, to: 0.7)
            .stroke(strokeColor, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round, lineJoin: .round))
            .frame(width: size - 20, height: size - 20)
            .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
            .animation(isAnimating ? Animation.linear.repeatForever(autoreverses: false).speed(0.75) : .default, value: isAnimating)
            .onAppear() {
                self.isAnimating = true
            }
            .onDisappear() {
                self.isAnimating = false
            }
    }
}

#Preview {
    LoadingButton(enabled: .constant(true), isLoading: .constant(true)) {
        
    } action: {
        
    }
}

#Preview {
    AnimatedRingBar(strokeColor: .appleBlue, strokeWidth: 8, size: 60)
}
