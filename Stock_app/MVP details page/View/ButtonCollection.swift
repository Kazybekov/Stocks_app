//
//  ButtonCollection.swift
//  Stock_app
//
//  Created by Yersin Kazybekov on 14.02.2024.
//

import Foundation
import UIKit

protocol ButtonCollectionDelegate{
    func stateChanged (state:Period)
}

class ButtonCollection:UIView {
    var delegate:ButtonCollectionDelegate?
    
    init(){
        super.init(frame: .zero)
        setView()
    }
    var state = Period.all {
        didSet{
            deSelectAll()
            delegate?.stateChanged(state: state)
        }
    }
    @objc func buttonPressed(_ sender: CustomButton){
        state = sender.period
        sender.isSelected = true
        sender.backgroundColor = .black
    }
    func deSelectAll(){
        let color = UIColor(red: 0.941, green: 0.955, blue: 0.97, alpha: 1)
        allButton.isSelected = false
        allButton.backgroundColor = color
        
        yearButton.isSelected = false
        yearButton.backgroundColor = color
        
        sixMonthButton.isSelected = false
        sixMonthButton.backgroundColor = color
        
        monthButton.isSelected = false
        monthButton.backgroundColor = color
        
        weekButton.isSelected = false
        weekButton.backgroundColor = color
        
        dayButton.isSelected = false
        dayButton.backgroundColor = color

    }
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8
        return stack
    }()
    let allButton: CustomButton = {
        let button  = CustomButton(name: "All",period: .all )
        button.addTarget(self, action: #selector(buttonPressed(_ :)), for: .touchUpInside)
        return button
    }()
    
    let yearButton: CustomButton = {
        let button  = CustomButton(name: "Y",period: .year)
        button.addTarget(self, action: #selector(buttonPressed(_ :)), for: .touchUpInside)
        return button
    }()
    
    let sixMonthButton: CustomButton = {
        let button  = CustomButton(name: "6M",period: .sixMonth)
        button.addTarget(self, action: #selector(buttonPressed(_ :)), for: .touchUpInside)
        return button
    }()
    
    
    let monthButton: CustomButton = {
        let button  = CustomButton(name: "M",period: .month)
        button.addTarget(self, action: #selector(buttonPressed(_ :)), for: .touchUpInside)
        return button
    }()
    
    
    let weekButton: CustomButton = {
        let button  = CustomButton(name: "W",period: .week)
        button.addTarget(self, action: #selector(buttonPressed(_ :)), for: .touchUpInside)
        return button
    }()
    
    let dayButton: CustomButton = {
        let button  = CustomButton(name: "D",period: .day)
        button.addTarget(self, action: #selector(buttonPressed(_ :)), for: .touchUpInside)
        return button
    }()
    
    func setView(){
        self.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stack.leftAnchor.constraint(equalTo: self.leftAnchor),
            stack.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
        
        stack.addArrangedSubview(allButton)
        stack.addArrangedSubview(yearButton)
        stack.addArrangedSubview(sixMonthButton)
        stack.addArrangedSubview(monthButton)
        stack.addArrangedSubview(weekButton)
        stack.addArrangedSubview(dayButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


