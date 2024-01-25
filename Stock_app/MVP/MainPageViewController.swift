//
//  ViewController.swift
//  Stock_app
//
//  Created by Yersin Kazybekov on 04.01.2024.
//

import UIKit
import Foundation
import CoreData

enum State {
    case stocks
    case favourite
    case seacrh
}


class MainPageViewController: UIViewController,PresenterDelegate, StockCellDelegate,TopButtonsViewDelegate,ChipCollectionDelegate {
    
    init(presenter: Presenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    func chipPressed(text: String) {
        searchBar.chipPressed(text: text)
    }
    
    func favButtonUnpressed(ticker: String) {
        presenter.favButtonUnPressed(ticker: ticker)
    }
    
    func showAllTableView() {
        state = .stocks
    }
    
    func showFavTableView() {
        state = .favourite
    }
    
    func favButtonPressed(ticker: String) {
        presenter.favButtonPressed(ticker: ticker)
    }
    func reloadTableViewData() {
        tableView.reloadData()
        
    }
    func setupDelegates(){
        searchBar.delegate = self
        sectionView.delegate = self
        presenter.delegate = self
        popularRequsts.delegate = self
        recentRequsts.delegate  = self
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupDelegates()
        setupTableView()
        popularRequsts.isHidden = true
        recentRequsts.isHidden = true
    }
    func setupTableView(){
        tableView.register(StockCell.self, forCellReuseIdentifier: "stockCell")
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    let presenter:Presenter
    
    let tableView = UITableView()
    
    let searchBar:CustomSeacrhBar = {
        let view = CustomSeacrhBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sectionView:SectionView = {
        let view = SectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let array = ["Apple","TSLA","ALL","Alibaba","Company","Citi","Group","AAL","Google"]
    
    lazy var popularRequsts: ChipCollection = {
        let view = ChipCollection(title: "Popular requests",names: array )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var recentRequsts: ChipCollection = {
        let view = ChipCollection(title: "You’ve searched for this",names: array)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var state = State.stocks {
        didSet{
            switch state{
            case .favourite:
                presenter.getFavStock()
            case .stocks:
                presenter.showAllStocks()
            case .seacrh:
                enterSearchMode()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MainPageViewController:CustomSeacrhBarDelegate{
    func enterSearchMode(){
        tableView.isHidden = true
        sectionView.isHidden = true
        popularRequsts.isHidden = false
        recentRequsts.isHidden = false
    }
    func leaveSeacrhState(){
        state = .stocks
        popularRequsts.isHidden = true
        recentRequsts.isHidden = true
        sectionView.isHidden = false
        tableView.isHidden = false
    }
    func enterSeacrhState(){
        state = .seacrh
    }
    func filterTable(string: String) {
        if(string==""){
            enterSearchMode()
            return
        }
        tableView.isHidden = false
        sectionView.isHidden = true
        popularRequsts.isHidden = true
        recentRequsts.isHidden = true
        presenter.filterByString(string: string)
    }
}

extension MainPageViewController: UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row%2==0 ? 68 : 76
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getStockCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath) as? StockCell else {
            return UITableViewCell()
        }
        cell.changeStyle(isRounded: indexPath.row%2==0 ? true : false)
        cell.setupCellData(data: presenter.getStockData(at: indexPath.row))
        cell.delegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        tableView.addLoading(indexPath){
            self.presenter.getImages()
            tableView.stopLoading() // stop your indicator
        }
        
        
        
    }
    
}




