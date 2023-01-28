import Foundation

class CustomerAPI {
    
    private init() {}
    public static let shared = CustomerAPI()
    
    public private(set) var customers: [CustomerItem] = [
        
        CustomerItem(name: "proglib", info: "name_proglib", contact1: "@telegram", contact2: "proglib@proglib.com"),
        
        CustomerItem(name: "medium", info: "name_medium", contact1: "@medium", contact2: "medium@medium.com"),
        
    ]
    
    func addCustomer(_ customer: CustomerItem) {
        customers.append(customer)
    }
    
    func removeCustomer(_ customer: CustomerItem) {
        if let index = customers.firstIndex(where: { $0 === customer }) {
            customers.remove(at: index)
        }
    }
    
    static func createTestDate(value: String) -> Date? {
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd"
        RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        //let string = "1996-12-19T16:39:57-08:00"
        return RFC3339DateFormatter.date(from: value)
    }
    
}
