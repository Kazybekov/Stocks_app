//
//  MainPageLayout.swift
//  Stock_app
//
//  Created by Yersin Kazybekov on 22.01.2024.
//

import UIKit

extension MainPageViewController{
    
    func setupViews() {
        
        popularRequsts.isHidden = true
        recentRequsts.isHidden = true
        
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.heightAnchor.constraint(equalToConstant: 48),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -16),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        view.addSubview(popularRequsts)
        
        NSLayoutConstraint.activate([
            popularRequsts.topAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 16),
            popularRequsts.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            popularRequsts.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
            popularRequsts.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        view.addSubview(recentRequsts)
        
        NSLayoutConstraint.activate([
            recentRequsts.topAnchor.constraint(equalTo: popularRequsts.bottomAnchor,constant: 16),
            recentRequsts.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            recentRequsts.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
            recentRequsts.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        view.addSubview(sectionView)
        
        NSLayoutConstraint.activate([
            sectionView.heightAnchor.constraint(equalToConstant: 68),
            sectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            sectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            sectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor)
        ])
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: sectionView.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -16)
        ])
        
        
       
    }
}
