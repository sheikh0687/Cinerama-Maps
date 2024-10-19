//
//  AllMapsDetailVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 28/08/24.
//

import Cosmos
import MapKit

enum MapDetailTab: Int {
    case aboutMap = 0
    case place
    case review
    case images
}

class AllMapsDetailVC: UIViewController {
    
    //    Mark SubView Outlet
    @IBOutlet var labelLine1: UILabel!
    @IBOutlet var labelLine2: UILabel!
    @IBOutlet var labelLine3: UILabel!
    @IBOutlet var labelLine4: UILabel!
    
    //    Mark SubView Outlet
    @IBOutlet weak var btn_AboutMap: UIButton!
    @IBOutlet weak var btn_Place: UIButton!
    @IBOutlet weak var btn_Review: UIButton!
    @IBOutlet weak var btn_Images: UIButton!
    
    //    Mark SubView Outlet
    @IBOutlet weak var aboutCity_Vw: UIView!
    @IBOutlet weak var map_Vw: UIView!
    @IBOutlet weak var review_Vw: UIView!
    @IBOutlet weak var images_Vw: UIView!
    
    //    Mark SubView Outlet
    @IBOutlet weak var img_DetailMap: UIImageView!
    @IBOutlet weak var lbl_CityNAme: UILabel!
    @IBOutlet weak var lbl_Amount: UILabel!
    @IBOutlet weak var ratingVw: CosmosView!
    @IBOutlet weak var lbl_RatingReview: UILabel!
    @IBOutlet weak var lbl_CityAddress: UILabel!
    
    //    Mark About City View Outlet's
    @IBOutlet weak var lbl_AboutCity: UILabel!
    @IBOutlet weak var lbl_Currrency: UILabel!
    @IBOutlet weak var lbl_Language: UILabel!
    @IBOutlet weak var lbl_Clothing: UILabel!
    @IBOutlet weak var lbl_Timing: UILabel!
    @IBOutlet weak var lbl_Health: UILabel!
    @IBOutlet weak var lbl_ElectricSocket: UILabel!
    @IBOutlet weak var lbl_Communication: UILabel!
    @IBOutlet weak var lbl_Weather: UILabel!
    @IBOutlet weak var lbl_PoliceCarNum: UILabel!
    @IBOutlet weak var lbl_PolicePhoneNum: UILabel!
    
    //    Mark MapView Outlet
    @IBOutlet weak var mapView: MKMapView!
    
    //    Mark RatingView Outlet
    @IBOutlet weak var rating_TableVw: UITableView!
    
    //    Mark ImagesView Outlet
    @IBOutlet weak var images_CollectionVw: UICollectionView!
    
    let viewModel = AllMapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rating_TableVw.register(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: "ReviewCell")
        self.images_CollectionVw.register(UINib(nibName: "MapCell", bundle: nil), forCellWithReuseIdentifier: "MapCell")
        selectTab(.aboutMap)
        bindDataFromVm()
    }
    
    @IBAction func allPlaceDetailButton(_ sender: UIButton) {
        guard let selectedTab = MapDetailTab(rawValue: sender.tag) else { return }
        selectTab(selectedTab)
    }
    
    private func selectTab(_ tab: MapDetailTab) {
        let selectedColor = hexStringToUIColor(hex: "#008200")
        let defaultColor = UIColor.darkGray
        
        btn_AboutMap.setTitleColor(tab == .aboutMap ? selectedColor : defaultColor, for: .normal)
        btn_Place.setTitleColor(tab == .place ? selectedColor : defaultColor, for: .normal)
        btn_Review.setTitleColor(tab == .review ? selectedColor : defaultColor, for: .normal)
        btn_Images.setTitleColor(tab == .images ? selectedColor : defaultColor, for: .normal)
        
        labelLine1.backgroundColor = tab == .aboutMap ? selectedColor : .clear
        labelLine2.backgroundColor = tab == .place ? selectedColor : .clear
        labelLine3.backgroundColor = tab == .review ? selectedColor : .clear
        labelLine4.backgroundColor = tab == .images ? selectedColor : .clear
        
        aboutCity_Vw.isHidden = tab != .aboutMap
        map_Vw.isHidden = tab != .place
        review_Vw.isHidden = tab != .review
        images_Vw.isHidden = tab != .images
    }
    
    @IBAction func btn_Subscribe(_ sender: UIButton) {
        viewModel.navigateToSubcribeViewController(from: self.navigationController)
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        viewModel.returnBackk(from: self.navigationController)
    }
    
    private func bindDataFromVm()
    {
        viewModel.requestCountryMapDetails(vC: self)
        viewModel.fetchedSuccessfully = {[] in
            DispatchQueue.main.async {
                self.lbl_CityNAme.text = self.viewModel.cityName
                self.ratingVw.rating = self.viewModel.ratingReviewStar
                self.lbl_RatingReview.text = self.viewModel.ratingReviewCount
                self.lbl_CityAddress.text = self.viewModel.address
                self.lbl_AboutCity.text = self.viewModel.aboutCity
                self.lbl_Currrency.text = self.viewModel.countryCurrency
                self.lbl_Language.text = self.viewModel.countryOfficialLanguage
                self.lbl_Clothing.text = self.viewModel.clothing
                self.lbl_Timing.text = self.viewModel.bestVisitTiming
                self.lbl_Health.text = self.viewModel.health
                self.lbl_ElectricSocket.text = self.viewModel.electric
                self.lbl_Communication.text = self.viewModel.communication
                self.lbl_Weather.text = self.viewModel.wealther
                self.lbl_PoliceCarNum.text = self.viewModel.policeCarNum
                self.lbl_PolicePhoneNum.text = self.viewModel.policePhoneNum
            }
        }
    }
}

extension AllMapsDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
        return cell
    }
}

extension AllMapsDetailVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapCell", for: indexPath) as! MapCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.frame.width
        return CGSize(width: collectionWidth / 2, height: 110)
    }
}
