//
//  DataSource5.swift
//  FruitsDiet
//
//  Created by Alex Gr on 20.04.16.
//  Copyright © 2016 Ravi Shankar. All rights reserved.
//

import Foundation

class DataSource5 {
    
    init() {
        populateData()
    }
    
    var fruits5:[Fruit5] = []
    var groups5:[String] = []
    
    
    func numbeOfRowsInEachGroup(index: Int) -> Int {
        return fruitsInGroup5(index).count
    }
    
    func numberOfGroups() -> Int {
        return groups5.count
    }
    
    func gettGroupLabelAtIndex(index: Int) -> String {
        return groups5[index]
    }
    
    // MARK:- Populate Data from plist
    
    func populateData() {
        if let path = NSBundle.mainBundle().pathForResource("Swa5", ofType: "plist") {
            if let dictArray = NSArray(contentsOfFile: path) {
                for item in dictArray {
                    if let dict = item as? NSDictionary {
                        let name5 = dict["name5"] as! String
                        let group5 = dict["group5"] as! String
                        
                        let fruit5 = Fruit5(name5: name5, group5: group5)
                        if !groups5.contains(group5){
                            groups5.append(group5)
                        }
                        fruits5.append(fruit5)
                    }
                }
            }
        }
    }
    
    // MARK:- FruitsForEachGroup
    
    func fruitsInGroup5(index: Int) -> [Fruit5] {
        let item5 = groups5[index]
        let filteredFruits5 = fruits5.filter { (fruit5: Fruit5) -> Bool in
            return fruit5.group5 == item5
        }
        return filteredFruits5
    }
    
    // MARK:- Add Dummy Data
    
    func addAndGetIndexForNewItem() -> Int {
        
        let fruit5 = Fruit5(name5: "SugarApple", group5: "level1")
        
        let count5 = fruitsInGroup5(0).count
        
        let index = count5 > 0 ? count5 - 1 : count5
        fruits5.insert(fruit5, atIndex: index)
        
        return index
    }
    
    // MARK:- Delete Items
    
    func deleteItems(items: [Fruit5]) {
        
        for item in items {
            // remove item
            let index = fruits5.indexOfObject(item)
            if index != -1 {
                fruits5.removeAtIndex(index)
            }
        }
    }
}

extension Array {
    func indexOfObject<T:AnyObject>(item:T) -> Int {
        var index = -1
        for element in self {
            index += 1
            if item === element as? T {
                return index
            }
        }
        return index
    }
}