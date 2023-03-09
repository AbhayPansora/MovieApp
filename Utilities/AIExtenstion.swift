//
//  AIExtenstion.swift
//  SportApp
//
//  Created by Abhay Pansora on 21/01/23.
//

import Foundation
import Foundation
import UIKit

extension Date
{
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    func adding(year: Int) -> Date {
        return Calendar.current.date(byAdding: .year, value: year, to: self)!
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    static func dates(from fromDate: Date, to toDate: Date, format inFormate : String) -> [String] {
        var dates: [String] = []
        var date = fromDate
        
        while date <= toDate {
            dates.append(date.formatedString(withFormat: inFormate)!)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
    
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
    func adding(month: Int) -> Date {
        return Calendar.current.date(byAdding: .month, value: month, to: self)!
    }
    func adding(day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: self)!
    }
    
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
    
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    init(ticks: UInt64) {
        self.init(timeIntervalSince1970: Double(ticks)/10_000_000 - 62_135_596_800)
    }
    
    
    func formatedString(withFormat format: String = "yyyy/MM/dd") -> String? {
        let formatter: DateFormatter = .init()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    func formated(withFormat format: String = "yyyy/MM/dd") -> Date? {
        let formatter: DateFormatter = .init()
        formatter.dateFormat = format
        let dateString = formatter.string(from: self)
        return formatter.date(from: dateString)
    }
    
    func daysSince(_ anotherDate: Date) -> Int? {
        if let fromDate = dateFromComponents(self), let toDate = dateFromComponents(anotherDate) {
            let components = Calendar.current.dateComponents([.day], from: fromDate, to: toDate)
            return components.day
        }
        return nil
    }
    
    private func dateFromComponents(_ date: Date) -> Date? {
        let calender   = Calendar.current
        let components = calender.dateComponents([.year, .month, .day], from: date)
        return calender.date(from: components)
    }
}

extension UIView{
    // HEIGHT / WIDTH
    
    var width:CGFloat {
        return self.frame.size.width
    }
    var height:CGFloat {
        return self.frame.size.height
    }
    var xPos:CGFloat {
        return self.frame.origin.x
    }
    var yPos:CGFloat {
        return self.frame.origin.y
    }
    
    // BORDER
    func applyTheameBlueBorderDefault() {
        self.applyBorder(APP_THEAM_COLOR, width: 1.0)
    }
    func applyBorderDefault() {
        self.applyBorder(UIColor.white, width: 1.0)
    }
    func applyBorderDefault1() {
        self.applyBorder(UIColor.green, width: 1.0)
    }
    func applyBorderDefault2() {
        self.applyBorder(UIColor.blue, width: 1.0)
    }
    func applyBorderDefault3() {
        self.applyBorder(UIColor.black, width: 1.0)
    }
    func applyBorder(_ color:UIColor, width:CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func applyCircle() {
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) * 0.5
        self.layer.masksToBounds = true
    }
    func applyCircleWithRadius(_ radius:CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    // CORNER RADIUS
    func applyCornerRadius(_ radius:CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func applyCornerRadiusDefault() {
        self.applyCornerRadius(5.0)
    }
    
    func setSpecificCornerRadius(size: CGSize, corners: UIRectCorner){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            let rectShape = CAShapeLayer()
            rectShape.bounds = self.frame
            rectShape.position = self.center
            rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size).cgPath
            rectShape.borderColor = APP_THEAM_COLOR.cgColor
            rectShape.borderWidth = 0.0
            self.layer.mask = rectShape
        }
    }
    func setOnClickListener(action :@escaping () -> Void){
        let tapRecogniser = ClickListener(target: self, action: #selector(onViewClicked(sender:)))
        tapRecogniser.onClick = action
        self.addGestureRecognizer(tapRecogniser)
    }
    @objc func onViewClicked(sender: ClickListener) {
        if let onClick = sender.onClick {
            onClick()
        }
    }
    
    // SHADOW
    func setViewShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5.0
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = false
    }
    
    func applyShadowDefault(){
        self.applyShadowWithColor(UIColor.black, opacity: 0.5, radius: 1)
    }
    
    func applyShadowWithColor(_ color:UIColor)    {
        self.applyShadowWithColor(color, opacity: 0.5, radius: 3)
    }
    
    func applyShadowWithColor(_ color:UIColor, opacity:Float, radius: CGFloat)    {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: 5, height: 0)
        self.layer.shadowRadius = radius
        self.clipsToBounds = false
    }
    
    func applyShadow(){
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.1
    }
    
    func layerGradient() {
        let layer : CAGradientLayer = CAGradientLayer()
        layer.frame.size = self.frame.size
        layer.frame.origin = CGPoint(x: 0, y: 0)
        layer.cornerRadius = CGFloat(frame.width / 20)
        
        let color0 = UIColor(red:250.0/255, green:250.0/255, blue:250.0/255, alpha:0.5).cgColor
        let color1 = UIColor(red:200.0/255, green:200.0/255, blue: 200.0/255, alpha:0.1).cgColor
        let color2 = UIColor(red:150.0/255, green:150.0/255, blue: 150.0/255, alpha:0.1).cgColor
        let color3 = UIColor(red:100.0/255, green:100.0/255, blue: 100.0/255, alpha:0.1).cgColor
        let color4 = UIColor(red:50.0/255, green:50.0/255, blue:50.0/255, alpha:0.1).cgColor
        let color5 = UIColor(red:0.0/255, green:0.0/255, blue:0.0/255, alpha:0.1).cgColor
        let color6 = UIColor(red:150.0/255, green:150.0/255, blue:150.0/255, alpha:0.1).cgColor
        
        layer.colors = [color0,color1,color2,color3,color4,color5,color6]
        self.layer.insertSublayer(layer, at: 0)
    }
    
    func applyGradient(colours: [UIColor]) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.opacity = 1
        //gradient.startPoint = CGPoint(x: 1, y: 0)
        
        self.layer.insertSublayer(gradient, at: 0)
    }
    
}
class ClickListener: UITapGestureRecognizer {
    var onClick : (() -> Void)? = nil
}
extension UIDevice {
    
    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0 > 0
        }
        return false
    }
}
extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
// Screen width.
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}


