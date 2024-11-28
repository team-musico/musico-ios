//
//  SwiftUIView.swift
//  Musico
//
//  Created by dgsw07 on 11/28/24.
//


import WebKit
import SwiftUI

struct VideoPlayerView: View {
    var videoId: String
    
    var body: some View {
        WebView(url: URL(string: "https://www.youtube.com/watch?v=\(videoId)")!)
            .edgesIgnoringSafeArea(.all)
    }
}

struct WebView: UIViewRepresentable {
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
