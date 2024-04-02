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
    @Binding var offset: CGPoint
    @Binding var origin: CGPoint
    
    init(zoom: Binding<CGFloat>, offset: Binding<CGPoint>, origin: Binding<CGPoint>, @ViewBuilder content: () -> Content) {
        self.content = content()
        _zoom = zoom
        _offset = offset
        _origin = origin
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        // set up the UIScrollView
        let config = Config(minZoom: 1, maxZoom: 12)
        let hostingController = context.coordinator.hostingController
        let scrollView = ZoomableView(
            hostingController: hostingController,
            index: 0, data: "",
            config: config,
            origin: $origin
        )
        
        //let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator  // for viewForZooming(in:)
        //scrollView.maximumZoomScale = 12
        //scrollView.minimumZoomScale = 1
        //scrollView.bouncesZoom = true
        
        // create a UIHostingController to hold our SwiftUI content
        let hostedView = context.coordinator.hostingController.view!
        hostedView.translatesAutoresizingMaskIntoConstraints = true
        hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostedView.frame = scrollView.bounds
        scrollView.addSubview(hostedView)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        // hide de-sync
        scrollView.bouncesZoom = false
        scrollView.bouncesVertically = false
        scrollView.bouncesHorizontally = false
        scrollView.bounces = false
        
        return scrollView
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(zoom: $zoom, 
                           offset: $offset,
                           origin: $origin,
                           hostingController: UIHostingController(rootView: self.content))
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // update the hosting controller's SwiftUI content
        context.coordinator.hostingController.rootView = self.content
        assert(context.coordinator.hostingController.view.superview == uiView)
    }
    
    typealias UIViewControllerType = Coordinator
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        return Coordinator(zoom: $zoom,
                           offset: $offset,
                           origin: $origin,
                           hostingController: UIHostingController(rootView: self.content))
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    // MARK: - Coordinator
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var hostingController: UIHostingController<Content>
        @Binding var zoom: CGFloat
        @Binding var offset: CGPoint
        @Binding var origin: CGPoint
        
        init(zoom: Binding<CGFloat>, 
             offset: Binding<CGPoint>,
             origin: Binding<CGPoint>,
             hostingController: UIHostingController<Content>)
        {
            _zoom = zoom
            _offset = offset
            _origin = origin
            self.hostingController = hostingController
        }
        
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return hostingController.view
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            self.zoom = scrollView.zoomScale
            self.offset = scrollView.contentOffset
            if !hostingController.view.subviews.isEmpty {
                self.origin = hostingController.view.subviews[0].convert(CGPointZero, to: scrollView.coordinateSpace)
            }
        }
    }
}
