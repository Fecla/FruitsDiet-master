//
//  ViewCotroller6.swift
//  FruitsDiet
//
//  Created by Alex Gr on 21.04.16.
//  Copyright © 2016 Ravi Shankar. All rights reserved.
//

import UIKit


class ViewController6: UIViewController {

    let identifier6 = "CellIdentifier6"
    let headerViewIdentifier6 = "HeaderView6"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    let dataSource6 = DataSource6()
    
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
            
            let fruit6 = dataSource6.fruitsInGroup6(indexPath.section)[indexPath.row]
            
            let detailViewController = segue.destinationViewController as! DetailViewController6
            detailViewController.fruit6 = fruit6
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
    
    //@IBAction func addNewItem(sender: AnyObject) {
        
    //    let index = dataSource6.addAndGetIndexForNewItem()
    //    let indexPath = NSIndexPath(forItem: index, inSection: 0)
    //    collectionView.insertItemsAtIndexPaths([indexPath])
    //}
    
    
    /*@IBAction func deleteCells(sender: AnyObject) {
        
        var deletedFruits:[Fruit6] = []
        
        let indexpaths = collectionView?.indexPathsForSelectedItems()
        
        if let indexpaths = indexpaths {
            
            for item  in indexpaths {
                collectionView?.deselectItemAtIndexPath((item), animated: true)
                // fruits for section
                let sectionfruits = dataSource6.fruitsInGroup6(item.section)
                deletedFruits.append(sectionfruits[item.row])
            }
            
            //dataSource6.deleteItems(deletedFruits)
            
            collectionView?.deleteItemsAtIndexPaths(indexpaths)
        }
    }*/
}

// MARK:- UICollectionView DataSource

extension ViewController6 : UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return dataSource6.groups6.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource6.numbeOfRowsInEachGroup(section)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell6 = collectionView.dequeueReusableCellWithReuseIdentifier(identifier6,forIndexPath:indexPath) as! SwaCell6
        
        let fruits6: [Fruit6] = dataSource6.fruitsInGroup6(indexPath.section)
        let fruit6 = fruits6[indexPath.row]
        
        let name6 = fruit6.name6!
        
        cell6.imageView6.image = UIImage(named: name6.lowercaseString)
        cell6.caption6.text = name6.capitalizedString
        
        return cell6
    }
    
    func collectionView(collectionView6: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let headerView6: SwaHeardView6 = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerViewIdentifier6, forIndexPath: indexPath) as! SwaHeardView6
        
        headerView6.sectionLabel.text = dataSource6.gettGroupLabelAtIndex(indexPath.section)
        
        return headerView6
    }
}

// MARK:- UICollectionViewDelegate Methods

extension ViewController6 : UICollectionViewDelegate {
    
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

    
    

