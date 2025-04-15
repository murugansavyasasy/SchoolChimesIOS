import ObjectMapper

// MARK: - CategoriesResponse
class CategoriesResponse: Mappable {
    var status: Bool?
    var message: String?
    var data: CategoryData?

    required init?(map: Map) {}

    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        data <- map["data"]
    }
}

// MARK: - CategoryData
class CategoryData: Mappable {
    var categories: [CategoryDatas]?
    var totalPages: Int?

    required init?(map: Map) {}

    func mapping(map: Map) {
        categories <- map["categories"]
        totalPages <- map["total_pages"]
    }
}

// MARK: - Category
class CategoryDatas: Mappable {
    var id: Int?
    var categoryName: String?
    var categoryImage: String?

    required init?(map: Map) {}

    func mapping(map: Map) {
        id <- map["id"]
        categoryName <- map["category_name"]
        categoryImage <- map["category_image"]
    }
}
