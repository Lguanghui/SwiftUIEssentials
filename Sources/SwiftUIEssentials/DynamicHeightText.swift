//
//  DynamicHeightText.swift
//  SwiftUIEssentials
//
//  Created by 梁光辉 on 2024/5/27.
//

import SwiftUI

@available(macOS 14.0, *)
@available(iOS 17.0, *)
public struct DynamicHeightText: View {
    @State var contentHeight: CGFloat
    @State var minHeight: CGFloat
    @State var maxHeight: CGFloat
    @Binding var content: String
    
    public init(minHeight: CGFloat, maxHeight: CGFloat, content: Binding<String>) {
        self.contentHeight = minHeight
        self.minHeight = minHeight
        self.maxHeight = maxHeight
        self._content = content
    }
    
    public var body: some View {
        ScrollView {
            Text(content)
                .lineLimit(nil)
                .background {
                    GeometryReader(content: { geometry in
                        Color.clear.onChange(of: content) { oldValue, newValue in
                            let geoHeight = geometry.size.height
                            contentHeight = min(maxHeight, max(minHeight, geoHeight))
                        }
                    })
                }
        }
        .frame(height: contentHeight)
    }
}

#Preview {
    if #available(macOS 14.0, iOS 17.0, *) {
        DynamicHeightText(minHeight: 50, maxHeight: 100, content: .constant("hello"))
    } else {
        // Fallback on earlier versions
        EmptyView()
    }
}
