//
//  AIGlobel.swift
//  SportApp
//
//  Created by Abhay Pansora on 21/01/23.
//

import Foundation
import UIKit

//MARK: - GENERAL
let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
//let ServiceManager = AIServiceManager.sharedManager
let storyBoard = UIStoryboard(name: "Main", bundle: nil)

//MARK: - APP SPECIFIC
let APP_NAME = ""
let APPSTORE_URL = "https://itunes.apple.com/us/app/Spaciko/id1519947641?ls=1&mt=8"


let FONT_MEDIUM = "Helveticas-Medium"
let FONT_SF_SEMIBOLD = "Helveticas-Semibold"
let FONT_REGULAR = "Helvetica-Regular"
let FONT_BOLD = "Helvetica-Bold"
let FONT_LIGHT = "Helvetica-Thin"

//MARK: - COLORS
public func RGBCOLOR(_ r: CGFloat, g: CGFloat , b: CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
}

public func RGBCOLOR(_ r: CGFloat, g: CGFloat , b: CGFloat, alpha: CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
}
let APP_THEAM_COLOR = RGBCOLOR(64, g: 182, b:168)//40B6A8
let APP_NAVIGATION_TEXT_COLOR = RGBCOLOR(9, g: 44, b:76)//092C4C
let APP_VIEW_BACKGROUND_COLOR = RGBCOLOR(242, g: 242, b: 242, alpha: 1.0)//F2F2F2
let APP_THEAM_GRAY_COLOR = RGBCOLOR(89, g: 100, b:126)
let APP_THEAM_DARK_GREEN_COLOR = RGBCOLOR(31, g: 159, b:144)//1F9F90
let APP_THEAM_LIGHT_GREEN_COLOR = RGBCOLOR(64, g: 182, b:168,alpha: 0.5)
let APP_WHITE_COLOR = UIColor.white
let APP_CLEAR_COLOR = UIColor.clear
let APP_BLACK_COLOR = RGBCOLOR(28, g: 31, b:32)
let APP_DARK_GREY_COLOR = RGBCOLOR(110, g:110, b:110)
let APP_LIGHT_GREY_COLOR = RGBCOLOR(0, g: 0, b: 0, alpha: 0.16)
let APP_BOTTOM_SHADOW_COLOR = RGBCOLOR(43, g: 145, b: 232, alpha: 0.1)
let APP_TEXTFEILD_ENABLE_COLOR = RGBCOLOR(9, g: 44, b:76)//092C4C
let APP_TEXTFEILD_COLOR = RGBCOLOR(153, g: 168, b:183)
let APP_TEXTFEILD_BORDER_COLOR = RGBCOLOR(153, g: 168, b: 189, alpha: 0.6)
let APP_LIGHT_RED_COLOR = RGBCOLOR(255, g: 70, b: 10)

//MARK: - SCREEN SIZE
let NAVIGATION_BAR_HEIGHT:CGFloat = 64
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SCREEN_WIDTH = UIScreen.main.bounds.size.width

// MARK: - KEYS
let DeviceToken = "DeviceToken"
let FIREBASE_TOKEN = "firebase_token"
let KEY_IS_FIRSTTIME_OPEN = "KEY_IS_FIRSTTIME_OPEN"
let KEY_IS_USER_LOGGED_IN = "KEY_IS_USER_LOGGED_IN"
let USER_TOKEN = "user_token"
let KEY_BACKGOUND_DATE = "KEY_BACKGOUND_DATE"
let KEY_IS_FAV_MOVIE = "KEY_IS_FAV_MOVIE"
// MARK: - USERDEFAULTS
func setUserDefaultValues(_ key : String , value : String){
    let userDefault : UserDefaults = UserDefaults.standard
    userDefault.set(value, forKey: key)
    userDefault.synchronize()
}
func setDateUserDefaultValue(_ key : String , value : Date){
    let userDefault : UserDefaults = UserDefaults.standard
    userDefault.set(value, forKey: key)
    userDefault.synchronize()
}

