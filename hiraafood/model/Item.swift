import Foundation
class Item : Codable {
    var sku:String
    var name:String
    var category:String
    var price:Double
    var description:String
    var rating:Int
    var image:String
    
    
    init(sku:String, name:String,
         category:String,
         price:Double,
         desc:String?,
         rating:Int?,
         image:String?) {
        self.sku = sku
        self.name = name
        self.category = category
        self.price = price
        self.description = desc ?? ""
        self.rating = rating ?? 3
        self.image = image ?? ""
    }
    
    required init(from decoder: Decoder) throws {
        //print("---------------> calling Item decoder ")
        let container = try decoder.container(keyedBy:CodingKeys.self)
        self.sku      = try container.decode(String.self, forKey:.sku)
        self.name     = try container.decode(String.self, forKey:.name)
        self.category = try container.decode(String.self, forKey:.category)
        self.description = try container.decode(String.self, forKey:.description)
        self.image = try container.decode(String.self, forKey:.image)
        let priceS = try container.decode(String.self, forKey:.price)
        let ratingS = try container.decode(String.self, forKey:.rating)
        self.price = Double(priceS)!
        self.rating = Int(Double(ratingS) ?? 3.0)
     }
}
