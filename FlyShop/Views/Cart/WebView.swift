//
//  WebView.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/16/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit
import WebKit

struct WebView: UIViewRepresentable {
    
    final class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
        var webView: WebView
        
        init(_ webView: WebView) {
            self.webView = webView
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("DID FINISH")
        }
        
        func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
            print("CONFIRM")
            print(message)
            completionHandler( true )
        }
        
        func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
            print("ALERT")
            print( message )
            completionHandler()
        }
        
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            print("POLICY")
            print(navigationResponse.response.description)
            decisionHandler( .allow )
        }
    }
    
    var url: String

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.url ) else {
            return WKWebView()
        }
        
        let request = URLRequest(url: url)
        let wkWebview = WKWebView()
        wkWebview.uiDelegate = context.coordinator
        wkWebview.navigationDelegate = context.coordinator
        wkWebview.load(request)
        return wkWebview
    }
    
    func updateUIView(_ uiView: WKWebView , context: Context) {
        
    }
}