extension UIView {
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func dropShadowed(cornerRadius:CGFloat, corners: UIRectCorner, borderColor: UIColor, borderWidth:CGFloat, shadowColor:UIColor) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        layer.mask?.shadowPath = path.cgPath
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 8
        layer.cornerRadius = cornerRadius
        
        if corners.contains(.topLeft) || corners.contains(.topRight) {
            layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        }
        if corners.contains(.bottomLeft) || corners.contains(.bottomRight) {
            layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        }
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.shadowPath =  nil//path.cgPath
        layer.masksToBounds = false
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    
    var globalFrame: CGRect? {
        let rootView = UIApplication.shared.keyWindowInConnectedScenes?.rootViewController?.view
        return self.superview?.convert(self.frame, to: rootView)
    }
    
}

extension UIApplication {
    var keyWindowInConnectedScenes: UIWindow?{
        return windows.first(where: {$0.isKeyWindow})
    }
}
extension Double {    
    func rounded(decimalPoint: Int) -> Double {
        let power = pow(10.0, Double(decimalPoint))
       return (self * power).rounded() / power
    }
}
extension UIColor {
    
    /// color with hax string
    ///
    /// - Parameter hexString: hexString description
    convenience init(hexString:String) {
        var hexString:String = hexString.trimmingCharacters(in: CharacterSet.whitespaces)
        
        if (hexString.hasPrefix("#")) { hexString.remove(at: hexString.startIndex) }
        
        var color:UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(displayP3Red: red, green: green, blue: blue, alpha: 1)
        //self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    
    static let themeColor = APP_THEAM_COLOR //UIColor(hexString: "#FF0035")
    static let themeFontColor = UIColor(hexString: "#212621")
    static let themeFontLightColor = APP_THEAM_LIGHT_GREEN_COLOR//UIColor(hexString: "#8C98A9")
}


public enum VC_TYPE:Int {
    case Dummy = 5
    case Daily = 0
    case History = 1
    case Subsciption = 2
    case Profile = 3
}

extension Double {
    func splitIntoParts(decimalPlaces: Int, round: Bool) -> (leftPart: Int, rightPart: Int) {
        
        var number = self
        if round {
            //round to specified number of decimal places:
            let divisor = pow(10.0, Double(decimalPlaces))
            number = Darwin.round(self * divisor) / divisor
        }
        
        //convert to string and split on decimal point:
        let parts = String(number).components(separatedBy: ".")
        
        //extract left and right parts:
        let leftPart = Int(parts[0]) ?? 0
        let rightPart = Int(parts[1]) ?? 0
        
        return(leftPart, rightPart)
        
    }
}
extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        return formatter
    }()
}
extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
extension UINavigationBar {
    func installBlurEffect() {
        isTranslucent = true
        setBackgroundImage(UIImage(), for: .default)
        let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        var blurFrame = bounds
        blurFrame.size.height += statusBarHeight
        blurFrame.origin.y -= statusBarHeight
        let blurView  = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurView.isUserInteractionEnabled = false
        blurView.frame = blurFrame
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurView)
        blurView.layer.zPosition = -1
    }
}
extension UICollectionView {
  func setMessage(_ message: String) {
      let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
      messageLabel.text = message
      messageLabel.textColor = .black
      messageLabel.numberOfLines = 0
      messageLabel.textAlignment = .center
      messageLabel.sizeToFit()

      self.backgroundView = messageLabel
  }
  func removeMessage() {
      self.backgroundView = nil
  }
}
