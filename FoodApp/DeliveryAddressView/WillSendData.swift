//
//  DataPassingProtocol.swift
//  FoodApp
//
//  Created by hu tsun hao on 31/1/18.
//  Copyright © 2018 hu tsun hao. All rights reserved.
//

import Foundation

protocol WillSendData {
    func pass (data: [DeliveryAddress])
}
