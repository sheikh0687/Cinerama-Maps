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
    @IBOutlet weak var cityMap_Table: UITableView!
    @IBOutlet weak var tableVw_Height: NSLayoutConstraint!
    
    @IBOutlet weak var mapTypeVw: UIView!
    @IBOutlet weak var suggestBoxVw: UIStackView!
    
    @IBOutlet weak var map_HeadingVw: UIView!
    @IBOutlet weak var subscription_HeadingVw: UIView!
    
    @IBOutlet weak var search_Bar: UISearchBar!
    @IBOutlet weak var btn_AllMapOt: UIButton!
    @IBOutlet weak var btn_MyMapOt: UIButton!
    
    @IBOutlet weak var lbl_MapText: UILabel!
    @IBOutlet weak var lbl_ChooseCity: UILabel!
    
    let viewModel = MapViewModel()
    let countryMapVM = CountryMapApiViewModel()
    let cityMapVM = PurchasedCityViewModel()
    
    var decided_Ui = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setupSearchBar(for: search_Bar)
        self.map_Collection.register(UINib(nibName: "MapCell", bundle: nil), forCellWithReuseIdentifier: "MapCell")
        self.cityMap_Table.register(UINib(nibName: "CityMapCell", bundle: nil), forCellReuseIdentifier: "CityMapCell")
        self.map_Collection.isHidden = false
        self.cityMap_Table.isHidden = true
        
        if decided_Ui == "Subscription" {
            self.mapTypeVw.isHidden = true
            self.suggestBoxVw.isHidden = true
            self.map_HeadingVw.isHidden = true
            self.subscription_HeadingVw.isHidden = false
        } else {
            self.mapTypeVw.isHidden = false
            self.suggestBoxVw.isHidden = false
            self.map_HeadingVw.isHidden = false
            self.subscription_HeadingVw.isHidden = true
        }
        
        requestCountryMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        if decided_Ui == "Subscription" {
            self.tabBarController?.tabBar.isHidden = true
        } else {
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
    
    func requestCityMaps()
    {
        cityMapVM.fetchPurchaseCityMap(vC: self, tableHeight: tableVw_Height)
        cityMapVM.requestSuccessfull = { [] in
            DispatchQueue.main.async {
                self.cityMap_Table.reloadData()
            }
        }
    }
    
    @IBAction func btn_MapType(_ sender: UIButton) {
        if sender.tag == 0 {
            btn_AllMapOt.setTitleColor(.white, for: .normal)
            btn_MyMapOt.setTitleColor(.black, for: .normal)
            btn_AllMapOt.backgroundColor = R.color.main()
            btn_MyMapOt.backgroundColor = .clear
            self.map_Collection.isHidden = false
            self.cityMap_Table.isHidden = true
            requestCountryMap()
        } else {
            btn_AllMapOt.setTitleColor(.black, for: .normal)
            btn_MyMapOt.setTitleColor(.white, for: .normal)
            btn_AllMapOt.backgroundColor = .clear
            btn_MyMapOt.backgroundColor = R.color.main()
            self.map_Collection.isHidden = true
            self.cityMap_Table.isHidden = false
            requestCityMaps()
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
        viewModel.navigateToCityMapsViewController(from: self.navigationController, countryId: self.countryMapVM.arrayCountryMaps[indexPath.row].id ?? "", countryName: self.countryMapVM.arrayCountryMaps[indexPath.row].name ?? "")
    }
}

extension MapVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityMapVM.arrayOfPurchasedCityMap.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityMapCell", for: indexPath) as! CityMapCell
        
        let obj = self.cityMapVM.arrayOfPurchasedCityMap[indexPath.row]
        cell.lbl_CountryName.text = obj.name ?? ""
        cell.lbl_Rating.text = obj.avg_rating ?? ""
        cell.lbl_Address.text = obj.address ?? ""
        cell.rating_Vw.rating = Double(obj.avg_rating ?? "") ?? 0.0
        
        if Router.BASE_IMAGE_URL != obj.image {
            Utility.setImageWithSDWebImage(obj.image ?? "", cell.img)
        } else {
            cell.img.image = R.image.no_Image_Available()
        }
        
        if obj.fav_status == "Yes" {
            cell.btn_FavOt.tintColor = R.color.main()
        } else {
            cell.btn_FavOt.tintColor = .lightGray
        }
        
        cell.cloFav = { [] in
            self.cityMapVM.fetchFavAndUnFavMap(vC: self, cityId: obj.id ?? "")
            self.cityMapVM.requestSuccessfull = { [] in
                self.requestCityMaps()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
