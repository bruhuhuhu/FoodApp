//
//  File.swift
//  FoodApp
//
//  Created by hu tsun hao on 30/1/18.
//  Copyright © 2018 hu tsun hao. All rights reserved.
//

import Foundation

class DeliveryAddressViewModel {
    private let address1 = "this is address 1"
    private let address2 = "this is address 2"
    private let address3 = "this is address 3"
    private var deliveryAddress = DeliveryAddress()
    
    var address: String {
        return deliveryAddress.address
    }
    
}

extension DeliveryAddressViewModel {
    func addDeliveryAddress (address: String) {
      deliveryAddress.address = address
    }
    
}
