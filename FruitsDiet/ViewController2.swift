//
//  ViewController2.swift
//  FruitsDiet
//
//  Created by Alex Gr on 19.04.16.
//  Copyright © 2016 Ravi Shankar. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    let identifier2 = "CellIdentifier2"
    let headerViewIdentifier2 = "HeaderView2"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let dataSource2 = DataSource2()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        navigationItem.leftBarButtonItem = editButtonItem()
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        
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
            
            let fruit2 = dataSource2.fruitsInGroup2(indexPath.section)[indexPath.row]
            
            let detailViewController = segue.destinationViewController as! DetailViewController2
            detailViewController.fruit2 = fruit2
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
    
    @IBAction func deleteCells(sender: AnyObject) {
        
        var deletedFruits:[Fruit2] = []
        
        let indexpaths = collectionView?.indexPathsForSelectedItems()
        
        if let indexpaths = indexpaths {
            
            for item  in indexpaths {
                collectionView?.deselectItemAtIndexPath((item), animated: true)
                // fruits for section
                let sectionfruits = dataSource2.fruitsInGroup2(item.section)
                deletedFruits.append(sectionfruits[item.row])
            }
            
            dataSource2.deleteItems(deletedFruits)
            
            collectionView?.deleteItemsAtIndexPaths(indexpaths)
        }
    }
}

// MARK:- UICollectionView DataSource

extension ViewController2 : UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return dataSource2.groups2.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource2.numbeOfRowsInEachGroup(section)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell2 = collectionView.dequeueReusableCellWithReuseIdentifier(identifier2,forIndexPath:indexPath) as! SwaCell2
        
        let fruits2: [Fruit2] = dataSource2.fruitsInGroup2(indexPath.section)
        let fruit2 = fruits2[indexPath.row]
        
        let name2 = fruit2.name2!
        
        cell2.imageView2.image = UIImage(named: name2.lowercaseString)
        cell2.caption2.text = name2.capitalizedString
        
        return cell2
    }
    
    func collectionView(collectionView2: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let headerView2: SwaHeaderView2 = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerViewIdentifier2, forIndexPath: indexPath) as! SwaHeaderView2
        
        headerView2.sectionLabel.text = dataSource2.gettGroupLabelAtIndex(indexPath.section)
        
        return headerView2
    }
}

// MARK:- UICollectionViewDelegate Methods

extension ViewController2 : UICollectionViewDelegate {
    
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








