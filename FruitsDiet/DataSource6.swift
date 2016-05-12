//
//  DataSource6.swift
//  FruitsDiet
//
//  Created by Alex Gr on 21.04.16.
//  Copyright © 2016 Ravi Shankar. All rights reserved.
//

import Foundation

class DataSource6 {
    
    init() {
        populateData()
    }
    
    var fruits6:[Fruit6] = []
    var groups6:[String] = []
    
    
    func numbeOfRowsInEachGroup(index: Int) -> Int {
        return fruitsInGroup6(index).count
    }
    
    func numberOfGroups() -> Int {
        return groups6.count
    }
    
    func gettGroupLabelAtIndex(index: Int) -> String {
        return groups6[index]
    }
    
    // MARK:- Populate Data from plist
    
    func populateData() {
        if let path = NSBundle.mainBundle().pathForResource("Swa6", ofType: "plist") {
            if let dictArray = NSArray(contentsOfFile: path) {
                for item in dictArray {
                    if let dict = item as? NSDictionary {
                        let name6 = dict["name6"] as! String
                        let group6 = dict["group6"] as! String
                        
                        let fruit6 = Fruit6(name6: name6, group6: group6)
                        if !groups6.contains(group6){
                            groups6.append(group6)
                        }
                        fruits6.append(fruit6)
                    }
                }
            }
        }
    }
    
    // MARK:- FruitsForEachGroup
    
    func fruitsInGroup6(index: Int) -> [Fruit6] {
        let item6 = groups6[index]
        let filteredFruits6 = fruits6.filter { (fruit6: Fruit6) -> Bool in
            return fruit6.group6 == item6
        }
        return filteredFruits6
    }
    
    // MARK:- Add Dummy Data
    
    /*func addAndGetIndexForNewItem() -> Int {
        
        let fruit6 = Fruit6(name6: "SugarApple", group6: "level1")
        
        let count6 = fruitsInGroup6(0).count
        
        let index = count6 > 0 ? count6 - 1 : count6
        fruits6.insert(fruit6, atIndex: index)
        
        return index
    }*/
    
    // MARK:- Delete Items
    
    /*func deleteItems(items: [Fruit6]) {
        
        for item in items {
            // remove item
            let index = fruits6.indexOfObject(item)
            if index != -1 {
                fruits6.removeAtIndex(index)
            }
        }
    }*/
}

