//
//  Buttons.swift
//  Stock_app
//
//  Created by Yersin Kazybekov on 10.01.2024.
//

import UIKit

protocol TopButtonsViewDelegate{
    func showFavTableView()
    func showAllTableView()
}

class SectionView:UIView{
    
    init(){
        super.init(frame: .zero)
        setupLayout()
    }
    
    var delegate:TopButtonsViewDelegate?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    let stockButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let att1 = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 28.0),
                    NSAttributedString.Key.foregroundColor : UIColor.black]
        let stocksSelected = NSAttributedString(string: "Stocks", attributes: att1)
        
        let att2 = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0),
                    NSAttributedString.Key.foregroundColor : UIColor(red: 0.729, green: 0.729, blue: 0.729, alpha: 1)]
        let stocksNotSelected = NSAttributedString(string: "Stocks", attributes: att2)
        
        
        button.setAttributedTitle(stocksSelected, for: .selected)
        button.setAttributedTitle(stocksNotSelected, for: .normal)
        
        button.addTarget(self, action: #selector(stocksPressed), for: .touchUpInside)
        button.isSelected = true
        button.isUserInteractionEnabled = false
        
       // UIView.transition(with: button, duration: 3.0, animations: { button.isHighlighted = true })
        //UIView.transition(with: button, duration: 5, options: .transitionCrossDissolve, animations: {button.isSelected.toggle()})
        
        return button
    }()
    
    let favButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let att1 = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 28.0),
                    NSAttributedString.Key.foregroundColor : UIColor.black]
        let stocksSelected = NSAttributedString(string: "Favourite", attributes: att1)
        
        let att2 = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0),
                    NSAttributedString.Key.foregroundColor : UIColor(red: 0.729, green: 0.729, blue: 0.729, alpha: 1)]
        let stocksNotSelected = NSAttributedString(string: "Favourite", attributes: att2)
        
        
        button.setAttributedTitle(stocksSelected, for: .selected)
        button.setAttributedTitle(stocksNotSelected, for: .normal)
        
        button.addTarget(self, action: #selector(favPressed), for: .touchUpInside)
        button.isSelected = false
       // UIView.transition(with: button, duration: 3.0, animations: { button.isHighlighted = true })
        //UIView.transition(with: button, duration: 5, options: .transitionCrossDissolve, animations: {button.isSelected.toggle()})
        
        return button
    }()
    
    @objc func stocksPressed(){
            self.stockButton.isSelected.toggle()
            self.stockButton.isUserInteractionEnabled.toggle()
            self.favButton.isSelected.toggle()
            self.favButton.isUserInteractionEnabled.toggle()
        delegate?.showAllTableView()
    }
    
    
    @objc func favPressed(){
            self.stockButton.isSelected.toggle()
            self.stockButton.isUserInteractionEnabled.toggle()
            self.favButton.isSelected.toggle()
            self.favButton.isUserInteractionEnabled.toggle()
        delegate?.showFavTableView()
    }
    
    func setupLayout(){
        self.addSubview(stockButton)
        self.addSubview(favButton)
                
        NSLayoutConstraint.activate([
            stockButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stockButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            favButton.centerYAnchor.constraint(equalTo: stockButton.centerYAnchor),
            favButton.leftAnchor.constraint(equalTo: stockButton.rightAnchor, constant: 20)
        ])
    }
    
}
