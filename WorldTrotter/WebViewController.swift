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
    
    override func loadView() {
        
        // Configurations to initialize web view
        let webConfiguration = WKWebViewConfiguration()
        
        // Sets up our web view
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        // Delegates how web pages are handled
        webView.uiDelegate = self
        
        // Sets the view to display the web view
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets a URL to be loaded when the webpage opens
        let myURL = URL(string: "http://www.jokersupdates.com")
        
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
