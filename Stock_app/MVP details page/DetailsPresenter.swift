//
//  DetailsPresenter.swift
//  Stock_app
//
//  Created by Yersin Kazybekov on 29.01.2024.
//

import UIKit
import DGCharts

class DetailsPresenter{
    
    init(ticker:String,period:Period) {
        self.ticker = ticker
        self.period = period
    }
    
    var valuesMonth:[ChartDataEntry] = []
    var valuesWeek:[ChartDataEntry] = []
    var valuesDay:[ChartDataEntry] = []
    var valuesMin:[ChartDataEntry] = []
    
    var ticker:String
    var lock = DispatchSemaphore(value: 0)
    var period:Period
    
    let apiKey = "&apikey=QPO22CF2ZOEV9UV7"
    //QPO22CF2ZOEV9UV7 98SZ5IVE7I2I65OU 7ZRHY8A3TKNLT3NT
    var url = "https://www.alphavantage.co/query?function="
    
    let byDay = "TIME_SERIES_DAILY&symbol="
    let byMonth = "TIME_SERIES_MONTHLY&symbol="
    let byWeek = "TIME_SERIES_WEEKLY&symbol="
    let by30Min = "TIME_SERIES_INTRADAY&symbol="
    let interval = "&interval=60min&outputsize=compact"
    
    func urlBuilder()->String{
        switch period {
        case .all:
            return url+byMonth+ticker+apiKey
        case .year,.sixMonth:
            return url+byWeek+ticker+apiKey
        case .month,.week:
            return url+byDay+ticker+apiKey
        case .day:
            return url+by30Min+ticker+interval+apiKey
        }
    }
    
    func getValues(for period:Period, _ completion: @escaping ([ChartDataEntry]) ->Void ){
        self.period = period
        switch period {
        case .all:
            if(valuesMonth.isEmpty){loadData()}
            completion(valuesMonth.enumerated().compactMap { index, element in
                    index % 4 == 0 ? element : nil})
        case .year:
            if(valuesWeek.isEmpty){loadData()}
            completion(valuesWeek.suffix(52))
        case .sixMonth:
            if(valuesWeek.isEmpty){loadData()}
            completion(valuesWeek.suffix(26))
        case .month:
            if(valuesDay.isEmpty){loadData()}
            completion(valuesDay.suffix(21))
        case .week:
            if(valuesDay.isEmpty){loadData()}
            completion(valuesDay.suffix(8))
        case .day:
            if(valuesMin.isEmpty){loadData()}
            completion(valuesMin.suffix(16))
        }
    }
    func loadData(){
        fetchData()
        lock.wait()
    }
    func fetchData() {
        guard let urlString = URL(string: urlBuilder()) else{ return }
        let task = URLSession.shared.dataTask(with: urlString) { (data, response, error) in
            if let error=error {
                print(error)
            }else{
                guard let data=data else{return}
                self.decodeJson(data: data)
            }
        }
        task.resume()
    }
    
    func decodeJson(data:Data){
        do {
            var jsonString = ""
            switch self.period {
            case .all:
                jsonString = "Monthly Time Series"
            case .year,.sixMonth:
                jsonString = "Weekly Time Series"
            case .month,.week:
                jsonString = "Time Series (Daily)"
            case .day:
                jsonString = "Time Series (60min)"
            }
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let timeSeries = json[jsonString] as? [String: Any] {
                decodeSubJson(timeSeries:timeSeries)
            }
        } catch {
            print("Error parsing JSON: \(error)")
        }
    }

    func decodeSubJson(timeSeries:[String: Any]){
        for (timestamp, data) in timeSeries {
            if let dataDict = data as? [String: String],
               let high = dataDict["2. high"] {
                let date = dateFormatter(timestamp)
                guard let yAxis = (Double)(high) else{return}
                switch period {
                case .all:
                    valuesMonth.append(ChartDataEntry(x: date.timeIntervalSince1970, y:yAxis ))
                case .year,.sixMonth:
                    valuesWeek.append(ChartDataEntry(x: date.timeIntervalSince1970, y:yAxis ))
                case .month,.week:
                    valuesDay.append(ChartDataEntry(x: date.timeIntervalSince1970, y:yAxis ))
                case .day:
                    valuesMin.append(ChartDataEntry(x: date.timeIntervalSince1970, y:yAxis ))
                }
            }
        }
        sortValues()
    }
    
    func dateFormatter(_ dateString:String)->Date{
        if(dateString.count>10) {return dateFormatterWithMin(dateString)}
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:dateString)
        return date ?? Date.now
    }
    
    func dateFormatterWithMin(_ dateString:String)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from:dateString)
        return date ?? Date.now
    }

    func sortValues(){
        switch self.period {
        case .all:
            valuesMonth.sort { d1, d2 in
                return d1.x<d2.x
            }
        case .year,.sixMonth:
            valuesWeek.sort { d1, d2 in
                return d1.x<d2.x
            }
        case .month,.week:
            valuesDay.sort { d1, d2 in
                return d1.x<d2.x
            }
        case .day:
            valuesMin.sort { d1, d2 in
                return d1.x<d2.x
            }
        }
        lock.signal()
    }
    func getGradientFilling() -> CGGradient {
        let coloTop = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        let colorBottom = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        let gradientColors = [coloTop, colorBottom] as CFArray
        let colorLocations: [CGFloat] = [1.0, 0.3]
        return CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)!
    }
}
