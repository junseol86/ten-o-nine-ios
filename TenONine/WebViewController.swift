//
//  WebViewController.swift
//  TenONine
//
//  Created by Acadev Inc. on 2017. 6. 2..
//  Copyright © 2017년 Acadev Inc.. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let session: KOSession = KOSession.shared()

        let apiUrl = URL(string: "http://ten.portfolio1000.com/api/auth/login?access_token=" + session.accessToken)
        let apiRequest = URLRequest(url: apiUrl!)

        print("http://ten.portfolio1000.com/api/auth/login?access_token=" + session.accessToken)

        let task = URLSession.shared.dataTask(with: apiRequest) { (data, response, error) in
            do {
                let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                print(parsedData)
                let accessToken = parsedData["access_token"] as! String;
                self.loadPage(accessToken: accessToken)
            } catch {
                print (error)
            }
        }
        task.resume()

        webView.delegate = self
    }

    func loadPage(accessToken: String) {
        let url = URL(string: "http://13.124.80.145:8081/#/intro/" + accessToken.replacingOccurrences(of: "/", with: "@"))
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
