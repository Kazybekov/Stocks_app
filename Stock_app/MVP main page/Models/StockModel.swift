//
//  StockModel.swift
//  Stock_app
//
//  Created by Yersin Kazybekov on 04.01.2024.
//

import Foundation
import UIKit

struct StockModel{
    var name:String = "companyName"
    var logo:UIImage?
    var ticker:String = "XXXX"
    var isFavourite: Bool = false
    var currentPrice: Float = 0.0
    var priceChange: Float = 0.0
    var priceChangePercent: Float = 0.0
}
