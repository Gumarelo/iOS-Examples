//
//  ViewController.swift
//  IceCreamShop
//
//  Created by Joshua Greene on 2/8/15.
//  Copyright (c) 2015 Razeware, LLC. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

public class PickFlavorViewController: UIViewController, UICollectionViewDelegate {
  
  // MARK: Instance Variables
  
  var flavors: [Flavor] = [] {
    
    // MARK: didSet is called immediately after the new value is stored.
    didSet {
      pickFlavorDataSource?.flavors = flavors
    }
  }
  
  private var pickFlavorDataSource: PickFlavorDataSource? {
    return collectionView?.dataSource as! PickFlavorDataSource?
  }
  
  private let flavorFactory = FlavorFactory()
  
  // MARK: Outlets
  
  @IBOutlet var contentView: UIView!
  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet var iceCreamView: IceCreamView!
  @IBOutlet var label: UILabel!
  
  // MARK: View Lifecycle
  
  public override func viewDidLoad() {
    
    super.viewDidLoad()
    loadFlavors()
  }
  
  private func loadFlavors() {
    
    showLoadingHUD()
    
    // 1 You use Alamofire to create a GET request and download a plist containing ice cream flavors.
    Alamofire.request(
      .GET, "http://www.raywenderlich.com/downloads/Flavors.plist",
      parameters: nil,
      encoding: .PropertyList(.XMLFormat_v1_0, 0), headers:nil)
      .responsePropertyList { [weak self] (_,_, result) -> Void in
        
        // 2 In order to break a strong reference cycle, you use a weak reference to self in the response completion block. Once the block executes, you immediately get a strong reference to self so that you can set properties on it later. You also create a flavorsArray variable to hold the plist array on success.
        guard let strongSelf = self else {
          return
        }
        
        strongSelf.hideLoadingHUD()
        
        var flavorsArray: [[String: String]]! = nil
        
        // 3 You next switch on result to determine whether the response was successful or not and get the values out of it.
        switch result {
          
        case .Success(let array):
          if let array = array as? [[String: String]] {
            flavorsArray = array
          }
        
        case .Failure(_, _):
          print("Couldn't download flavors!")
          return
        }
        
        // 4 If all goes well, you set self.flavors to an array of Flavor objects created by a FlavorFactory. This is a class that a colleague wrote for you, which takes an array of dictionaries and uses them to create instances of Flavor. Feel free to peruse the factory class if you’d like, but it’s not important for the rest of the tutorial.
        strongSelf.flavors = strongSelf.flavorFactory.flavorsFromDictionaryArray(flavorsArray)
        strongSelf.collectionView.reloadData()
        strongSelf.selectFirstFlavor()
        
    };
    
    
  }
  
  private func showLoadingHUD() {
    let hud = MBProgressHUD.showHUDAddedTo(contentView, animated: true)
    hud.labelText = "Loading"
  }
  
  private func hideLoadingHUD() {
    MBProgressHUD.hideAllHUDsForView(contentView, animated: true)
  }
  
  private func selectFirstFlavor() {
    
    if let flavor = flavors.first {
      updateWithFlavor(flavor)
    }
  }
  
  // MARK: UICollectionViewDelegate
  
  public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
    let flavor = flavors[indexPath.row]
    updateWithFlavor(flavor)
  }
  
  // MARK: Internal
  
  private func updateWithFlavor(flavor: Flavor) {
    
    iceCreamView.updateWithFlavor(flavor)
    label.text = flavor.name
  }
}
