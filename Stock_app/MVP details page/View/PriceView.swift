//
//  PriceView.swift
//  Stock_app
//
//  Created by Yersin Kazybekov on 08.02.2024.
//

import Foundation
import UIKit

class PriceView:UIView {
    
    init(){
        super.init(frame: .zero)
        self.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.widthAnchor.constraint(equalToConstant: 120).isActive = true
        setupLayouts()
    }
    
    let currentPrice:UILabel={
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.text = "123.4 $"
        return label
    }()
    
    let deltaPrice:UILabel={
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 0.14, green: 0.7, blue: 0.364, alpha: 1)
        label.text = "3,4%"
        return label
    }()
    
    func setData(data:StockModel){
        currentPrice.text = String(format: "%.2f",data.currentPrice) + " USD"
        deltaPrice.text = String(format: "%.2f",data.priceChange) + " (" + String(format: "%.2f",data.priceChangePercent) + "%)"
    }
    
    func setupLayouts(){
        self.addSubview(currentPrice)
        self.addSubview(deltaPrice)
        
        
        
        NSLayoutConstraint.activate([
            currentPrice.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            currentPrice.topAnchor.constraint(equalTo: self.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            deltaPrice.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            deltaPrice.topAnchor.constraint(equalTo: currentPrice.bottomAnchor,constant: 4)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
}
