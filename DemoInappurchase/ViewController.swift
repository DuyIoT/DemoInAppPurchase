//
//  ViewController.swift
//  DemoInappurchase
//
//  Created by Apple on 11/15/20.
//

import UIKit
import StoreKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func onFetchProduct(_ sender: Any) {
        IAPManager.shared.fetchProducts()
    }
    
    @IBAction func onPurchase(_ sender: Any) {
        IAPManager.shared.purchase(product: IAPManager.shared.products["com.temporary.id"] ?? SKProduct())
    }
}

