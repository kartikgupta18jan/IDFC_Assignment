//
//  CommonFunction.swift
//  IDFC ASSIGNMENT
//


import Foundation
import UIKit
import SystemConfiguration


let kProjectName        = "IDFC ASSIGNMENT"
let kUserDefault        = UserDefaults.standard
let kEMPTY_NAME         = "First name and last name can not be empty!!"
let kWarning            = "Something went wrong to add person!!"
let ADDED               = "Person Added successfully!!"

let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)

class CommonFunction : NSObject{
    static let sharedInstance = CommonFunction()
    
    static func setLayerForView(vsType : UIView, borderColor bColor : UIColor, boderWidth width : CGFloat, cornerRadius radius : CGFloat){
        vsType.layer.borderColor = bColor.cgColor
        vsType.layer.borderWidth = width
        vsType.layer.cornerRadius = radius
        vsType.layer.masksToBounds = true
    }
    func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    func fetchErrorMessage(errors :[String?]) -> String {
        if errors.count > 0{
            var msg : String? = ""
            for object in errors{
                if object != nil {
                    if msg == "" {
                        msg = msg == nil ? object : "\(String(describing: object))"
                    }else {
                        msg = msg == nil ? object : "\(msg!)" + "\n" + "\(String(describing: object))"
                    }
                }
            }
            return msg!;
        }else {
            return "";
        }
    }
    func performAfter(delay: TimeInterval, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            completion()
        }
    }
}


