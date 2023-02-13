import Foundation

extension Encodable {
    
    /// Encode into JSON and return `Data`
    func jsonData() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        return try encoder.encode(self)
    }
}

class OrdersModel {
    
    static func getDetailOfTask(
        id: String,
        completionHandler: @escaping (OrderItem) -> Void,
        errorHandler: @escaping (WDNetworkError) -> Void) {
            MoyaNetworkManager.shared.mainRequest(RequestType.ordersDetail(id)) { responseAPI in
                parseData(responseAPI: responseAPI,
                          type: SubMoyResponse<OrderItem>.self,
                          completion: { response in
                    switch response {
                    case .success(let result):
                        completionHandler(result.fields)
                    case .failure(let error):
                        errorHandler(error)
                    }
                })
            }
        }
    
    static func create(_ order: OrderItem,
                       completionHandler: @escaping (OrderItem?) -> Void,
                       errorHandler: @escaping ( WDNetworkError) -> Void) {
        
        MoyaNetworkManager.shared.mainRequest(RequestType.create(order)) { responseAPI in
            parseData(responseAPI: responseAPI,
                      type: MoyResponse<OrderItem>.self,
                      completion: { response in
                switch response {
                case .success(let result):
                    completionHandler(result.records.compactMap({ $0.fields }).first)
                case .failure(let error):
                    errorHandler(error)
                }
            })
        }
    }
    
    static func edit(_ order: OrderItem,
                     completionHandler: @escaping (OrderItem?) -> Void,
                     errorHandler: @escaping ( WDNetworkError) -> Void) {
        
        MoyaNetworkManager.shared.mainRequest(RequestType.edit(order)) { responseAPI in
            parseData(responseAPI: responseAPI,
                      type: MoyResponse<OrderItem>.self,
                      completion: { response in
                switch response {
                case .success(let result):
                    completionHandler(result.records.compactMap({ $0.fields }).first)
                case .failure(let error):
                    errorHandler(error)
                }
            })
        }
    }
    
    static func loadTasks(
        completionHandler: @escaping ([OrderItem]) -> Void,
        errorHandler: @escaping ( WDNetworkError) -> Void) {
            
            MoyaNetworkManager.shared.mainRequest(RequestType.orders) { responseAPI in
                parseData(responseAPI: responseAPI,
                          type: MoyResponse<OrderItem>.self,
                          completion: { response in
                    switch response {
                    case .success(let result):
                        completionHandler(result.records.compactMap({ $0.fields }))
                    case .failure(let error):
                        errorHandler(error)
                    }
                })
            }
        }
}
