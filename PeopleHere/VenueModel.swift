//
//  VenueModel.swift
//  ios-interview
//
//  Created by Swapnil Jain on 10/13/17.
//  Copyright © 2017 Foursquare. All rights reserved.
//

import UIKit

class VenueModel: NSObject {
    var venueId: String
    var venueName: String
    var openTime: Int
    var closeTime: Int
    var visitors = [VisitorModel]()
    
    // Failable designated initializer.
    init?(venueDict: Dictionary<String, Any>) {
        // Guard against wrong type.
        guard let venueId = venueDict["id"] as? String,
            let venueName = venueDict["name"] as? String,
            let openTime = venueDict["openTime"] as? Int,
            let closeTime = venueDict["closeTime"] as? Int,
            let visitors = venueDict["visitors"] as? [Dictionary<String,Any>] else {
            return nil
        }
        self.venueId = venueId
        self.venueName = venueName
        self.openTime = openTime
        self.closeTime = closeTime
     
        // Iterate visitors array to prepare model array.
        for visitor in visitors {
            let visitorId = visitor["id", default: ""] as! String
            let visitorName = visitor["name", default: ""] as! String
            let arriveTime = visitor["arriveTime", default: 0] as! Int
            let leaveTime = visitor["leaveTime", default: 0] as! Int
            let visitorModel = VisitorModel(visitorId: visitorId,
                                          visitorName: visitorName,
                                           arriveTime: arriveTime,
                                            leaveTime: leaveTime)
            self.visitors.append(visitorModel)
        }
        
        // Sorted by arrival time
        self.visitors.sort(by: {
            return $0.arriveTime < $1.arriveTime
        })
        
        /* self.visitors.map({print($0.descriptioin())}) */
        super.init()
        
        // Now let's find and append idle intervals, if any.
        findAndappendIdleIntervalsIfAny()
    }
    
    func findAndappendIdleIntervalsIfAny() {
        // An array of tuple which will have intervals(VisitorModel) when there were no visitors,
        // along with its index relative to visitors array.
        var noVisitorTupleArr = [(VisitorModel, Int)]()
        
        // idleStart time may start from venue open time.
        var idleStartTime = openTime
        
        // now iterate visitors array to find out idle intervals
        for index in 0..<visitors.count {
            let visitor = visitors[index]
            
            // Add an idle interval if visitor arrives after idleStartTime.
            if visitor.arriveTime > idleStartTime {
                let model = VisitorModel(visitorId: "Unknown",
                                       visitorName: "No Visitors",
                                        arriveTime: idleStartTime,
                                         leaveTime: visitor.arriveTime)
                model.isNoVisitor = true
                noVisitorTupleArr.append((model,noVisitorTupleArr.count+index))
            }
            
            // Update idleStartTime to visitor leaveTime.
            idleStartTime = visitor.leaveTime > idleStartTime ? visitor.leaveTime : idleStartTime
        }
        
        // Now lets add an interval - last visitor leave time to store close time (if applicable)
        if idleStartTime < closeTime {
            let model = VisitorModel(visitorId: "Unknown",
                                   visitorName: "No Visitors",
                                    arriveTime: idleStartTime,
                                     leaveTime: closeTime)
            model.isNoVisitor = true
            noVisitorTupleArr.append((model, noVisitorTupleArr.count+visitors.count))
        }
        
        // finally, add all idle intervals into visitors array at given index
        for (model,index) in noVisitorTupleArr {
            visitors.insert(model, at: index)
        }
        
        /* self.visitors.map({print($0.descriptioin())}) */
    }
}
