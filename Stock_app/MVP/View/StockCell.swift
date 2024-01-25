//
//  TransactionCell.swift
//  kaspi_app
//
//  Created by Yersin Kazybekov on 24.11.2023.
//

import Foundation
import UIKit

protocol StockCellDelegate{
    func favButtonPressed(ticker:String)
    func showFavTableView()
    func favButtonUnpressed(ticker:String)
    func showAllTableView()
}

class StockCell: UITableViewCell  {
    
    static let identifier = "stockCell"
    
    var delegate: StockCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        setupView()
        setupLayout()
    }
    
    
    func setupCellData(data: StockModel){
        
        starButton.isSelected = data.isFavourite
        tickerLabel.text = data.ticker
        fullName.text = data.name
        companyLogo.image  = data.logo
        currentPrice.text = String(format: "%.2f",data.currentPrice) + " USD"
        priceChange.text = String(format: "%.2f",data.priceChange) + " (" + String(format: "%.2f",data.priceChangePercent) + "%)"
        if(data.priceChange>=0){
            priceChange.textColor = UIColor(red: 0.14, green: 0.7, blue: 0.364, alpha: 1)
        }
        else{
            priceChange.textColor = .red
        }
    }
    
    func changeStyle(isRounded: Bool){
        if(isRounded){
            self.backgroundColor = UIColor(red: 0.941, green: 0.955, blue: 0.97, alpha: 1)
            self.layer.cornerRadius = 16
        }
        else{
            self.backgroundColor = .white
            self.layer.cornerRadius = 0
        }
    }
    
    func setupView(){
        self.addSubview(tickerLabel)
        self.addSubview(companyLogo)
        self.addSubview(currentPrice)
        self.addSubview(priceChange)
        self.addSubview(fullName)
        self.addSubview(starButton)
    }
    let starButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Fav"), for: .normal)
        button.setImage(UIImage(named: "FavSelected"), for: .selected)
        button.addTarget(self, action: #selector (favPressed) , for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func favPressed(){
        if(starButton.isSelected){
            delegate?.favButtonUnpressed(ticker: tickerLabel.text ?? "")
        }else{
            delegate?.favButtonPressed(ticker: tickerLabel.text ?? "")
        }
        starButton.isSelected.toggle()
        //        UIView.transition(with: starButton, duration: 0.25, options: .transitionCrossDissolve, animations: {
        //            self.starButton.setImage(UIImage(named: "FavSelected"), for: .selected)
        //                    }, completion: nil)
        //        UIView.transition(with: starButton, duration: 0.25, options: .transitionCrossDissolve, animations: {
        //            self.starButton.setImage(UIImage(named: "Fav"), for: .normal)
        //                    }, completion: nil)
    }
    
    let companyLogo:UIImageView = {
        let logo = UIImageView(image: UIImage(named: "YNDX"))
        logo.heightAnchor.constraint(equalToConstant: 52).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 52).isActive = true
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.clipsToBounds = true
        logo.layer.cornerRadius = 15
        return logo
    }()
    
    let tickerLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "YNDX"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let currentPrice:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "4 764,6 KZT"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceChange:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12,weight: .bold)
        label.text = "+55 ₽ (1,15%)"
        label.textColor = UIColor(red: 0.14, green: 0.7, blue: 0.364, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let fullName:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Yandex, LLC"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    func setupLayout(){
        
        NSLayoutConstraint.activate([
            starButton.centerYAnchor.constraint(equalTo: tickerLabel.centerYAnchor),
            starButton.leftAnchor.constraint(equalTo: tickerLabel.rightAnchor , constant: 6)
        ])
        
        NSLayoutConstraint.activate([
            priceChange.centerYAnchor.constraint(equalTo: fullName.centerYAnchor),
            priceChange.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            fullName.leftAnchor.constraint(equalTo: tickerLabel.leftAnchor),
            fullName.topAnchor.constraint(equalTo: tickerLabel.bottomAnchor),
            fullName.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            currentPrice.centerYAnchor.constraint(equalTo: tickerLabel.centerYAnchor),
            currentPrice.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -17)
        ])
        
        NSLayoutConstraint.activate([
            companyLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            companyLogo.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            tickerLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor),
            tickerLabel.leftAnchor.constraint(equalTo: companyLogo.rightAnchor , constant: 12)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
