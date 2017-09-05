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

        // Delegates how web pages are handled
        webView.uiDelegate = self
        
        // Sets the view to display the web view
        view.addSubview(webView)
        
        // Used to assign constraints for the webview
        let webTopAnchor = webView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 40)
        let webLeadingAnchor = webView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let webTrailingAnchor = webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let webBottomAnchor = webView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: 0)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        // Activates constraints
        webTopAnchor.isActive = true
        webLeadingAnchor.isActive = true
        webTrailingAnchor.isActive = true
        webBottomAnchor.isActive = true
        
    }
    
    func setUpAddrBar() {
        // Addr bar setup includes creating the text field, sizing it and adding it to the view
        urlBar = UITextField()
        urlBar.frame = CGRect(x: 0, y: 0, width: 0, height: 30)
        urlBar.backgroundColor = UIColor.white
        urlBar.borderStyle = UITextBorderStyle.roundedRect
        view.addSubview(urlBar)
        
        // Used to assign constraints for the text field
        let margins = view.layoutMarginsGuide
        let urlBarTopConstraint = urlBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 5)
        let urlBarLeadingConstraint = urlBar.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 0)
        let urlBarTrailingConstraint = urlBar.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 0)
        urlBar.translatesAutoresizingMaskIntoConstraints = false
        
        // Activates constraints
        urlBarTopConstraint.isActive = true
        urlBarLeadingConstraint.isActive = true
        urlBarTrailingConstraint.isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Gives a nice backgrounnd color behind the address bar instead of white
        view.backgroundColor = UIColor.init(red: 0.92, green: 0.92, blue: 0.92, alpha: 1)
        
        // Sets up our view
        setUpWebView()
        setUpAddrBar()
        
        // Sets a URL to be loaded when the webpage opens
        let urlString = "https://www.apple.com"
        urlBar.text = urlString
        let myURL = URL(string: urlString)
        
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
