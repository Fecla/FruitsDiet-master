//
//  ViewController4.swift
//  FruitsDiet
//
//  Created by Alex Gr on 20.04.16.
//  Copyright © 2016 Ravi Shankar. All rights reserved.
//

import UIKit

class ViewController4: UIViewController {
    
    let identifier4 = "CellIdentifier4"
    let headerViewIdentifier4 = "HeaderView4"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    let dataSource4 = DataSource4()
    
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
            
            let fruit4 = dataSource4.fruitsInGroup4(indexPath.section)[indexPath.row]
            
            let detailViewController = segue.destinationViewController as! DetailViewController4
            detailViewController.fruit4 = fruit4
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
        
        let index = dataSource4.addAndGetIndexForNewItem()
        let indexPath = NSIndexPath(forItem: index, inSection: 0)
        collectionView.insertItemsAtIndexPaths([indexPath])
    }
    
    
    @IBAction func deleteCells(sender: AnyObject) {
        
        var deletedFruits:[Fruit4] = []
        
        let indexpaths = collectionView?.indexPathsForSelectedItems()
        
        if let indexpaths = indexpaths {
            
            for item  in indexpaths {
                collectionView?.deselectItemAtIndexPath((item), animated: true)
                // fruits for section
                let sectionfruits = dataSource4.fruitsInGroup4(item.section)
                deletedFruits.append(sectionfruits[item.row])
            }
            
            dataSource4.deleteItems(deletedFruits)
            
            collectionView?.deleteItemsAtIndexPaths(indexpaths)
        }
    }
}

// MARK:- UICollectionView DataSource

extension ViewController4 : UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return dataSource4.groups4.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource4.numbeOfRowsInEachGroup(section)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell4 = collectionView.dequeueReusableCellWithReuseIdentifier(identifier4,forIndexPath:indexPath) as! SwaCell4
        
        let fruits4: [Fruit4] = dataSource4.fruitsInGroup4(indexPath.section)
        let fruit4 = fruits4[indexPath.row]
        
        let name4 = fruit4.name4!
        
        cell4.imageView4.image = UIImage(named: name4.lowercaseString)
        cell4.caption4.text = name4.capitalizedString
        
        return cell4
    }
    
    func collectionView(collectionView4: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let headerView4: SwaHeardView4 = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerViewIdentifier4, forIndexPath: indexPath) as! SwaHeardView4
        
        headerView4.sectionLabel.text = dataSource4.gettGroupLabelAtIndex(indexPath.section)
        
        return headerView4
    }
}

// MARK:- UICollectionViewDelegate Methods

extension ViewController4 : UICollectionViewDelegate {
    
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