func setIntUserDefaultValue(_ key : String , value : Int){
    let userDefault : UserDefaults = UserDefaults.standard
    userDefault.set(value, forKey: key)
    userDefault.synchronize()
}

func getDateUserDefaultValue(_ key : String) -> Date{
    let userDefault : UserDefaults = UserDefaults.standard
    var value : Date = Date()
    if userDefault.value(forKey: key) != nil{
        value = userDefault.value(forKey: key) as! Date
    }
    return value
}

func getIntUserDefaultValue(_ key : String) -> String{
    let userDefault : UserDefaults = UserDefaults.standard
    var value : Int = 0
    if userDefault.value(forKey: key) != nil{
        value = userDefault.value(forKey: key) as! Int
    }
    return String(value)
}

func getUserDefaultValue(_ key : String) -> String{
    let userDefault : UserDefaults = UserDefaults.standard
    var value : String = ""
    if userDefault.value(forKey: key) != nil{
        value = userDefault.value(forKey: key) as! String
    }
    return value
}
func getUserDefaultArrayValue(_ key : String) -> [[String:AnyObject]]{
    let userDefault : UserDefaults = UserDefaults.standard
    var value  = [[String:AnyObject]]()
    if userDefault.value(forKey: key) != nil{
        value = userDefault.value(forKey: key) as! [[String:AnyObject]]
    }
    return value
}
func setUserDefaultArrayValue(_ key : String , value : [[String:AnyObject]]){
    let userDefault : UserDefaults = UserDefaults.standard
    userDefault.set(value, forKey: key)
    userDefault.synchronize()
}
func setBoolUserDefaultValue(_ key : String , value : Bool){
    let userDefault : UserDefaults = UserDefaults.standard
    userDefault.set(value, forKey: key)
    userDefault.synchronize()
}

func getBoolUserDefaultValue(_ key : String) -> Bool{
    var value : Bool = false
    let userDefault : UserDefaults = UserDefaults.standard
    if userDefault.value(forKey: key) != nil{
        value = ((userDefault.value(forKey: key)) != nil)
    }
    return value
}
func loadJson(_ filename: String) -> [[String:AnyObject]] {
    var allMoviee = [[String:AnyObject]]()
    let url = Bundle.main.url(forResource: filename, withExtension: "json")!
    do {
        let jsonData = try Data(contentsOf: url)
        let json = try JSONSerialization.jsonObject(with: jsonData)
        //print(json)
        allMoviee = json as! [[String:AnyObject]]
        return allMoviee
    }
    catch {
        print(error)
    }
    return allMoviee
}
func isValidPhone(phone: String) -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
}
class appTitleThame22Label : UILabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        self.font = UIFont(name: FONT_BOLD, size: 22)
        self.textColor = APP_NAVIGATION_TEXT_COLOR
    }
}
class appSubTitleGray14Label : UILabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        self.font = UIFont(name: FONT_MEDIUM, size: 14)
        self.textColor = APP_THEAM_GRAY_COLOR
    }
}
class appSubTitleGray13Label : UILabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        self.font = UIFont(name: FONT_MEDIUM, size: 13)
        self.textColor = APP_THEAM_GRAY_COLOR
    }
}
//iPhone 4 OR 4S
func IS_IPHONE_4_OR_4S()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 480
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)    {
        device = true
    }
    return device
}

//iPhone 5 OR OR 5C OR 4S
func IS_IPHONE_5_OR_5S()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 568
    var device:Bool = false
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)    {
        device = true
    }
    return device
}

//iPhone 6 OR 6S
func IS_IPHONE_6_OR_6S()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 667
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)    {
        device = true
    }
    return device
}

//iPhone 6Plus OR 6SPlus
func IS_IPHONE_6P_OR_6SP()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 736
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)    {
        device = true
    }
    return device
}
//iPhone X
func IS_IPHONE_X()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 812
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST <= SCREEN_HEIGHT)    {
        device = true
    }
    return device
}

//iPhone Xr
func IS_IPHONE_XR()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 896
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)    {
        device = true
    }
    return device
}
