//
//  DetailsViewController.swift
//  Stock_app
//
//  Created by Yersin Kazybekov on 29.01.2024.
//
import UIKit
import DGCharts

enum Period {
    case all
    case year
    case sixMonth
    case month
    case week
    case day
}

class DetailsViewController:UIViewController,ChartViewDelegate,ButtonCollectionDelegate{
    
    let data:StockModel
    var onNewMarkReceived: ((String?,Bool) -> Void)?
    
    var period = Period.all {
        didSet{
            getChartData()
        }
    }

    init(data:StockModel){
        self.data = data
        self.period = .all
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonCollection.delegate = self
        setupViews()
        setupLayout()
        fillData()
        setMarker()
    }
    
    lazy var presenter:DetailsPresenter={
        var p = DetailsPresenter(ticker:data.ticker ?? "None",period:period)
        return p
    }()
    
    func getChartData(){
        activityIndicator.startAnimating()
        lineChartView.isHidden = true
        
        DispatchQueue.global().async {
            self.presenter.getValues(for: self.period) { entries in
                let set = LineChartDataSet(entries: entries)
                set.drawCirclesEnabled = false
                set.mode = .cubicBezier
                set.lineWidth = 3
                set.setColor(.black)
                set.fill = LinearGradientFill(gradient: self.presenter.getGradientFilling(),angle: 90)
                set.drawFilledEnabled = true
                set.drawVerticalHighlightIndicatorEnabled = false
                set.drawHorizontalHighlightIndicatorEnabled = false
                let data = LineChartData(dataSet: set)
                data.setDrawValues(false)
                
                DispatchQueue.main.async {
                    self.lineChartView.data = data
                    self.lineChartView.isHidden = false
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    func setMarker(){
        let marker = RectMarker(color: .black, font: UIFont.systemFont(ofSize: CGFloat(12.0)), insets: UIEdgeInsets(top: 8.0, left: 20, bottom: 4.0, right: 0))
        marker.chartView = lineChartView
        marker.minimumSize = CGSize(width: CGFloat(60.0), height: CGFloat(30.0))
        lineChartView.marker = marker
    }
    func fillData(){
        period = .all
        starButton.isSelected = data.isFavourite
        tickerLabel.text = data.ticker
        nameLabel.text = data.name
        priceView.setData(data: data)
    }
    func setupViews(){
        view.addSubview(backButton)
        view.addSubview(tickerLabel)
        view.addSubview(nameLabel)
        view.addSubview(starButton)
        view.addSubview(detailsSectionView)
        view.addSubview(priceView)
        view.addSubview(lineChartView)
        view.addSubview(buttonCollection)
        view.addSubview(activityIndicator)
    }
    
    func stateChanged(state: Period) {
        period = state
    }
    
    let activityIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    lazy var lineChartView: LineChartView = {
        let chart = LineChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.rightAxis.enabled = false
        chart.leftAxis.enabled = false
        chart.xAxis.enabled = false
        chart.legend.enabled = false
        chart.drawMarkers = true
        return chart
    }()
    
    let detailsSectionView: DetailsSectionView = {
        let view = DetailsSectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    let priceView:PriceView = {
        let view = PriceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    @objc func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    let buttonCollection:ButtonCollection = {
        let collection = ButtonCollection()
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
