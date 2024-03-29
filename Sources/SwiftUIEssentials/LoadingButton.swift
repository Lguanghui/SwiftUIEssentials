//
//  LoadingButton.swift
//  SwiftUIEssentials
//
//  Created by 梁光辉 on 2023/12/23.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

import SwiftUI

public struct LoadingButtonConfig {
    public init(width: CGFloat = 312,
                height: CGFloat = 54,
                cornerRadius: CGFloat = 0,
                backgroundColor: Color = .blue,
                loadingBackgroundColor: Color? = nil,
                strokeWidth: CGFloat = 5,
                strokeColor: Color = .gray.opacity(0.6)) {
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.loadingBackgroundColor = loadingBackgroundColor ?? self.backgroundColor.opacity(0.6)
        self.strokeWidth = strokeWidth
        self.strokeColor = strokeColor
    }
    
    /// Width of the button
    public let width: CGFloat
    /// Height of the button
    public let height: CGFloat
    /// Corner radius of the button
    public let cornerRadius: CGFloat
    /// Background color of  the button
    public let backgroundColor: Color
    /// Background color of the button when loading
    public let loadingBackgroundColor: Color
    /// Width of circle loading bar stroke
    public let strokeWidth: CGFloat
    /// Color of circle loading bar stroke
    public let strokeColor: Color
}

public struct LoadingButton<Content: View>: View {
    
    let config: LoadingButtonConfig
    
    @Binding var isLoading: Bool
    
    @Binding private var enabled: Bool
    
    let content: Content
    
    var action: (() -> Void)?
    
    public init(config: LoadingButtonConfig = LoadingButtonConfig(), enabled: Binding<Bool>, isLoading: Binding<Bool>, @ViewBuilder content: () -> Content, action: (() -> Void)? = nil) {
        self.content = content()
        self._isLoading = isLoading
        self.action = action
        self.config = config
        _enabled = enabled
    }
    
    public var body: some View {
        Button(action: {
                if !isLoading {
                    if let action {
                        action()
                    }
                }
                    isLoading = true
                }) {
                    ZStack {
                        Rectangle()
                            .fill(isLoading ? config.loadingBackgroundColor : config.backgroundColor)
                            .frame(width: isLoading ? config.height : config.width, height: config.height)
                            .cornerRadius(isLoading ? config.height / 2 : config.cornerRadius)

                        if isLoading {
                            AnimatedRingBar(strokeColor: config.strokeColor, strokeWidth: config.strokeWidth, size: config.height)
                        }
                        else {
                            VStack { content }
                        }
                    }
                }
                .frame(width: config.width, height: config.height)
                .disabled(isLoading || enabled == false)
                .animation(.easeInOut, value: isLoading)
                .buttonStyle(.plain)
    }
}

#Preview {
    LoadingButton(config: LoadingButtonConfig(width: 200, height: 60), enabled: .constant(true), isLoading: .constant(true)) {
        
    } action: {
        
    }
}
