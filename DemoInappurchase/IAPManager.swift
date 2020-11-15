//
//  IAPManager.swift
//  DemoInappurchase
//
//  Created by Apple on 11/15/20.
//

import Foundation
import StoreKit

class IAPManager: NSObject {
    
    static let shared = IAPManager()
    let monthly = ["com.temporary.id", "com.temporary.id2"]
    
    var products: [String: SKProduct] = [:]
    
    func startMonitoring() {
        SKPaymentQueue.default().add(self)
    }
    
    func stopMonitoring() {
        SKPaymentQueue.default().remove(self)
    }
    
    func fetchProducts() {
        let productIDs = Set(monthly)
        let request = SKProductsRequest(productIdentifiers: productIDs)
        request.delegate = self
        request.start()
    }
    
    func purchase(product: SKProduct) {
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
}

// MARK: - SKProductsRequestDelegate
extension IAPManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        response.invalidProductIdentifiers.forEach { product in
            print("Invalid: \(product)")
        }
        
        response.products.forEach { product in
            print("Valid: \(product)")
            products[product.productIdentifier] = product
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Error for request: \(error.localizedDescription)")
    }
}

extension IAPManager: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        
    }
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                break
            case .purchased:
                queue.finishTransaction(transaction)
            case .restored:
                queue.finishTransaction(transaction)
            case .failed, .deferred:
                break
            }
        }
    }
}
