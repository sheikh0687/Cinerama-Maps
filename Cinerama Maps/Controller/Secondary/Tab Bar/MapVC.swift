//
//  MapVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 22/08/24.
//

import UIKit

class MapVC: UIViewController {
    
    @IBOutlet weak var map_Collection: UICollectionView!
    @IBOutlet weak var collection_Height: NSLayoutConstraint!
    @IBOutlet weak var search_Bar: UISearchBar!
    
    let viewModel = MapViewModel()
    let countryMapVM = CountryMapApiViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setupSearchBar(for: search_Bar)
        self.map_Collection.register(UINib(nibName: "MapCell", bundle: nil), forCellWithReuseIdentifier: "MapCell")
        requestCountryMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func requestCountryMap()
    {
        countryMapVM.fetchCountryMaps(vC: self)
        countryMapVM.fethcedSuccessfully = { [] in
            DispatchQueue.main.async {
                self.map_Collection.reloadData()
            }
        }
    }
}

extension MapVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.countryMapVM.arrayCountryMaps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapCell", for: indexPath) as! MapCell
        let numberOfItemsInRow = 2 // You can adjust this based on your layout
        let numberOfRows = (self.countryMapVM.arrayCountryMaps.count + numberOfItemsInRow - 1) / numberOfItemsInRow
        let cellHeight: CGFloat = 160
        self.collection_Height.constant = CGFloat(numberOfRows) * cellHeight
        
        let obj = self.countryMapVM.arrayCountryMaps[indexPath.row]
        
        cell.lbl_CountryName.text = obj.name ?? ""
        
        if Router.BASE_IMAGE_URL != obj.image {
            Utility.setImageWithSDWebImage(obj.image ?? "", cell.CountryImage)
        }
        
        if Router.BASE_IMAGE_URL != obj.country_icon {
            Utility.setImageWithSDWebImage(obj.country_icon ?? "", cell.countryMap)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWd = collectionView.frame.width
        return CGSize(width: collectionWd / 2, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.navigateToCityMapsViewController(from: self.navigationController, countryId: self.countryMapVM.arrayCountryMaps[indexPath.row].id ?? "")
    }
}
