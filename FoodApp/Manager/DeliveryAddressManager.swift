//
//  DeliveryAddressManager.swift
//  FoodApp
//
//  Created by hu tsun hao on 31/1/18.
//  Copyright © 2018 hu tsun hao. All rights reserved.
//

import Foundation

class DeliveryAddressManager {
    
    static let shared = DeliveryAddressManager()
    
    let address1 = DeliveryAddress(deliveryAddress: "default1")
    let address2 = DeliveryAddress(deliveryAddress: "default2")
    var deliveryAddresses : [DeliveryAddress]
    
    init () {
    deliveryAddresses = [address1, address2]
    }
    
    func getDeliveryAddresses() -> [DeliveryAddress] {
        return self.deliveryAddresses
    }
    func setDeliveryAddresses(deliveryAddress: DeliveryAddress) {
        self.deliveryAddresses.append(deliveryAddress)
    }
    
}
