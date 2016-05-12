//
//  DataSource2.swift
//  FruitsDiet
//
//  Created by Alex Gr on 19.04.16.
//  Copyright © 2016 Ravi Shankar. All rights reserved.
//

import Foundation

class DataSource2 {
    
    init() {
        populateData()
    }
    
    var fruits2:[Fruit2] = []
    var groups2:[String] = []
    
    
    func numbeOfRowsInEachGroup(index: Int) -> Int {
        return fruitsInGroup2(index).count
    }
    
    func numberOfGroups() -> Int {
        return groups2.count
    }
    
    func gettGroupLabelAtIndex(index: Int) -> String {
        return groups2[index]
    }
    
    // MARK:- Populate Data from plist
    
    func populateData() {
        if let path = NSBundle.mainBundle().pathForResource("Swa2", ofType: "plist") {
            if let dictArray = NSArray(contentsOfFile: path) {
                for item in dictArray {
                    if let dict = item as? NSDictionary {
                        let name2 = dict["name2"] as! String
                        let group2 = dict["group2"] as! String
                        
                        let fruit2 = Fruit2(name2: name2, group2: group2)
                        if !groups2.contains(group2){
                            groups2.append(group2)
                        }
                        fruits2.append(fruit2)
                    }
                }
            }
        }
    }
    
    // MARK:- FruitsForEachGroup
    
    func fruitsInGroup2(index: Int) -> [Fruit2] {
        let item2 = groups2[index]
        let filteredFruits2 = fruits2.filter { (fruit2: Fruit2) -> Bool in
            return fruit2.group2 == item2
        }
        return filteredFruits2
    }
    
    // MARK:- Add Dummy Data
    
    func addAndGetIndexForNewItem() -> Int {
        
        let fruit2 = Fruit2(name2: "SugarApple", group2: "level1")
        
        let count2 = fruitsInGroup2(0).count
        
        let index = count2 > 0 ? count2 - 1 : count2
        fruits2.insert(fruit2, atIndex: index)
        
        return index
    }
    
    // MARK:- Delete Items
    
    func deleteItems(items: [Fruit2]) {
        
        for item in items {
            // remove item
            let index = fruits2.indexOfObject(item)
            if index != -1 {
                fruits2.removeAtIndex(index)
            }
        }
    }
}

/*extension Array {
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
}*/