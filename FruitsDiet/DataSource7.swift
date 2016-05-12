//
//  DataSource7.swift
//  FruitsDiet
//
//  Created by Alex Gr on 21.04.16.
//  Copyright © 2016 Ravi Shankar. All rights reserved.
//

import Foundation

class DataSource7 {
    
    init() {
        populateData()
    }
    
    var fruits7:[Fruit7] = []
    var groups7:[String] = []
    
    
    func numbeOfRowsInEachGroup(index: Int) -> Int {
        return fruitsInGroup7(index).count
    }
    
    func numberOfGroups() -> Int {
        return groups7.count
    }
    
    func gettGroupLabelAtIndex(index: Int) -> String {
        return groups7[index]
    }
    
    // MARK:- Populate Data from plist
    
    func populateData() {
        if let path = NSBundle.mainBundle().pathForResource("Swa7", ofType: "plist") {
            if let dictArray = NSArray(contentsOfFile: path) {
                for item in dictArray {
                    if let dict = item as? NSDictionary {
                        let name7 = dict["name7"] as! String
                        let group7 = dict["group7"] as! String
                        
                        let fruit7 = Fruit7(name7: name7, group7: group7)
                        if !groups7.contains(group7){
                            groups7.append(group7)
                        }
                        fruits7.append(fruit7)
                    }
                }
            }
        }
    }
    
    // MARK:- FruitsForEachGroup
    
    func fruitsInGroup7(index: Int) -> [Fruit7] {
        let item7 = groups7[index]
        let filteredFruits7 = fruits7.filter { (fruit7: Fruit7) -> Bool in
            return fruit7.group7 == item7
        }
        return filteredFruits7
}
}