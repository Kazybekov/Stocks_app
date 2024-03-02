//
//  DetailsViewControllerLayout.swift
//  Stock_app
//
//  Created by Yersin Kazybekov on 16.02.2024.
//

import Foundation
import UIKit

extension DetailsViewController{
    func setupLayout(){
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
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
    
        NSLayoutConstraint.activate([
            detailsSectionView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 20),
            detailsSectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            detailsSectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            detailsSectionView.heightAnchor.constraint(equalToConstant: 26)
        ])
        
        NSLayoutConstraint.activate([
            priceView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            priceView.topAnchor.constraint(equalTo: detailsSectionView.bottomAnchor, constant: 40)
        ])
    
        NSLayoutConstraint.activate([
            lineChartView.topAnchor.constraint(equalTo: priceView.bottomAnchor,constant: 0),
            lineChartView.leftAnchor.constraint(equalTo: view.leftAnchor),
            lineChartView.rightAnchor.constraint(equalTo: view.rightAnchor),
            lineChartView.bottomAnchor.constraint(equalTo: buttonCollection.topAnchor)

        ])
        NSLayoutConstraint.activate([

            buttonCollection.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -8),
            buttonCollection.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 8),
            buttonCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -100),
            buttonCollection.heightAnchor.constraint(equalToConstant: 48)

        ])

        
    }
}
