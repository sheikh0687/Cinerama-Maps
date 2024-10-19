//
//  HomeVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 22/08/24.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var service_CollectionVw: UICollectionView!
    @IBOutlet weak var map_CollectionVw: UICollectionView!
    @IBOutlet weak var guideline_CollectionVw: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var search_Bar: UISearchBar!
    
    let viewModel = HomeViewModel()
    let countryMapVM = CountryMapApiViewModel()
    let guidelinesTipVM = GuidelineTipApiViewModel()
    let serviceVM = ServiceApiViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerResuableCellIdentifier()
        viewModel.setupSearchBar(for: search_Bar)
        requestCountryMap()
        requestGuidelineTip()
        requestServices()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func btn_Setting(_ sender: UIButton) {
        viewModel.navigateToSettingViewController(from: self.navigationController)
    }
    
    @IBAction func btn_Notify(_ sender: UIButton) {
        viewModel.navigateToNotificationViewController(from: self.navigationController)
    }
    
    @IBAction func btn_AddTrip(_ sender: UIButton) {
        viewModel.navigateToTripViewController(from: self.navigationController)
    }
    
    private func requestCountryMap()
    {
        countryMapVM.fetchCountryMaps(vC: self)
        countryMapVM.fethcedSuccessfully = { [] in
            DispatchQueue.main.async {
                self.map_CollectionVw.reloadData()
            }
        }
    }
    
    private func requestGuidelineTip()
    {
        guidelinesTipVM.fetchGuidelineTips(vC: self)
        guidelinesTipVM.fethcedSuccessfully = { [] in
            DispatchQueue.main.async {
                self.guideline_CollectionVw.reloadData()
            }
        }
    }
    
    private func requestServices()
    {
        serviceVM.requestToServices(vC: self)
        serviceVM.fetchedSuccesfully = { [] in
            DispatchQueue.main.async {
                self.pageControl.numberOfPages = self.serviceVM.arrayOfImages.count
                self.service_CollectionVw.reloadData()
            }
        }
    }
}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func registerResuableCellIdentifier()
    {
        self.service_CollectionVw.register(UINib(nibName: "ServiceCell", bundle: nil), forCellWithReuseIdentifier: "ServiceCell")
        self.map_CollectionVw.register(UINib(nibName: "MapCell", bundle: nil), forCellWithReuseIdentifier: "MapCell")
        self.guideline_CollectionVw.register(UINib(nibName: "GuidelineCell", bundle: nil), forCellWithReuseIdentifier: "GuidelineCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == service_CollectionVw {
            return serviceVM.arrayOfImages.count
        } else if collectionView == map_CollectionVw {
            return self.countryMapVM.arrayCountryMaps.count
        } else {
            return guidelinesTipVM.arrayGuidelinesTip.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == service_CollectionVw {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCell", for: indexPath) as! ServiceCell
            let obj_Image = serviceVM.arrayOfImages[indexPath.row]
            print(obj_Image)
            Utility.setImageWithSDWebImage(obj_Image, cell.service_Img)
            return cell
        } else if collectionView == map_CollectionVw {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapCell", for: indexPath) as! MapCell
            
            let obj = countryMapVM.arrayCountryMaps[indexPath.row]
            cell.lbl_CountryName.text = obj.name ?? ""
            
            if Router.BASE_IMAGE_URL != obj.image {
                Utility.setImageWithSDWebImage(obj.image ?? "", cell.CountryImage)
            } else {
                cell.CountryImage.image = R.image.no_Image_Available()
            }
            
            if Router.BASE_IMAGE_URL != obj.country_icon {
                Utility.setImageWithSDWebImage(obj.country_icon ?? "", cell.countryMap)
            } else {
                cell.CountryImage.image = R.image.no_Image_Available()
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GuidelineCell", for: indexPath) as! GuidelineCell
            
            let obj = self.guidelinesTipVM.arrayGuidelinesTip[indexPath.row]
            
            cell.lbl_Text.text = obj.title ?? ""
            
            if Router.BASE_IMAGE_URL != obj.image {
                Utility.setImageWithSDWebImage(obj.image ?? "", cell.img)
            } else {
                cell.img.image = R.image.no_Image_Available()
            }
            
            cell.cloMore = { () in
                self.viewModel.navigateToGuidlineViewController(from: self.navigationController, title: obj.title ?? "", dateTime: obj.date_time ?? "", description: obj.description ?? "")
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == service_CollectionVw {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        } else if collectionView == map_CollectionVw {
            return CGSize(width: 130, height: collectionView.frame.height)
        } else {
            return CGSize(width: 180, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == service_CollectionVw {
            self.viewModel.navigateToServicesViewController(from: self.navigationController)
        } else {
            self.viewModel.navigateToCityMapsViewController(from: self.navigationController, countryId: countryMapVM.arrayCountryMaps[indexPath.row].id ?? "")
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
           pageControl.currentPage = Int(pageIndex)
    }
}
