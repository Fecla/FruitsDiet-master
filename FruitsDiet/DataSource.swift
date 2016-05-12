//
//  DataSource.swift
//
//
//
//
//

import Foundation



class DataSource {
    
    
    
    init() {
        populateData()
        
    }
    
    var fruits:[Fruit] = []
    var groups:[String] = []
    var correctHypothesis : Bool?
    //var correctText : Bool!
    var correctText: Bool!
    
    
    func numbeOfRowsInEachGroup(index: Int) -> Int {
        return fruitsInGroup(index).count
    }
    
    func numberOfGroups() -> Int {
        return groups.count
    }
    
    func gettGroupLabelAtIndex(index: Int) -> String {
        return groups[index]
    }
    
    // Populate Data from plist
    
    func populateData() {
        //Путь к файлу тип и имя
        if let path = NSBundle.mainBundle().pathForResource("Swa", ofType: "plist") {
            //Подключение словаря
            if let dictArray = NSArray(contentsOfFile: path) {
                for item in dictArray {
                    if let dict = item as? NSDictionary {
                        let name = dict["name"] as! String
                        let group = dict["group"] as! String
                        let correctHypothesis = dict["correctHypothesis"] as! Bool?
                        let correctText = dict["correctText"] as! Bool!
                        let fruit = Fruit(name: name, group: group, correctHypothesis: correctHypothesis, correctText: correctText)
                        
                        if !groups.contains(group){
                            groups.append(group)
                        }
                        fruits.append(fruit)
                    }
                }
            }
        }
    }
    
    // MARK:- FruitsForEachGroup
    
    func fruitsInGroup(index: Int) -> [Fruit] {
        let item = groups[index]
        let filteredFruits = fruits.filter { (fruit: Fruit) -> Bool in
            return fruit.group == item
        }
        return filteredFruits
    }
    
    

    
    
    
        
    // MARK:- Add Dummy Data
    
    //func addAndGetIndexForNewItem() -> Int {
        
       // let fruit = Fruit(name: "SugarApple", group: "level1")
        
       // let count = fruitsInGroup(0).count
        
      //  let index = count > 0 ? count - 1 : count
       // fruits.insert(fruit, atIndex: index)
        
       // return index
   // }
    
    // MARK:- Delete Items
    
  //  func deleteItems(items: [Fruit]) {
        
   //     for item in items {
            // remove item
    //        let index = fruits.indexOfObject(item)
    //        if index != -1 {
     //           fruits.removeAtIndex(index)
     //       }
      //  }
    //}
//}

/*extension Array {
    func indexOfObject2<T:AnyObject>(item:T) -> Int {
        var index = -1
        for element in self {
            index += 1
            if item === element as? T {
                return index
            }
        }
        return index
    }
 
}*/}