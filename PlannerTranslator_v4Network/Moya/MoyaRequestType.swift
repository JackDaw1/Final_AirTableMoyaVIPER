import Foundation
import Moya

/*согласно принципу разделения интерфейсов лучше не помещать все запросы в один сервис
 RequestType — это наш будущий сервис со всеми запросами.
 */
public typealias RequestParametersType = (apiStringURL: String, body: [String: Any]?)

//типы запросов
enum RequestType {
    case orders
    case ordersDetail(String)
    case create(OrderItem)
    case edit(OrderItem)
}

//TargetType - Протокол, используемый для определения спецификаций, необходимых для файла MoyaProvider.
protocol WDTargetType: TargetType, Hashable {
    
}

extension RequestType: WDTargetType {
    static func == (lhs: RequestType, rhs: RequestType) -> Bool {
        lhs.path == rhs.path
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(path)
        hasher.combine(method)
    }
    //адрес сервера, на котором лежит RESTful API
    var baseURL: URL {
        URL(string: "https://api.airtable.com/v0/appuggJ5PZ3FDUE2G/")!
    }
    //роуты запросов
    var path: String {
        switch self {
        case .orders:
            return "PlannerTranslator"
        case .ordersDetail:
            return "PlannerTranslator"
        case .create:
            return "PlannerTranslator"
        case .edit:
            return "PlannerTranslator"
        }
    }
    // метод, который мы посылаем. Moya берёт все методы из Alamofire.
    var method: Moya.Method {
        switch self {
        case .orders, .ordersDetail:
            return Moya.Method.get
        case .create:
            return Moya.Method.post
        case .edit:
            return Moya.Method.patch
        }
    }
    
    //1) кодировка параметров, также берётся из Alamofire.
    //2) описание задач, которые буду выполняться
    var task: Task {
        switch self {
        case .orders:
            return .requestParameters(
                parameters: ["maxRecords":20,
                             "view":"Order"],
                encoding: URLEncoding.default)
        case .ordersDetail(let id):
            return .requestCompositeParameters(
                bodyParameters: ["id" : id],
                bodyEncoding: JSONEncoding.default,
                urlParameters: [:])
        case .create(let order):
            do {
                let dict = try MoyRequest(records:
                                            [
                                                SubMoyRequest<OrderItem>.init(
                                                    id: nil,
                                                    fields: order)
                                            ]).jsonData()
                return .requestCompositeData(bodyData: dict,
                                             urlParameters: [:])
            } catch {
                return Task.requestPlain
            }
        case .edit(let order):
            do {
                let dict = try MoyRequest(records:
                                            [
                                                SubMoyRequest<OrderItem>.init(
                                                    id: order.idAT,
                                                    fields: order)
                                            ]).jsonData()
                return .requestCompositeData(bodyData: dict,
                                             urlParameters: [:])
            } catch {
                return Task.requestPlain
            }
        }
    }
    
    var headers: [String : String]? {
        var headersDictionary = MoyaNetworkManager.shared.headers
        //        switch self {
        //        default:
        //            headersDictionary["content-type"] = "application/json-patch+json"
        //            break
        //        }
        return  headersDictionary
    }
}

