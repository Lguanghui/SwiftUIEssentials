//
//  FloatingPanel.swift
//  SwiftUIEssentials
//
//  Created by 梁光辉 on 2024/6/1.
//  Copyright © 2024 Guanghui Liang. All rights reserved.
//
//  https://cindori.com/developer/floating-panel

import SwiftUI
import SwiftUIFoundation

public class FloatingPanel<Content: View>: NSPanel {
    @Binding var isPresented: Bool
    
    public init(view: () -> Content,
             contentRect: NSRect,
             backing: NSWindow.BackingStoreType = .buffered,
             defer flag: Bool = false,
             isPresented: Binding<Bool>) {
        /// Initialize the binding variable by assigning the whole value via an underscore
        self._isPresented = isPresented
     
        /// Init the window as usual
        super.init(contentRect: contentRect,
                    styleMask: [.nonactivatingPanel, .titled, .resizable, .closable, .fullSizeContentView],
                    backing: backing,
                    defer: flag)
        /// Allow the panel to be on top of other windows
        isFloatingPanel = true
        level = .floating
     
        /// Allow the pannel to be overlaid in a fullscreen space
        collectionBehavior.insert(.fullScreenAuxiliary)
     
        /// Don't show a window title, even if it's set
        titleVisibility = .hidden
        titlebarAppearsTransparent = true
     
        /// Since there is no title bar make the window moveable by dragging on the background
        isMovableByWindowBackground = true
     
        /// Hide when unfocused
        hidesOnDeactivate = true
     
        /// Hide all traffic light buttons
        standardWindowButton(.closeButton)?.isHidden = true
        standardWindowButton(.miniaturizeButton)?.isHidden = true
        standardWindowButton(.zoomButton)?.isHidden = true
     
        /// Sets animations accordingly
        animationBehavior = .utilityWindow
     
        /// Set the content view.
        /// The safe area is ignored because the title bar still interferes with the geometry
//        contentView = NSHostingView(rootView: view()
//            .ignoresSafeArea()
//            .environment(\.floatingPanel, self))
        contentView = NSHostingViewZeroSafeArea(rootView: view()
            .ignoresSafeArea()
            .environment(\.floatingPanel, self)
        )
    }
    
    /// Close automatically when out of focus, e.g. outside click
    public override func resignMain() {
        super.resignMain()
        close()
    }
     
    /// Close and toggle presentation, so that it matches the current state of the panel
    public override func close() {
        super.close()
        isPresented = false
    }
     
    /// `canBecomeKey` and `canBecomeMain` are both required so that text inputs inside the panel can receive focus
    public override var canBecomeKey: Bool {
        return true
    }
     
    public override var canBecomeMain: Bool {
        return true
    }
    
    
}

private struct FloatingPanelKey: EnvironmentKey {
    static let defaultValue: NSPanel? = nil
}
 
public extension EnvironmentValues {
    var floatingPanel: NSPanel? {
        get { self[FloatingPanelKey.self] }
        set { self[FloatingPanelKey.self] = newValue }
    }
}

#Preview {
    Text("Hello")
        .floatingPanel(isPresented: .constant(true)) {
            Text("Hello")
        }
}
