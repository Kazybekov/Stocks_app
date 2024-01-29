//
//  DetailsViewController.swift
//  Stock_app
//
//  Created by Yersin Kazybekov on 29.01.2024.
//
import UIKit

class DetailsViewController:UIViewController{
    let presenter:DetailsPresenter
    let data:StockListData
    var onNewMarkReceived: ((String?,Bool) -> Void)?
    
    init(presenter:DetailsPresenter,data:StockListData){
        self.presenter = presenter
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupLayout()
        fillData()
    }
    
    func fillData(){
        starButton.isSelected = data.isFavourite
        tickerLabel.text = data.ticker
        nameLabel.text = data.name
    }
    
    let starButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "star")?.withTintColor(.black,renderingMode: .alwaysOriginal),for: .normal)
        button.setImage(UIImage(systemName: "star.fill")?.withTintColor(.black,renderingMode: .alwaysOriginal),for: .selected)
        button.addTarget(self, action: #selector(favPressed), for: .touchUpInside)
        return button
    }()
    
    @objc func favPressed(){
        starButton.isSelected.toggle()
        onNewMarkReceived?(data.ticker,starButton.isSelected)
    }
    
    let tickerLabel: UILabel = {
        let label = UILabel()
        label.text = "TCKR"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Apple inc."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Back"), for: .normal)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return button
    }()
    
    
    @objc func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupViews(){
        view.addSubview(backButton)
        view.addSubview(tickerLabel)
        view.addSubview(nameLabel)
        view.addSubview(starButton)
    }

    
    func setupLayout(){
        NSLayoutConstraint.activate([
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28)
        ])
        
        NSLayoutConstraint.activate([
            tickerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tickerLabel.bottomAnchor.constraint(equalTo: backButton.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: backButton.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            starButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -16),
            starButton.widthAnchor.constraint(equalToConstant: 24),
            starButton.heightAnchor.constraint(equalToConstant: 24),
            starButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
