//
//  ViewController.swift
//  FruitsDiet
//
//  Created by Ravi Shankar on 29/07/15.
//  Copyright (c) 2015 Ravi Shankar. All rights reserved.
//

import UIKit

class ViewController: UIViewController /*NSFetchedResultsControllerDelegate*/ {
    
    
    let identifier = "CellIdentifier"
    let headerViewIdentifier = "HeaderView"
    
    //let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    //var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()

    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let dataSource = DataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        OEPocketsphinxController.sharedInstance().stopListening()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //fetchedResultController = getFetchedResultController()
        //fetchedResultController.delegate = self
        //do {
        //    try fetchedResultController.performFetch()
        //} catch _ {
        //}
    }
    
    /*func getFetchedResultController() -> NSFetchedResultsController {
        fetchedResultController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
        
    }*/
    
    /*func taskFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "LevelFirstCoreect")
        let sortDescriptor = NSSortDescriptor(key: "correcthypothesis", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }*/


    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        OEPocketsphinxController.sharedInstance().stopListening()
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBarHidden = true

        if let indexPath = getIndexPathForSelectedCell() {
            highlightCell(indexPath, flag: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        OEPocketsphinxController.sharedInstance().stopListening()
    }
    
    // MARK:- prepareForSegue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // retrieve selected cell & fruit
        
        if let indexPath = getIndexPathForSelectedCell() {
            
            let fruit = dataSource.fruitsInGroup(indexPath.section)[indexPath.row]
            
            let detailViewController = segue.destinationViewController as! DetailViewController
            detailViewController.fruit = fruit
            
            //let taskController:ViewController = segue.destinationViewController as! ViewController
            //let task:LevelFirstCoreect = fetchedResultController.objectAtIndexPath(indexPath) as! LevelFirstCoreect
            //taskController.task = task
            
            return 
        }
    }
    
    // MARK:- Should Perform Segue
    
    //override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
   //     return !editing
    // }
    
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

extension ViewController : UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return dataSource.groups.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.numbeOfRowsInEachGroup(section)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier,forIndexPath:indexPath) as! FruitCell
        
        let fruits: [Fruit] = dataSource.fruitsInGroup(indexPath.section)
        let fruit = fruits[indexPath.row]
        
        let name = fruit.name!
        
        cell.imageView.image = UIImage(named: name.lowercaseString)
        cell.caption.text = name.capitalizedString
        
        //let task = fetchedResultController.objectAtIndexPath(indexPath) as! LevelFirstCoreect
        //cell.CorrectHypothesisStar = task.correcthypothesis
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let headerView: FruitsHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerViewIdentifier, forIndexPath: indexPath) as! FruitsHeaderView
        
        headerView.sectionLabel.text = dataSource.gettGroupLabelAtIndex(indexPath.section)
        
        return headerView
    }
}

// MARK:- UICollectionViewDelegate Methods

extension ViewController : UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        highlightCell(indexPath, flag: true)
        
        
    }
    
     func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        highlightCell(indexPath, flag: false)
    }
}



