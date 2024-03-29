//
//  ChipCollection.swift
//  Stock_app
//
//  Created by Yersin Kazybekov on 23.01.2024.
//

import UIKit

protocol ChipCollectionDelegate{
    func chipPressed(text:String)
}

class ChipCollection:UIView{
    
    var array: [String]?
    var delegate:ChipCollectionDelegate?
    
    init(title:String,names:[String]){
        super.init(frame: .zero)
        self.array = names
        titleLabel.text = title
        fillStack()
        setupLayout()
        
    }
    
    func fillStack(){
        guard let array=array else{
            return
        }
        for i in 0...array.count-1 {
            let chip = Chip(label: array[i])
            chip.addTarget(self, action: #selector(seacrhChip(_: )), for: .touchUpInside)
            if(i%2==0){
                hStack2.addArrangedSubview(chip)
                
            }else{
                hStack1.addArrangedSubview(chip)
            }
        }
    }
    @objc func seacrhChip(_ chip:Chip){
        if let text = chip.titleLabel?.text{
            delegate?.chipPressed(text:text )
        }
    }
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isScrollEnabled = true
        scroll.bounces = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let vStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 4
        return stack
    }()
    
    let hStack1: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 4
        return stack
    }()
    
    let hStack2: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 4
        return stack
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    func setupLayout(){
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
        ])
        
        self.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 16),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        scrollView.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            vStack.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            vStack.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            vStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)

        ])
        
        vStack.addArrangedSubview(hStack1)
        vStack.addArrangedSubview(hStack2)
        
//        NSLayoutConstraint.activate([
//            hStack1.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            hStack1.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
//            hStack1.rightAnchor.constraint(equalTo: scrollView.rightAnchor)
//        ])
//        NSLayoutConstraint.activate([
//            hStack2.topAnchor.constraint(equalTo: hStack1.bottomAnchor,constant: 8),
//            hStack2.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
//            hStack2.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            hStack2.rightAnchor.constraint(equalTo: scrollView.rightAnchor)
//        ])
//
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
