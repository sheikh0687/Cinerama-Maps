//
//  SubscriptionMapVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 25/10/24.
//

import UIKit
import GoogleMaps

class SubscriptionMapVC: UIViewController {
    
    @IBOutlet weak var lblCityHeadline: UILabel!
    
    @IBOutlet weak var GMMapView: GMSMapView!
    @IBOutlet weak var btn_MapOt: UIButton!
    @IBOutlet weak var btn_ListOt: UIButton!
    @IBOutlet weak var listTable_Vw: UITableView!
    
    let viewModel = SubscriptionMapViewModel()
    var bounds = GMSCoordinateBounds()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listTable_Vw.register(UINib(nibName: "SubscriptionListCell", bundle: nil), forCellReuseIdentifier: "SubscriptionListCell")
        self.tabBarController?.tabBar.isHidden = true
        btn_MapOt.setTitleColor(.white, for: .normal)
        btn_ListOt.setTitleColor(.black, for: .normal)
        btn_MapOt.backgroundColor = R.color.main()
        btn_ListOt.backgroundColor = .white
        self.GMMapView.isHidden = false
        self.listTable_Vw.isHidden = true
        self.lblCityHeadline.text = viewModel.cityName
        self.GMMapView.delegate = self
        bindViewModelData()
    }
    
    @IBAction func btn_MapAndList(_ sender: UIButton) {
        if sender.tag == 0 {
            btn_MapOt.setTitleColor(.white, for: .normal)
            btn_ListOt.setTitleColor(.black, for: .normal)
            btn_MapOt.backgroundColor = R.color.main()
            btn_ListOt.backgroundColor = .white
            self.GMMapView.isHidden = false
            self.listTable_Vw.isHidden = true
        } else {
            btn_MapOt.setTitleColor(.black, for: .normal)
            btn_ListOt.setTitleColor(.white, for: .normal)
            btn_MapOt.backgroundColor = .clear
            btn_ListOt.backgroundColor = R.color.main()
            self.GMMapView.isHidden = true
            self.listTable_Vw.isHidden = false
        }
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func bindViewModelData()
    {
        viewModel.requestCountryMapDetails(vC: self)
        viewModel.fetchedSuccessfully = { [weak self] in
            DispatchQueue.main.async {
                self?.listTable_Vw.reloadData()
                self?.updateAnnotations()
            }
        }
    }
    
    func updateAnnotations() {
        GMMapView.clear()
        for cityMap in viewModel.arrayOfPlaceDetails {
            let annotation = CustomPointAnnotation()
            annotation.position = CLLocationCoordinate2DMake(Double(cityMap.lat ?? "") ?? 0.0, Double(cityMap.lon ?? "") ?? 0.0)
            annotation.city_Address = cityMap.address
            annotation.placeId = cityMap.id
            annotation.lat = cityMap.lat
            annotation.lon = cityMap.lon
            bounds = bounds.includingCoordinate(annotation.position)
            
            GMMapView.setMinZoom(1, maxZoom: 15)//prevent to over zoom on fit and animate if bounds be too small
            
            let update = GMSCameraUpdate.fit(bounds, withPadding: 50)
            GMMapView.animate(with: update)
            
            GMMapView.setMinZoom(1, maxZoom: 20)
            DispatchQueue.main.async {
                annotation.map = self.GMMapView
            }
        }
    }
}

extension SubscriptionMapVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.arrayOfPlaceDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubscriptionListCell", for: indexPath) as! SubscriptionListCell
        let obj = self.viewModel.arrayOfPlaceDetails[indexPath.row]
        cell.lbl_Name.text = obj.place_name ?? ""
        cell.lbl_Address.text = obj.address ?? ""
        cell.lbl_LikeCount.text = obj.total_fav_place ?? ""
        cell.lbl_DislikeCount.text = obj.total_unfav_place ?? ""
        
        if obj.fav_status == "Like" {
            cell.btn_LikeCount.tintColor = #colorLiteral(red: 0.2039215686, green: 0.6588235294, blue: 0.3254901961, alpha: 1)
        } else if obj.fav_status == "Unlike" {
            cell.btn_DislikeCount.tintColor = .red
        } else {
            cell.btn_LikeCount.tintColor = .darkGray
            cell.btn_DislikeCount.tintColor = .darkGray
        }
        
        cell.cloLike = { [self] in
            self.viewModel.requestToFavUnfavPlace(vC: self, placeId: obj.id ?? "", status: "Like")
            self.viewModel.fetchedSuccessfully = { [] in
                DispatchQueue.main.async { [self] in
                    self.bindViewModelData()
                }
            }
        }
        
        cell.cloDisLike = { [self] in
            self.viewModel.requestToFavUnfavPlace(vC: self, placeId: obj.id ?? "", status: "Unlike")
            self.viewModel.fetchedSuccessfully = { [] in
                DispatchQueue.main.async { [self] in
                    self.bindViewModelData()
                }
            }
        }
        
        cell.arrayOfTag = obj.tag_details ?? []
        cell.tags_Collection.reloadData()
        return cell
    }
}

extension SubscriptionMapVC: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let customMarker = marker as? CustomPointAnnotation else { return false }
        
        // Show details popup for the selected marker
        _ = customMarker.title ?? ""
        let cityAddress = customMarker.city_Address ?? ""
        let cityPlaceId = customMarker.placeId ?? ""
        let cityAddressLat = customMarker.lat ?? ""
        let cityAddressLon = customMarker.lon ?? ""
        self.viewModel.navigateToGooglePlaceDetailViewController(from: navigationController!, cityAddress: cityAddress, cityPlaceId: cityPlaceId, cityAddressLat: cityAddressLat, cityAddressLon: cityAddressLon)
        return true
    }
}
