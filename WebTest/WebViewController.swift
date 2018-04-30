//
//  WebViewController.swift
//  bPlexus
//
//  Created by dhiraj.jadhao on 10/5/17.
//  Copyright © 2017 Innoplexus. All rights reserved.
//

import UIKit
import Alamofire
import WebKit

class WebViewController: UIViewController {

    //MARK: Propeties
    
    let utilities = Utilities()

    let webViewModel = WebViewModel()
    
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
    
    @IBOutlet weak var webView: UIWebView!
    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        addCookies()
        openURL()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: UI Method
    
    func setupUI() -> Void {
        
        let item = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.rightBarButtonItem = item
        
        HTTPCookieStorage.shared.cookieAcceptPolicy = .always
        
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    //MARK: Methods
    
    
    func addCookies() -> Void {
        
        
        utilities.setCookie(domain: sharedConfig.domainName, key: "iplexus2_accessToken_production", value: "Bearer \(sharedSSOManager.accessToken!)")
        
        utilities.setCookie(domain: sharedConfig.domainName, key: "iplexus2_accessToken_staging", value: "Bearer \(sharedSSOManager.accessToken!)")
        
        
        utilities.setCookie(domain: sharedConfig.domainName, key: "refreshToken", value: sharedSSOManager.refreshToken!)
        
        
        utilities.setCookie(domain: sharedConfig.domainName, key: "iplexus2_permissions_staging", value: kIPlexusPermissions.description)
        
        utilities.setCookie(domain: sharedConfig.domainName, key: "iplexus2_permissions_production", value: kIPlexusPermissions.description)
        
    }
    
    
    func openURL() -> Void {
        activityIndicator.startAnimating()
        if !webViewModel.url.isEmpty{
            let url = URL(string: webViewModel.url.replacingOccurrences(of: " ", with: "%20").folding(options: .diacriticInsensitive, locale: .current))
            if url != nil{
                webView.loadRequest(URLRequest(url: url!))
            }
           
            
        }else{
            self.navigationController?.popViewController(animated: true)
        }
        
    }

}

extension WebViewController: UIWebViewDelegate{
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        activityIndicator.stopAnimating()
    }
}
