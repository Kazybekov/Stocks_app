//
//  DetailsSectionView.swift
//  Stock_app
//
//  Created by Yersin Kazybekov on 30.01.2024.
//

import UIKit

class DetailsSectionView: UIView {
    init(){
        super.init(frame: .zero)
        self.backgroundColor = .white
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        self.layer.shadowOffset = CGSize(width: 0 , height: 2)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 2
        
        setupStack()
        setupLayout()
    }
    func setupStack(){
        array[0].font = UIFont.systemFont(ofSize: 18, weight: .bold)
        array[0].textColor = .black
        for label in array {
            hStack.addArrangedSubview(label)
        }
    }
    
    let array = [SectionTitle(title: "Chart"),SectionTitle(title:"Summary"),SectionTitle(title:"News"),SectionTitle(title:"Forecast"),SectionTitle(title:"Ideas"),SectionTitle(title:"Tendency"),SectionTitle(title:"Crypto")]
    
    let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let scrollView:UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    func setupLayout(){
        self.addSubview(scrollView)
        scrollView.addSubview(hStack)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 16),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -16),
          
            
            hStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hStack.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            hStack.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SectionTitle:UILabel{
    init(title:String){
        super.init(frame: .zero)
        self.text = title
        self.textColor = UIColor(red: 0.729, green: 0.729, blue: 0.729, alpha: 1)
        self.font = UIFont.systemFont(ofSize: 14)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

