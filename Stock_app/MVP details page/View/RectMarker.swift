
import Foundation
import UIKit
import DGCharts


open class RectMarker: MarkerImage
{
    open var color: NSUIColor?
    open var font: NSUIFont?
    open var insets = UIEdgeInsets()
    
    open var miniTime : Double = 100000
    var interval = 3600.0 * 24.0*7 // one day
    
    open var minimumSize = CGSize()
    var dateFormatter = DateFormatter()
    
    fileprivate var label: NSMutableAttributedString?
    
    fileprivate var _labelSize: CGSize = CGSize()
    
    public init(color: UIColor, font: UIFont, insets: UIEdgeInsets, miniTime: Double=10000000, interval: Double = 3600.0 * 24.0*30)
    {
        super.init()
        
        self.color = color
        self.font = font
        self.insets = insets
        self.miniTime = miniTime
        self.interval = interval
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "dd/MM/yy HH:mm"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")! as TimeZone
    }
    
    var markerLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    open override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint
    {
        var offset = CGPoint()
        let chart = self.chartView
        var size = self.size
        
        if size.width == 0.0 && image != nil
        {
            size.width = image?.size.width ?? 0.0
        }
        if size.height == 0.0 && image != nil
        {
            size.height = image?.size.height ?? 0.0
        }
        
        let width = size.width
        let height = size.height
        let origin = point

        if origin.x + offset.x < 0.0
        {
            offset.x = -origin.x
        }
        else if chart != nil && origin.x + width + offset.x > chart!.viewPortHandler.contentRect.maxX
        {
            offset.x =  -width
        }

        if origin.y + offset.y < 0
        {
            offset.y = height
        }
        else if chart != nil && origin.y + height + offset.y > chart!.viewPortHandler.contentRect.maxY
        {
            offset.y =  -height
        }
//
//        offset.x = offset.x - size.width/2
//        offset.y = offset.y - size.height-10
        
        return offset
    }
    
    open override func draw(context: CGContext, point: CGPoint)
    {
        let offset = self.offsetForDrawing(atPoint: point)
        let size = self.size
        
        let rect = CGRect(
            origin: CGPoint(
                x: point.x + offset.x,
                y: point.y + offset.y),
            size: size)
        
        let sizeCircle = CGSize(width: 10, height: 10)
        
        let circle = CGRect(
            origin: CGPoint(
                x: point.x-5,
                y: point.y-5),
            size: sizeCircle)
        
        context.saveGState()
        if let color = color
        {
            context.beginPath()
            drawRoundedRect(rect: rect, inContext: context, radius: 16, borderColor: CGColor(gray: 0, alpha: 0), fillColor: color.cgColor, borderWidth: 0)
            drawRoundedRect(rect: circle, inContext: context, radius: 5, borderColor: CGColor(red: 1, green: 1, blue: 1, alpha: 1), fillColor: color.cgColor, borderWidth: 2)

            context.fillPath()
        }
        
        markerLabel.drawText(in: rect)
        context.restoreGState()
    }
    
    func drawRoundedRect(rect: CGRect, inContext context: CGContext?,
                         radius: CGFloat, borderColor: CGColor, fillColor: CGColor, borderWidth: CGFloat) {
        // 1
        let path = CGMutablePath()
        
        // 2
        path.move( to: CGPoint(x:  rect.midX, y:rect.minY ))
        path.addArc( tangent1End: CGPoint(x: rect.maxX, y: rect.minY ),
                     tangent2End: CGPoint(x: rect.maxX, y: rect.maxY), radius: radius)
        path.addArc( tangent1End: CGPoint(x: rect.maxX, y: rect.maxY ),
                     tangent2End: CGPoint(x: rect.minX, y: rect.maxY), radius: radius)
        path.addArc( tangent1End: CGPoint(x: rect.minX, y: rect.maxY ),
                     tangent2End: CGPoint(x: rect.minX, y: rect.minY), radius: radius)
        path.addArc( tangent1End: CGPoint(x: rect.minX, y: rect.minY ),
                     tangent2End: CGPoint(x: rect.maxX, y: rect.minY), radius: radius)
        path.closeSubpath()
        
        // 3
        context?.setLineWidth(borderWidth)
        context?.setFillColor(fillColor)
        context?.setStrokeColor(borderColor)
        
        // 4
        context?.addPath(path)
        context?.drawPath(using: .fillStroke)
    }

    
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight)
    {
        var str = ""
        let mutableString = NSMutableAttributedString( string: str )
        
        let chartView = self.chartView
        var dataEntry = [ChartDataEntry]()
        
        var dataEntryX = 0.0
        for  dataSets in chartView!.data!.dataSets
        {
            dataEntry = dataSets.entriesForXValue(entry.x)
            
            if !dataEntry.isEmpty
            {
                let data = dataSets.valueFormatter.stringForValue(dataEntry[0].y, entry: dataEntry[0], dataSetIndex: 0, viewPortHandler: nil)
                str = "$ "+data + ""
                dataEntryX = dataEntry[0].x
            }
            else
            {
                str = "ggg"
            }
            
            let labelAttributes:[NSAttributedString.Key: Any]? = [
                .font : UIFont.boldSystemFont(ofSize: 16),
                .foregroundColor : UIColor(white: 1, alpha: 1),
            ]
            let addedString = NSAttributedString(string: str, attributes: labelAttributes)
            mutableString.append(addedString)
        }
//        print(dataEntryX)
        str = "\n" + stringForValue( dataEntryX,xValue: dataEntryX )
        let labelAttributes:[NSAttributedString.Key : Any]? = [
            .font : UIFont.systemFont(ofSize: 10),
            .foregroundColor : UIColor(red: 1, green: 0.6, blue: 0.9, alpha: 1) ]

        let addedString = NSAttributedString(string: str, attributes: labelAttributes)
       
        mutableString.append(addedString)
        markerLabel.attributedText = mutableString
        setLabel(mutableString)
    }
    
    open func setLabel(_ newlabel: NSMutableAttributedString)
    {
        label = newlabel
        var size = CGSize()
        size.width = 100
        size.height = 60
        self.size = size
    }
    
    func stringForValue(_ value: Double,xValue:Double) -> String
    {
        self.dateFormatter.dateFormat = "dd MMM yy"
        let date2 = Date(timeIntervalSince1970:xValue )
        let date = dateFormatter.string(from: date2)
        return  date
    }
    
}



