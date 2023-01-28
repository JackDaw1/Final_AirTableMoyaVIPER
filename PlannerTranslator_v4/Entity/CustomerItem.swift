import Foundation

class CustomerItem {
    var name: String
    var info: String?
    var contact1: String?
    var contact2: String?
    
    init(name: String, info: String?, contact1: String?, contact2: String?) {
        self.name = name
        self.info = info
        self.contact1 = contact1
        self.contact2 = contact2
    }
}
