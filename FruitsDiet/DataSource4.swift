//
//  File.swift
//  FruitsDiet
//
//  Created by Alex Gr on 20.04.16.
//  Copyright © 2016 Ravi Shankar. All rights reserved.
//

import Foundation

class DataSource4 {
    
    init() {
        populateData()
    }
    
    var fruits4:[Fruit4] = []
    var groups4:[String] = []
    
    
    func numbeOfRowsInEachGroup(index: Int) -> Int {
        return fruitsInGroup4(index).count
    }
    
    func numberOfGroups() -> Int {
        return groups4.count
    }
    
    func gettGroupLabelAtIndex(index: Int) -> String {
        return groups4[index]
    }
    
    // MARK:- Populate Data from plist
    
    func populateData() {
        if let path = NSBundle.mainBundle().pathForResource("Swa4", ofType: "plist") {
            if let dictArray = NSArray(contentsOfFile: path) {
                for item in dictArray {
                    if let dict = item as? NSDictionary {
                        let name4 = dict["name4"] as! String
                        let group4 = dict["group4"] as! String
                        
                        let fruit4 = Fruit4(name4: name4, group4: group4)
                        if !groups4.contains(group4){
                            groups4.append(group4)
                        }
                        fruits4.append(fruit4)
                    }
                }
            }
        }
    }
    
    // MARK:- FruitsForEachGroup
    
    func fruitsInGroup4(index: Int) -> [Fruit4] {
        let item4 = groups4[index]
        let filteredFruits4 = fruits4.filter { (fruit4: Fruit4) -> Bool in
            return fruit4.group4 == item4
        }
        return filteredFruits4
    }
    
    // MARK:- Add Dummy Data
    
    func addAndGetIndexForNewItem() -> Int {
        
        let fruit4 = Fruit4(name4: "SugarApple", group4: "level1")
        
        let count4 = fruitsInGroup4(0).count
        
        let index = count4 > 0 ? count4 - 1 : count4
        fruits4.insert(fruit4, atIndex: index)
        
        return index
    }
    
    // MARK:- Delete Items
    
    func deleteItems(items: [Fruit4]) {
        
        for item in items {
            // remove item
            let index = fruits4.indexOfObject(item)
            if index != -1 {
                fruits4.removeAtIndex(index)
            }
        }
    }
}

