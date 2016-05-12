//
//  ViewController7.swift
//  FruitsDiet
//
//  Created by Alex Gr on 21.04.16.
//  Copyright © 2016 Ravi Shankar. All rights reserved.
//

import UIKit

class ViewController7: UIViewController {

    let identifier7 = "CellIdentifier7"
    let headerViewIdentifier7 = "HeaderView7"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    let dataSource7 = DataSource7()
    
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
            
            let fruit7 = dataSource7.fruitsInGroup7(indexPath.section)[indexPath.row]
            
            let detailViewController = segue.destinationViewController as! DetailViewController7
            detailViewController.fruit7 = fruit7
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
    
    }
// MARK:- UICollectionView DataSource

extension ViewController7 : UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return dataSource7.groups7.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource7.numbeOfRowsInEachGroup(section)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell7 = collectionView.dequeueReusableCellWithReuseIdentifier(identifier7,forIndexPath:indexPath) as! SwaCell7
        
        let fruits7: [Fruit7] = dataSource7.fruitsInGroup7(indexPath.section)
        let fruit7 = fruits7[indexPath.row]
        
        let name7 = fruit7.name7!
        
        cell7.imageView7.image = UIImage(named: name7.lowercaseString)
        cell7.caption7.text = name7.capitalizedString
        
        return cell7
    }
    
    func collectionView(collectionView6: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let headerView7: SwaHeardView7 = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerViewIdentifier7, forIndexPath: indexPath) as! SwaHeardView7
        
        headerView7.sectionLabel.text = dataSource7.gettGroupLabelAtIndex(indexPath.section)
        
        return headerView7
    }
}

// MARK:- UICollectionViewDelegate Methods

extension ViewController7 : UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        highlightCell(indexPath, flag: true)
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        highlightCell(indexPath, flag: false)
    }
}

