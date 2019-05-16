//
//  DetailViewController.swift
//  NyTimes
//
//  Created by Maseeh Ahmed on 5/15/19.
//  Copyright © 2019 talat. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    var article:MArticle!

    func configureView() {
        // Update the user interface for the detail item.
        self.navigationItem.title = article.articleTitle
        webView.load(URLRequest(url: URL(string: article.articleUrl ?? "")!))

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }


}

