import Foundation

class OrderItem {
    var link: String?
    var deadline: Date?
    var made: Bool
    var paid: Bool?
    var name: String
    var price: Double?
    var numberOfSigns: Int64?
    var customer: String?
    var time: Int64? //!!
    
    init(link: String?,
        deadline: Date?,
        made: Bool = false,
        paid: Bool?,
        name: String,
        price: Double?,
        numberOfSigns: Int64?,
        customer:String?,
        time: Int64? = nil) {
        self.deadline = deadline
        self.made = made
        self.paid = paid
        self.name = name
        self.price = price
        self.numberOfSigns = numberOfSigns
        self.customer = customer
        self.time = time
    }
}
