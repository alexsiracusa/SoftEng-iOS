//
//  UIScrollViewWrapper.swift
//  lingq-5
//
//  Created by Timothy Costa on 2019/07/05.
//  Copyright © 2019 timothycosta.com. All rights reserved.
//

import SwiftUI

struct ZoomableScrollView<Content: View>: UIViewRepresentable {
    private var content: Content
    @Binding var zoom: CGFloat
    
    init(zoom: Binding<CGFloat>, @ViewBuilder content: () -> Content) {
        self.content = content()
        _zoom = zoom
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        // set up the UIScrollView
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator  // for viewForZooming(in:)
        scrollView.maximumZoomScale = 12
        scrollView.minimumZoomScale = 1
        scrollView.bouncesZoom = true
        
        // create a UIHostingController to hold our SwiftUI content
        let hostedView = context.coordinator.hostingController.view!
        hostedView.translatesAutoresizingMaskIntoConstraints = true
        hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostedView.frame = scrollView.bounds
        scrollView.addSubview(hostedView)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(zoom: $zoom, hostingController: UIHostingController(rootView: self.content))
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // update the hosting controller's SwiftUI content
        context.coordinator.hostingController.rootView = self.content
        assert(context.coordinator.hostingController.view.superview == uiView)
    }
    
    // MARK: - Coordinator
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var hostingController: UIHostingController<Content>
        @Binding var zoom: CGFloat
        
        init(zoom: Binding<CGFloat>, hostingController: UIHostingController<Content>) {
            _zoom = zoom
            self.hostingController = hostingController
        }
        
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return hostingController.view
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            self.zoom = scrollView.zoomScale
        }
    }
}
