//
//  CustomSearchBar.swift
//  Stock_app
//
//  Created by Yersin Kazybekov on 10.01.2024.
//

import UIKit

protocol CustomSeacrhBarDelegate{
    func filterTable(string:String)
    func enterSeacrhState()
    func leaveSeacrhState()
    func showAllTableView()
}

class CustomSeacrhBar:UIView, UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        enterSeacrhMode()
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        //        exitSearchMode()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func chipPressed(text:String){
        textField.text = text
        if(textField.isFirstResponder){
            textField.resignFirstResponder()
        }else{
            textField.becomeFirstResponder()
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let string = textField.text else {return}
        
        if(string=="" || string == "Find company or ticker"){
            clearThing.isHidden = true
        }else{
            clearThing.isHidden = false
        }
        
        delegate?.filterTable(string: string)
        
    }
    
    func enterSeacrhMode(){
        clearThing.isHidden = true
        textField.text = ""
        delegate?.enterSeacrhState()
        searchThing.setImage(UIImage(named: "Back"), for: .normal)
    }
    
    func exitSearchMode(){
        clearThing.isHidden = true
        textField.text = "Find company or ticker"
        delegate?.leaveSeacrhState()
        textField.resignFirstResponder()
        searchThing.setImage(UIImage(named: "Search"), for: .normal)
    }
    
    init(){
        super.init(frame: .zero)
        self.layer.cornerRadius = 25
        self.layer.borderWidth = 1
        self.layer.borderColor = CGColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        setupLayout()
        textField.delegate = self
    }
    
    let searchThing:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Search"), for: .normal)
        button.addTarget(self, action: #selector(exitSeacrhModeButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func exitSeacrhModeButton(){
        exitSearchMode()
    }
    
    var delegate: CustomSeacrhBarDelegate?
    
    let clearThing:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Clear"), for: .normal)
        button.addTarget(self, action: #selector(clearTextField), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func clearTextField(){
        if(!textField.isFirstResponder){
            textField.becomeFirstResponder()
        }
        enterSeacrhMode()
    }
    
    let textField:UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.text = "Find company or ticker"
        return field
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        
        self.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        self.addSubview(textField)
        self.addSubview(searchThing)
        self.addSubview(clearThing)
        
        clearThing.isHidden = true
        
        NSLayoutConstraint.activate([
            searchThing.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            searchThing.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            clearThing.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            clearThing.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textField.leftAnchor.constraint(equalTo: searchThing.rightAnchor, constant: 8),
            textField.widthAnchor.constraint(equalToConstant: 200)
        ])
        
    }
    
}
