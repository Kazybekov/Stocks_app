//
//  ChipsView.swift
//  Stock_app
//
//  Created by Yersin Kazybekov on 23.01.2024.
//

import UIKit

class Chip:UIButton{
    
    init(label:String){
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 0
        self.backgroundColor = UIColor(red: 0.941, green: 0.955, blue: 0.97, alpha: 1)
        let att1 = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12.0),
                    NSAttributedString.Key.foregroundColor : UIColor.black]
        let string = NSAttributedString(string: label, attributes: att1)
        self.setAttributedTitle(string, for: .normal)
        self.configuration = UIButton.Configuration.plain()
        setupLayout()
    }
    
    func setupLayout(){
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 36),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
