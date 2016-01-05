//
//  GAManager.swift
//  ExtensionsFramework
//
//  Created by Razvan Benga on 1/5/16.
//  Copyright © 2016 Razvan Benga. All rights reserved.
//

import Foundation

public class GAManager {
    
    public init(withTrackingId: String) {
        GAI.sharedInstance().trackerWithTrackingId(withTrackingId)
        GAI.sharedInstance().trackUncaughtExceptions = true
    }
    
    public static func trackView(screenName: String) {
        GAI.sharedInstance().defaultTracker.set(kGAIScreenName, value: screenName)
        GAI.sharedInstance().defaultTracker.send(GAIDictionaryBuilder.createScreenView().build() as [NSObject : AnyObject])
    }
    
}