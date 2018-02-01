//
//  DeliveryAddressViewModel.swift
//  FoodApp
//
//  Created by hu tsun hao on 31/1/18.
//  Copyright © 2018 hu tsun hao. All rights reserved.
//

import Foundation



class DeliveryAddressViewModel {
    
    let deliveryAddressManager : DeliveryAddressManager
    
    var deliveryAddresses = [DeliveryAddress]()
    
    init () {
        deliveryAddressManager = DeliveryAddressManager.shared
        deliveryAddresses = deliveryAddressManager.getDeliveryAddresses()
    }
    
    func getDeliveryAddress() -> [DeliveryAddress] {
        deliveryAddresses = deliveryAddressManager.getDeliveryAddresses()
        return deliveryAddresses
    }
    
    func setDeliveryAddress(deliveryAddress: String?){
        
        if (deliveryAddress) != nil {
            let newDeliveryAddress = DeliveryAddress(deliveryAddress: deliveryAddress!)
            deliveryAddresses.append(newDeliveryAddress)
        }
        deliveryAddressManager.deliveryAddresses = deliveryAddresses

    }
}
