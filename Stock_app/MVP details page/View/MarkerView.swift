//
//  MarkerView.swift
//  Stock_app
//
//  Created by Yersin Kazybekov on 08.02.2024.
//

import Foundation
import UIKit

class MarkerView: UILabel {
    init(){
        super.init(frame: .zero)
       
        setupLayouts()
    }
    
    let currentPrice:UILabel={
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "123.4 $"
        return label
    }()
    
    let date:UILabel={
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .gray
        label.text = "3,4%"
        return label
    }()
    
    func setupLayouts(){
        self.addSubview(currentPrice)
        self.addSubview(date)
        
        NSLayoutConstraint.activate([
            currentPrice.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            currentPrice.topAnchor.constraint(equalTo: self.topAnchor,constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            date.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            date.topAnchor.constraint(equalTo: currentPrice.bottomAnchor,constant: 4)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}
