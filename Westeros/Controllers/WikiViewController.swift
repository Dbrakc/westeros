//
//  WikiViewController.swift
//  Westeros
//
//  Created by David Braga  on 17/9/18.
//  Copyright © 2018 David Braga . All rights reserved.
//

import UIKit
import WebKit

class WikiViewController: UIViewController {

    // MARK: - Views
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    // MARK: - Model
    var model: House
    var lastHouseDetailViewController : HouseDetailViewController?
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(model: House) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle (for: type(of: self)))
        title = model.name;
    }
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(houseDidChange), name: .houseDidChangeNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        syncModelWithView()
    }
    
    
    //Mark: Notifications
    
    @objc func houseDidChange(notification: Notification){
        guard let info = notification.userInfo,
            let house : House = info[Constants.houseKey] as? House else {return}
        self.model = house
        lastHouseDetailViewController = HouseDetailViewController(model: house)
        self.title = house.name
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: house.name, style: .plain, target: self, action: #selector(backButtonPress))
        syncModelWithView()
        
    }
    
    @objc func backButtonPress (){
        guard let viewController = lastHouseDetailViewController else{
            return
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Sync
    func syncModelWithView(){
        let request : URLRequest = URLRequest(url: model.wikiUrl)
        loadingView.startAnimating();
        webView.load(request)
    }
    

  
}

// MARK: - Navigation Extension

extension WikiViewController: WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingView.stopAnimating()
        loadingView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let type = navigationAction.navigationType
        switch type {
        case .linkActivated, .formResubmitted, .formSubmitted:
            decisionHandler(.cancel)
        default:
            decisionHandler(.allow)
        }
    }    
}
