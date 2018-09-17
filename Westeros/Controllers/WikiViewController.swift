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
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(model: House) {
        //1. Limpio de niles
        self.model = model
        //2. llamo a super
        super.init(nibName: nil, bundle: Bundle (for: type(of: self)))
        //3. Usas las propierties de tu superclase
        title = model.name;
        
    }
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        //Subscribirse a la notificacion
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(houseDidChange), name: NSNotification.Name(rawValue: HouseDidChangeNoficationName), object: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //Asignar delegados
        webView.navigationDelegate = self
        syncModelWithView()
    }
    
    
    //Mark: Notifications
    
    @objc func houseDidChange(notification: Notification){
        //Sacar la info de la notificacion
        guard let info = notification.userInfo,
            let house : House = info[HouseKey] as? House else {return}
        
        
        //Actualizar el modelo
        self.model = house
        
        //Sincronizar
        syncModelWithView()
        
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
        //Detener el spinner
        loadingView.stopAnimating()
        
        //Ocultarlo
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
