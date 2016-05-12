//
//  ViewController3.swift
//  FruitsDiet
//
//  Created by Alex Gr on 19.04.16.
//  Copyright © 2016 Ravi Shankar. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {

    let identifier3 = "CellIdentifier3"
    let headerViewIdentifier3 = "HeaderView3"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    let dataSource3 = DataSource3()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        navigationItem.leftBarButtonItem = editButtonItem()
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        if let indexPath = getIndexPathForSelectedCell() {
            highlightCell(indexPath, flag: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK:- prepareForSegue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // retrieve selected cell & fruit
        
        if let indexPath = getIndexPathForSelectedCell() {
            
            let fruit3 = dataSource3.fruitsInGroup3(indexPath.section)[indexPath.row]
            
            let detailViewController = segue.destinationViewController as! DetailViewController3
            detailViewController.fruit3 = fruit3
        }
    }
    
    // MARK:- Should Perform Segue
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return !editing
    }
    
    // MARK:- Selected Cell IndexPath
    
    func getIndexPathForSelectedCell() -> NSIndexPath? {
        
        var indexPath:NSIndexPath?
        
        if collectionView.indexPathsForSelectedItems()!.count > 0 {
            indexPath = collectionView.indexPathsForSelectedItems()![0]
        }
        return indexPath
    }
    
    // MARK:- Highlight
    
    func highlightCell(indexPath : NSIndexPath, flag: Bool) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        
        if flag {
            cell?.contentView.backgroundColor = UIColor.magentaColor()
        } else {
            cell?.contentView.backgroundColor = nil
        }
    }
    
    // MARK:- Editing
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        collectionView?.allowsMultipleSelection = editing
        toolBar.hidden = !editing
    }
    
    // MARK:- Add Cell
    
    @IBAction func addNewItem(sender: AnyObject) {
        
        let index = dataSource3.addAndGetIndexForNewItem()
        let indexPath = NSIndexPath(forItem: index, inSection: 0)
        collectionView.insertItemsAtIndexPaths([indexPath])
    }
    
    
    @IBAction func deleteCells(sender: AnyObject) {
        
        var deletedFruits:[Fruit3] = []
        
        let indexpaths = collectionView?.indexPathsForSelectedItems()
        
        if let indexpaths = indexpaths {
            
            for item  in indexpaths {
                collectionView?.deselectItemAtIndexPath((item), animated: true)
                // fruits for section
                let sectionfruits = dataSource3.fruitsInGroup3(item.section)
                deletedFruits.append(sectionfruits[item.row])
            }
            
            dataSource3.deleteItems(deletedFruits)
            
            collectionView?.deleteItemsAtIndexPaths(indexpaths)
        }
    }
}

// MARK:- UICollectionView DataSource

extension ViewController3 : UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return dataSource3.groups3.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource3.numbeOfRowsInEachGroup(section)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell3 = collectionView.dequeueReusableCellWithReuseIdentifier(identifier3,forIndexPath:indexPath) as! SwaCell3
        
        let fruits3: [Fruit3] = dataSource3.fruitsInGroup3(indexPath.section)
        let fruit3 = fruits3[indexPath.row]
        
        let name3 = fruit3.name3!
        
        cell3.imageView3.image = UIImage(named: name3.lowercaseString)
        cell3.caption3.text = name3.capitalizedString
        
        return cell3
    }
    
    func collectionView(collectionView3: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let headerView3: SwaHeardView3 = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerViewIdentifier3, forIndexPath: indexPath) as! SwaHeardView3
        
        headerView3.sectionLabel.text = dataSource3.gettGroupLabelAtIndex(indexPath.section)
 
        return headerView3
    }
}

// MARK:- UICollectionViewDelegate Methods

extension ViewController3 : UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        highlightCell(indexPath, flag: true)
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        highlightCell(indexPath, flag: false)
    }
}

//extension ViewController: UICollectionViewDelegateFlowLayout {
// MARK:- UICollectioViewDelegateFlowLayout methods

//func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
//{


//    let length = (UIScreen.mainScreen().bounds.width-15)/2
//    return CGSizeMake(length,length);
//}
//}
