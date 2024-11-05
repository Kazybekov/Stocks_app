//
//  Presenter.swift
//  Stock_app
//
//  Created by Yersin Kazybekov on 11.01.2024.
//

import Foundation
import UIKit
import CoreData

protocol PresenterDelegate{
    func reloadTableViewData()
}

class Presenter{
    
    var dictionary =  [String: StockModel]()
    
    var moc:NSManagedObjectContext!
    
    var stockList = [StockListData]()
    
    var stockListFromCoreData = [StockListData]()
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var cellCount=0
    
    var delegate:PresenterDelegate?
    
    let finhubUrl = "https://finnhub.io/api/v1/quote?symbol="
    let apiToken = "&token=ckpr2p1r01qkitmj9ni0ckpr2p1r01qkitmj9nig"
    
    init()  {
        moc =  appDelegate?.persistentContainer.viewContext
        loadStockListData()
        getImages()
    }
    
    func tapped (atRow row:Int)->StockModel{
        return dictionary[stockList[row].ticker ?? "None"] ?? StockModel()
    }
    
    func filterByString(string:String){
        stockList = stockListFromCoreData
        if(string==""){
            delegate?.reloadTableViewData()
            return
        }
        stockList = stockList.filter { data in
            guard let safe = data.name else{return false}
            guard let safet = data.ticker else{return false}
            
            if(safe.contains(string) || safet.contains(string) ){
                return true;
            }
            return false
        }
        cellCount = 0;
        getImages()
        
    }
    
    func showAllStocks(){
        stockList = stockListFromCoreData
        cellCount = 0;
        getImages()
    }
    
    func getFavStock(){
        stockList = stockList.filter { stock in
            return stock.isFavourite
        }
        cellCount = 0
        getImages()
    }
    
    
    func favButtonPressed(ticker:String){
        dictionary[ticker]?.isFavourite = true
        stockList = stockList.map({ StockListData in
            if(StockListData.ticker==ticker){
                StockListData.isFavourite=true
            }
            return StockListData
        })
    }
    
    func favButtonUnPressed(ticker:String){
        dictionary[ticker]?.isFavourite = false
        stockList = stockList.map({ StockListData in
            if(StockListData.ticker==ticker){
                StockListData.isFavourite=false
            }
            return StockListData
        })
    }
    
    func getImages(){
        DispatchQueue.global().async {
            self.fetchData(){
                self.delegate?.reloadTableViewData()
            }
        }
    }
    
    func fetchData(completion: @escaping () -> Void) {
        let c = cellCount
        let downloadGroup = DispatchGroup()
        for i in c...c+10 {
            var stock = StockModel()
            if(i>=stockList.count){
                break}
            let stockData = self.stockList[i]
            self.cellCount+=1
            guard let ticker = stockData.ticker,let name = stockData.name else{continue}
            if dictionary.contains(where: { $0.key == ticker }){
                continue
            }
            stock.isFavourite = stockData.isFavourite
            stock.name = name
            stock.ticker = ticker
            dictionary[ticker] = stock
            
            guard let urlString = stockData.logoUrl, let url = URL(string: urlString) else {continue}
            urlSessionImage(url: url, downloadGroup: downloadGroup, ticker: ticker)
            guard let finhubUrl = URL(string: finhubUrl+ticker+apiToken) else {continue}
            urlSessionData(url: finhubUrl, downloadGroup: downloadGroup, ticker: ticker)
            
        }
        downloadGroup.notify(queue: .main) {
            completion()
        }
    }
    func getStockCount()->Int{
        let res = cellCount
        return res
    }
    
    //func to get table view max rows
    func getMaxCellNUmbers()->Int{
        return stockList.count
    }
    
    func getStockData(at row:Int) -> StockModel {
        if let data=dictionary[stockList[row].ticker!]{
            return data
        }
        return StockModel(name: stockList[row].name!, logo: nil, ticker: stockList[row].ticker!)
    }
    
    
    
    
    func saveDataToCore() {
        do{
            try moc.save()
        }catch{
            print("error on saving data to core")
        }
    }
    
    func loadStockListData() {
        let request: NSFetchRequest<StockListData> = StockListData.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(StockListData.ticker), ascending: true)
        request.sortDescriptors = [sort]

        do {
            stockListFromCoreData = try moc.fetch(request)
            
            if stockListFromCoreData.isEmpty {
                if let jsonData = loadJSONData() {
                    let decoder = JSONDecoder()
                    let stockListFromJSON = try decoder.decode([StockProfile].self, from: jsonData)
                    
                    for stock in stockListFromJSON {
                        let stockData = StockListData(context: moc)
                        stockData.name = stock.name
                        stockData.ticker = stock.ticker
                        stockData.logoUrl = stock.logo.isEmpty ? "https://img.freepik.com/free-psd/cross-mark-isolated_23-2151478819.jpg?t=st=1730787866~exp=1730791466~hmac=4a14255d74f5b5855e0558b70dc97368619c8527469907ddbc3c61596aa105e6&w=1380" : stock.logo
                        stockData.isFavourite = false
                    }
                    try moc.save()
                    stockListFromCoreData = try moc.fetch(request)
                }
            }
            
            stockList = stockListFromCoreData
        } catch {
            print("Could not load data: \(error)")
        }
    }

    private func loadJSONData() -> Data? {
        let filePath = Bundle.main.path(forResource: "stockProfiles", ofType: "json")
        guard let path = filePath, let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            print("Could not load JSON data from file.")
            return nil
        }
        return jsonData
    }

    struct StockProfile: Codable {
        let name: String
        let logo: String
        let ticker: String
    }

    
    
}



extension Presenter{
    
    struct StockChange: Codable {
        let c:Float
        let d:Float
        let dp:Float
    }
    
    func parseFromJson(data:Data?)->StockChange?{
        let decoder = JSONDecoder()
        do {
            guard let data=data else{return nil}
            let goodData = try decoder.decode(StockChange.self, from: data)
            return goodData
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    
    func urlSessionImage(url:URL,downloadGroup:DispatchGroup,ticker:String){
        downloadGroup.enter()
        URLSession.shared.dataTask(with: url) { data, _, error in
            defer {
                downloadGroup.leave()
            }
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                return
            }
            if let data = data, let image = UIImage(data: data) {
                self.dictionary[ticker]?.logo=image
            }
        }.resume()
    }
    
    func urlSessionData(url:URL,downloadGroup:DispatchGroup,ticker:String){
        downloadGroup.enter()
        URLSession.shared.dataTask(with:url) { data, _, error in
            defer {
                downloadGroup.leave()
            }
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                return
            }
            if let dataFromJson = self.parseFromJson(data: data){
                self.dictionary[ticker]?.currentPrice = dataFromJson.c
                self.dictionary[ticker]?.priceChange = dataFromJson.d
                self.dictionary[ticker]?.priceChangePercent = dataFromJson.dp
            }
        }.resume()
    }
}
