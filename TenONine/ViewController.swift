//
//  ViewController.swift
//  TenONine
//
//  Created by Acadev Inc. on 2017. 6. 1..
//  Copyright (c) 2017 Acadev Inc.. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let session: KOSession = KOSession.shared()

        session.open(completionHandler: { (error) -> Void in
            session.presentingViewController = nil

            if session.isOpen() {
                self.goToWebView()
            } else {
                switch ((error! as NSError).code) {
                case Int(KOErrorCancelled.rawValue):
                    break
                default:
                    let alertMessage = UIAlertController(title: "에러", message: error?.localizedDescription, preferredStyle: .alert)
                    alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertMessage, animated: true, completion: nil)
                    break
                }
            }
        }, authParams: nil, authTypes: [NSNumber(value: KOAuthType.talk.rawValue), NSNumber(value: KOAuthType.account.rawValue)])

    }

    func goToWebView() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

        let webViewController = storyBoard.instantiateViewController(withIdentifier: "webView") as! WebViewController
        self.present(webViewController, animated:true, completion:nil)
    }

    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }

}
