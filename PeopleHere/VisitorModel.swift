//
//  VisitorModel.swift
//  ios-interview
//
//  Created by Swapnil Jain on 10/13/17.
//  Copyright © 2017 Foursquare. All rights reserved.
//

import UIKit

class VisitorModel: NSObject{
    var visitorId: String
    var visitorName: String
    var arriveTime: Int
    var leaveTime: Int
    var isNoVisitor = false
    init(visitorId: String, visitorName: String, arriveTime: Int, leaveTime: Int) {
        self.visitorId = visitorId
        self.visitorName = visitorName
        self.arriveTime = arriveTime
        self.leaveTime = leaveTime
    }
    
    public func time24HrDisplayFormat(timeInSeconds: Int) -> String? {
        if timeInSeconds <= 0{
            return nil
        }
        let hour = (timeInSeconds / (60*60)) % 24 // Divide by 24, just incase seconds overflow (> 24*3600)
        let mins = (timeInSeconds % (60*60)) / 60
        let minText = mins > 9 ? String(mins) : "0\(mins)"
        return "\(hour):\(minText)"
    }
    
    func descriptioin()->String{
        return "\(visitorId)-\(visitorName):\(arriveTime)-\(leaveTime)"
    }
}
