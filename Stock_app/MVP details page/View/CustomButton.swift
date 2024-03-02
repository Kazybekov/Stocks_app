//
//  CustomButton.swift
//  Stock_app
//
//  Created by Yersin Kazybekov on 14.02.2024.
//

import Foundation
import UIKit

class CustomButton:UIButton{
    var period: Period
    init(name:String,period:Period){
        self.period = period
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(name, for: .normal)
        self.setTitleColor(.white, for: .selected)
        self.setTitleColor(.black, for: .normal)
        if(name=="All"){
            self.isSelected = true
            self.backgroundColor = .black
        }else{
            self.backgroundColor = UIColor(red: 0.941, green: 0.955, blue: 0.97, alpha: 1)
        }
        self.layer.cornerRadius = 12
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
