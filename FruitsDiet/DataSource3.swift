//
//  DataSource3.swift
//  FruitsDiet
//
//  Created by Alex Gr on 19.04.16.
//  Copyright © 2016 Ravi Shankar. All rights reserved.
//

import Foundation

class DataSource3 {
    
    init() {
        populateData()
    }
    
    var fruits3:[Fruit3] = []
    var groups3:[String] = []
    
    
    func numbeOfRowsInEachGroup(index: Int) -> Int {
        return fruitsInGroup3(index).count
    }
    
    func numberOfGroups() -> Int {
        return groups3.count
    }
    
    func gettGroupLabelAtIndex(index: Int) -> String {
        return groups3[index]
    }
    
    // MARK:- Populate Data from plist
    
    func populateData() {
        if let path = NSBundle.mainBundle().pathForResource("Swa3", ofType: "plist") {
            if let dictArray = NSArray(contentsOfFile: path) {
                for item in dictArray {
                    if let dict = item as? NSDictionary {
                        let name3 = dict["name3"] as! String
                        let group3 = dict["group3"] as! String
                        
                        let fruit3 = Fruit3(name3: name3, group3: group3)
                        if !groups3.contains(group3){
                            groups3.append(group3)
                        }
                        fruits3.append(fruit3)
                    }
                }
            }
        }
    }
    
    // MARK:- FruitsForEachGroup
    
    func fruitsInGroup3(index: Int) -> [Fruit3] {
        let item3 = groups3[index]
        let filteredFruits3 = fruits3.filter { (fruit3: Fruit3) -> Bool in
            return fruit3.group3 == item3
        }
        return filteredFruits3
    }
    
    // MARK:- Add Dummy Data
    
    func addAndGetIndexForNewItem() -> Int {
        
        let fruit3 = Fruit3(name3: "SugarApple", group3: "level1")
        
        let count3 = fruitsInGroup3(0).count
        
        let index = count3 > 0 ? count3 - 1 : count3
        fruits3.insert(fruit3, atIndex: index)
        
        return index
    }
    
    // MARK:- Delete Items
    
    func deleteItems(items: [Fruit3]) {
        
        for item in items {
            // remove item
            let index = fruits3.indexOfObject(item)
            if index != -1 {
                fruits3.removeAtIndex(index)
            }
        }
    }
}

