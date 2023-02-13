import Foundation
import Moya

extension RequestType {
    var sampleData: Data {
        switch self {

        case .ordersDetail:
            return """
                {
                "nameOfArticle": "SQL Tutorial",
                "customer": "proglib",
                "price": 100,
                "numberOfSigns": 1500
                }
                """.data(using: String.Encoding.utf8)!

        case .orders:
            return """
                [
                                {
                                "nameOfArticle": "SQL Tutorial",
                                "customer": "proglib",
                                "price": 100,
                                "numberOfSigns": 1500
                                },
                                {
                                "nameOfArticle": "iOS Tutorial",
                                "customer": "habr",
                                "price": 200,
                                "numberOfSigns": 1500
                                }
                ]
                """.data(using: String.Encoding.utf8)!
        case .create:
            return """
                                {
                                "nameOfArticle": "SQL Tutorial",
                                "customer": "proglib",
                                "price": 100,
                                "numberOfSigns": 1500
                                },
                                {
                                "nameOfArticle": "iOS Tutorial",
                                "customer": "habr",
                                "price": 200,
                                "numberOfSigns": 1500
                                }
                """.data(using: String.Encoding.utf8)!
        default:
            return Data()
        }
    }
}

