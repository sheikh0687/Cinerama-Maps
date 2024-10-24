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
    @IBOutlet weak var locationAddress_Vw: UIView!
    @IBOutlet weak var lbl_PlaceName: UILabel!
    @IBOutlet weak var lbl_PlaceAddress: UILabel!
    
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
        self.locationAddress_Vw.isHidden = true
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
    
    @IBAction func btn_ClosePlaceDt(_ sender: UIButton) {
        self.locationAddress_Vw.isHidden = true
    }
    
    private func bindDataFromVm()
    {
        viewModel.requestCountryMapDetails(vC: self)
        viewModel.fetchedSuccessfully = { [] in
            DispatchQueue.main.async {
                let obj = self.viewModel.arrayOfDetailCityMaps
                self.lbl_CityNAme.text = obj?.name
                self.lbl_Amount.text = "\(obj?.city_map_price ?? "") SAR for \(obj?.city_map_month ?? "") Month"
                self.ratingVw.rating = Double(obj?.place_details?[0].avg_rating ?? "") ?? 0.0
                self.lbl_RatingReview.text = obj?.place_details?[0].avg_rating ?? ""
                self.lbl_CityAddress.text = obj?.address
                self.lbl_AboutCity.text = obj?.about_city
                self.lbl_Currrency.text = obj?.currency
                self.lbl_Language.text = obj?.offical_language
                self.lbl_Clothing.text = obj?.clothing
                self.lbl_Timing.text = obj?.best_time_to_visit
                self.lbl_Health.text = obj?.health
                self.lbl_ElectricSocket.text = obj?.electrical_socket
                self.lbl_Communication.text = obj?.communications
                self.lbl_Weather.text = obj?.the_waether
                self.lbl_PoliceCarNum.text = obj?.car_police_number
                self.lbl_PolicePhoneNum.text = obj?.police_number
                
                let placeImg = obj?.image
                let imageUrl = Router.BASE_IMAGE_URL + (placeImg ?? "")
                
                if Router.BASE_IMAGE_URL != imageUrl {
                    Utility.setImageWithSDWebImage(imageUrl, self.img_DetailMap)
                } else {
                    self.img_DetailMap.image = R.image.no_Image_Available()
                }
                
                self.updateAnnotations()
                self.rating_TableVw.reloadData()
            }
        }
    }
    
    func updateAnnotations() {
        mapView.removeAnnotations(mapView.annotations)
        for cityMap in viewModel.arrayOfDetailCityMaps.place_details ?? [] {
            let coordinate = CLLocationCoordinate2D(
                latitude: Double(cityMap.lat ?? "") ?? 0.0,
                longitude: Double(cityMap.lon ?? "") ?? 0.0
            )
            let annotation = CustomPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = cityMap.place_name
            annotation.imageName = cityMap.icon
            annotation.city_Address = cityMap.address
            mapView.addAnnotation(annotation)
        }
        Utility.zoomMapToAnnotations(mapView)
    }
}

extension AllMapsDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.arrayOfReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
        
        let obj = self.viewModel.arrayOfReviews[indexPath.row]
        cell.lbl_Name.text = obj.user_name ?? ""
        cell.lbl_Date.text = obj.date_time ?? ""
        cell.lbl_Message.text = obj.review ?? ""
        cell.ratingStar.rating = Double(obj.rating ?? "") ?? 0.0
        cell.ratingCount.text = obj.rating ?? ""
        
        if Router.BASE_IMAGE_URL != obj.image {
            Utility.setImageWithSDWebImage(obj.image ?? "", cell.user_Img)
        } else {
            cell.user_Img.image = R.image.no_Image_Available()
        }
        
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

extension AllMapsDetailVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // Handle the tap action on the selected annotation view here
        guard let annotation = view.annotation as? CustomPointAnnotation else {
            return
        }
        
        // Show details for the selected annotation
        let cityName = annotation.title ?? ""
        let cityAddress = annotation.city_Address ?? ""
        let cityIcon = annotation.imageName ?? ""
        showDetailsPopup(city_Name: cityName, city_Address: cityAddress, city_Icon: cityIcon)
    }
    
    func showDetailsPopup(city_Name: String, city_Address: String, city_Icon: String) {
        // Example: Instantiate and display a custom popup view controller
        self.locationAddress_Vw.isHidden = false
        self.lbl_PlaceName.text = city_Name
        self.lbl_PlaceAddress.text = city_Address
    }
    
    // MKMapViewDelegate method to customize overlays (polylines)
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let gradientColors = [ hexStringToUIColor(hex: "#000000"), hexStringToUIColor(hex: "#000000")]
        
        /// Initialise a GradientPathRenderer with the colors
        let polylineRenderer = GradientPathRenderer(polyline: overlay as! MKPolyline, colors: gradientColors)
        
        /// set a linewidth
        polylineRenderer.lineWidth = 7
        return polylineRenderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        guard let customAnnotation = annotation as? CustomPointAnnotation else {
            return nil
        }
        
        let identifier = "CustomViewAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: customAnnotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = customAnnotation
        }
        
        if let imageName = customAnnotation.imageName {
            Utility.downloadImageBySDWebImage(imageName) { image, error in
                if let image = image, error == nil {
                    // Set the desired width and height for the circular image
                    let size = CGSize(width: 40, height: 40) // Adjust size as needed
                    let circularImage = image.circularImage(with: size)
                    annotationView?.image = circularImage
                } else {
                    let placeHolderImg = R.image.no_Image_Available()
                    let size = CGSize(width: 40, height: 40)
                    let circularImage = placeHolderImg?.circularImage(with: size)
                    annotationView?.image = circularImage
                }
            }
        } else {
            let placeHolderImg = R.image.no_Image_Available()
            let size = CGSize(width: 40, height: 40)
            let circularImage = placeHolderImg?.circularImage(with: size)
            annotationView?.image = circularImage
        }
        return annotationView
    }
}
