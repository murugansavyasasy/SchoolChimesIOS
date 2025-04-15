
    import UIKit
    import ObjectMapper
    class HomePaucktVC: UIViewController
    ,UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate,UICollectionViewDelegateFlowLayout{

        @IBOutlet weak var UsedCoinsLbl: UILabel!
        @IBOutlet weak var AllCouponsLbl: UILabel!
        @IBOutlet weak var BackBtn: UIButton!
    @IBOutlet weak var TotalcoinsFullView: UIView!

    @IBOutlet weak var reminingCoinsView: UIView!
        @IBOutlet weak var totalCoinsLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var categoriesCV: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!

    var offers: [Offer] = []


    enum SectionType: Int, CaseIterable {
    case firstCellType
    case secondCellType
    case thirdCellType
    }


    var secondArray: [Int] = [10, 20, 30, 40]
    var thirdArray: [Bool] = [true, false, true, false]
    var categories: [CategoryDatas] = []
    var CampaignData : [Campaign] = []
    var filteredOffers: [Campaign] = []

    override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .clear
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [
    UIColor(red: 1.0, green: 0.9, blue: 0.9, alpha: 1.0).cgColor,
    UIColor.white.cgColor
    ]
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
    gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
    gradientLayer.frame = collectionView.bounds

        let backgroundView = UIView(frame: collectionView.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = UIScreen.main.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
        collectionView.backgroundView = backgroundView
        
        TotalcoinsFullView.layer.cornerRadius = 12
        TotalcoinsFullView.layer.shadowColor = UIColor.black.cgColor
        TotalcoinsFullView.layer.shadowOpacity = 0.1
        TotalcoinsFullView.layer.shadowOffset = CGSize(width: 0, height: 2)
        TotalcoinsFullView.layer.shadowRadius = 4
        
        BackBtn.setTitleFont(style: .secondary, size: 15)
        totalCoinsLbl.setFont(style: .title, size: 17)
        UsedCoinsLbl.setFont(style: .body, size: 15)
        AllCouponsLbl.setFont(style: .title, size: 17)
        
        Get_Categories()
        setupCollectionView()
    //        fetchCategories()
    fetchCoupen()



    //               filteredOffers = offers
    //               collectionView.register(UINib(nibName: "CoupenCvCell", bundle: nil), forCellWithReuseIdentifier: "CoupenCvCell")


    }


    //    func fetchCategories() {
    //        // This is a mock setup. Replace this with API call if needed
    //        categories = [
    //            PaucktCategory(id: 1, name: "Technology", imageUrl: "http://stage-api.pauket.com/masters/categories/1691684337.png"),
    //            PaucktCategory(id: 2, name: "Healthcare", imageUrl: "http://stage-api.pauket.com/masters/categories/1686051712.png"),
    //            PaucktCategory(id: 3, name: "Theme Park", imageUrl: "https://stage-api.pauket.com/masters/demo.png")
    //        ]
    //
    //
    //        categoriesCV.delegate = self
    //        categoriesCV.dataSource = self
    //        categoriesCV.reloadData()
    //    }



    func fetchCoupen() {
    // This is a mock setup. Replace this with API call if needed
    offers = [
    Offer(title: "Opening Soon at Jalandhar", subtitle: "Hair Dressing, Beauty, Makeup", discount: "20% Off", locationInfo: "10 locations", durationInfo: "5 days", imageName: "saloon_image"),
    Offer(title: "Fun is Back", subtitle: "Get Ready to Dizzee!", discount: "20% Off", locationInfo: "10 locations", durationInfo: "5 days", imageName: "dizzee_image"),Offer(title: "Opening Soon at Jalandhar", subtitle: "Hair Dressing, Beauty, Makeup", discount: "20% Off", locationInfo: "10 locations", durationInfo: "5 days", imageName: "saloon_image"),
    Offer(title: "Fun is Back", subtitle: "Get Ready to Dizzee!", discount: "20% Off", locationInfo: "10 locations", durationInfo: "5 days", imageName: "dizzee_image"),Offer(title: "Opening Soon at Jalandhar", subtitle: "Hair Dressing, Beauty, Makeup", discount: "20% Off", locationInfo: "10 locations", durationInfo: "5 days", imageName: "saloon_image"),
    Offer(title: "Fun is Back", subtitle: "Get Ready to Dizzee!", discount: "20% Off", locationInfo: "10 locations", durationInfo: "5 days", imageName: "dizzee_image"),Offer(title: "Opening Soon at Jalandhar", subtitle: "Hair Dressing, Beauty, Makeup", discount: "20% Off", locationInfo: "10 locations", durationInfo: "5 days", imageName: "saloon_image"),
    Offer(title: "Fun is Back", subtitle: "Get Ready to Dizzee!", discount: "20% Off", locationInfo: "10 locations", durationInfo: "5 days", imageName: "dizzee_image")
    ]



    }
    func setupCollectionView() {
    //        categoriesCV.delegate = self
    //        categoriesCV.dataSource = self

    collectionView.register(UINib(nibName: "CoupenCvCell", bundle: nil), forCellWithReuseIdentifier: "CoupenCvCell")
    categoriesCV.register(UINib(nibName: "CaterogyCvCell", bundle: nil), forCellWithReuseIdentifier: "CaterogyCvCell")



    }
    @IBAction func  back(_ sender: UIButton) {
    dismiss(animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {


    if collectionView == categoriesCV{

    return categories.count
    }else{

        return filteredOffers.count
    }

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {


    if collectionView == categoriesCV{
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CaterogyCvCell", for: indexPath) as! CaterogyCvCell
    let caterogys = categories [indexPath.row]
    cell.configure(with: caterogys)
    return cell
    }else{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoupenCvCell", for: indexPath) as! CoupenCvCell
        //               cell.configure(with: thirdArray[indexPath.item])
        
        let offer = filteredOffers[indexPath.row]
        cell.titleLabel.text = offer.categoryName
        cell.subtitleLabel.text = offer.merchantName
        cell.discountLabel.text = offer.offer_to_show
        cell.locationLabel.text = "10 locations"
      
        
        let futureDateString = offer.endDate

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let futureDate = dateFormatter.date(from: futureDateString ?? "") {
            
            let currentDate = Date()
            
            // Calculate the difference in days using Calendar
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day], from: currentDate, to: futureDate)
            
            if let daysDifference = components.day {
                cell.durationLabel.text = String(daysDifference) + " days"
            } else {
                print("Couldn't calculate the difference in days.")
            }
        } else {
            print("Invalid date format.")
        }

       
        
    cell.backgroundImageView.sd_setImage(with: URL(string: offer.thumbnail ?? ""), placeholderImage: UIImage(named: ""))
    cell.brandImg.layer.cornerRadius = 12
        cell.brandImg.sd_setImage(with: URL(string: offer.merchant_logo ?? ""), placeholderImage: UIImage(named: ""))
    return cell

    }

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText.isEmpty {
    filteredOffers = CampaignData
    } else {
    filteredOffers = CampaignData.filter { $0.campaignName!.lowercased().contains(searchText.lowercased()) }
    }
    collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if collectionView == categoriesCV{
    let width = (collectionView.frame.width / 4) - 16
    return CGSize(width: width, height: 100)
    }else{
    return CGSize(width: collectionView.frame.width/2, height: 290)
    }

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    if collectionView != categoriesCV{
    let vc = CooponViewVC(nibName: nil, bundle: nil)
    vc.source_Link = filteredOffers[indexPath.row].sourceLink ?? ""
    vc.Category = filteredOffers[indexPath.row].categoryName
    vc.ThumbnailImg = filteredOffers[indexPath.row].thumbnail
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true)
    }
    }



    func Get_Categories(){

    let param : [String : Any] =
    ["": ""]
    print("paramparamm,nc",param)
    let headers: [String: Any] = [
    "api-key": "b9634e2c3aa9b6fdc392527645c43871",
    "Partner-Name": "voicesnaps"
    ]

    Get_Category_List.call_request(param: param,headers: headers ){ [self]
    (res) in

    print("resres",res)
    let getattendace : CategoriesResponse = Mapper<CategoriesResponse>().map(JSONString: res)!

    if getattendace.status == true  {

    categories = getattendace.data?.categories ?? []
    categoriesCV.delegate = self
    categoriesCV.dataSource = self
    categoriesCV.reloadData()
    Get_campians()

    }else{
    }
    }

    }


    func Get_campians(){


//    let param : [String : Any] =
//    ["Mobile_no": "8610786768"]
        let param : [String : Any] =
        ["mobile_no": "7550144367"]
    print("paramparamm,nc",param)
    let headers: [String: Any] = [
    "api-key": "b9634e2c3aa9b6fdc392527645c43871",
    "Partner-Name": "voicesnaps"
    ]

    Get_campians_Request.call_request(param: param,headers: headers ){ [self]
    (res) in

    print("resresesrgdrgdrgdrf",res)
    let getattendace : CampaignsResponse = Mapper<CampaignsResponse>().map(JSONString: res)!

    if getattendace.status == true  {

    CampaignData = getattendace.data?.campaigns?.data ?? []
    filteredOffers = CampaignData
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.reloadData()

    }else{
    }
    }

    }


    }

    struct Offer {
    let title: String
    let subtitle: String
    let discount: String
    let locationInfo: String
    let durationInfo: String
    let imageName: String
    }


    struct PaucktCategory {
    let id: Int
    let name: String
    let imageUrl: String
    }

