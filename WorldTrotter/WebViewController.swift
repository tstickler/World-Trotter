//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Tyler Stickler on 8/31/17.
//  Copyright © 2017 tstick. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    // Creates our web view
    var webView: WKWebView!
    var urlBar: UITextField!
    
    func setUpWebView() {
        // Configurations to initialize web view
        let webConfiguration = WKWebViewConfiguration()
        
        // Sets up our web view
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.frame = CGRect(origin: CGPoint.init(x: 0, y: 60), size: view.frame.size)

        // Delegates how web pages are handled
        webView.uiDelegate = self
        
        // Sets the view to display the web view
        view.addSubview(webView)

        
        urlBar = UITextField()
        urlBar.frame = CGRect(x: 0, y: 20, width: 300, height: 40)
        view.addSubview(urlBar)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpWebView()
        
        // Sets a URL to be loaded when the webpage opens
        let myURL = URL(string: "https://www.apple.com")
        
        /***********************************************************************************
        * To allow the web view to access non https websites, add this to apps info.plist: *
        * <key>NSAppTransportSecurity</key>                                                *
        * <dict>                                                                           *
        *   <key>NSAllowsArbitraryLoadsInWebContent</key>                                  *
        *       <true/>                                                                    *
        * </dict>                                                                          *
        ***********************************************************************************/
        
        // Loads the requested URL
        webView.load(URLRequest(url: myURL!))
        
    }
}
