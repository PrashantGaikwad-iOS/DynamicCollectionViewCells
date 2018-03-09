//
//  ViewController.swift
//  Day-18 SortableCollectionView
//
//  Created by Prashant Gaikwad on 2/15/18.
//  Copyright © 2018 Prashant Gaikwad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var sortableCollectionView: UICollectionView!
  
  let sectionInsets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
  let itemsPerRow: CGFloat = 3
  var collectionViewData : [String] = ["Day 1","Day 2","Day 3","Day 4","Day 5","Day 6","Day 7","Day 8","Day 9","Day 10",
                                      "Day 11","Day 12","Day 13","Day 14","Day 15","Day 16","Day 17","Day 18","Day 19","Day 20",
                                      "Day 21","Day 22","Day 23","Day 24","Day 25"]
  
  fileprivate var longPressGesture: UILongPressGestureRecognizer!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture:)))
    sortableCollectionView.addGestureRecognizer(longPressGesture)
  }

  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

//MARK: - Other Methods
extension ViewController {
  
  //Method to handle tap gesture on collectionView
  @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
    switch(gesture.state) {
      
    case .began:
      guard let selectedIndexPath = sortableCollectionView.indexPathForItem(at: gesture.location(in: sortableCollectionView)) else {
        break
      }
      sortableCollectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
    case .changed:
      sortableCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
    case .ended:
      sortableCollectionView.endInteractiveMovement()
    default:
      sortableCollectionView.cancelInteractiveMovement()
    }
  }
  
}

//MARK: - CollectionView Methods
extension ViewController : UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    print(sourceIndexPath.item)
    print(destinationIndexPath.item)
    
    let temp = self.collectionViewData[sourceIndexPath.item]
    let sourceItem = self.collectionViewData[destinationIndexPath.item]
    self.collectionViewData[sourceIndexPath.item] = sourceItem
    self.collectionViewData[destinationIndexPath.item] = temp
    
    self.sortableCollectionView.reloadData()
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
      let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
      let availableWidth = collectionView.frame.width - paddingSpace
      let widthPerItem = availableWidth / itemsPerRow
    
      return CGSize(width: widthPerItem, height: widthPerItem)
    
  }
  
  //3
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }
  
  // 4
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.left
  }
  
  
}


extension ViewController : UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
  }
  
}

extension ViewController : UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 25
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sortCell", for: indexPath) as! SortCollectionViewCell
    cell.numLabel.text = self.collectionViewData[indexPath.row]
    return cell
  }
  
}

//MARK: - CollectionViewCell Class
class SortCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var numLabel: UILabel!
  
}


