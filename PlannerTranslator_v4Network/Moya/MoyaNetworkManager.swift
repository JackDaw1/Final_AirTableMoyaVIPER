import Foundation
import Moya

final class MoyaNetworkManager {
    private var moyaProvider: AnyObject? = nil
    
    var headers: [String : String] {
        var headersDictionary = [String : String]()
        headersDictionary["accept"] = "text/plain"
        headersDictionary["content-type"] = "application/json; charset=utf-8"
        headersDictionary["Authorization"] = "Bearer keyqXSD5OCr0mUMb0"
        return headersDictionary
    }
    
    static let shared = MoyaNetworkManager()
    
    func mainRequest<T: WDTargetType>(_ request: T,
                                      withComplition completionHandler: @escaping (ResponseAPI) -> ()) {
        
        let endpointClosure = { (target: T) -> Endpoint in
            let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
            let url = (target.baseURL.absoluteString+target.path).removingPercentEncoding ?? ""
            
            return Endpoint(url: url, sampleResponseClosure: defaultEndpoint.sampleResponseClosure,
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        
        let provider = MoyaProvider<T>(endpointClosure: endpointClosure, stubClosure: MoyaProvider.neverStub)//, stubClosure: MoyaProvider.immediatelyStub)
        self.moyaProvider = provider
        provider.request(request) { result in
            switch result {
            case .success(let response):
                completionHandler(ResponseAPI(statusCode: 0, data: response.data))
            case .failure(let error):
                completionHandler(ResponseAPI(withError: error))
            }
        }
    }
}

