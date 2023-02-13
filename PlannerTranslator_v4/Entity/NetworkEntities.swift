import Foundation

protocol ATProtocol: Codable {
    var idAT: String? { get set }
}
struct MoyResponse<T: ATProtocol>: Codable {
    let records: [SubMoyResponse<T>]
    
    enum MoyResponseKeys: CodingKey {
        case records
    }
}

struct SubMoyResponse<T: ATProtocol>: Codable {
    let id: String
    let createdTime: String
    var fields: T
    enum SubMoyResponseKeys: CodingKey {
        case id,createdTime,fields
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<SubMoyResponse<T>.CodingKeys> = try decoder.container(keyedBy: SubMoyResponse<T>.CodingKeys.self)
        self.id = try container.decode(String.self, forKey: SubMoyResponse<T>.CodingKeys.id)
        self.createdTime = try container.decode(String.self, forKey: SubMoyResponse<T>.CodingKeys.createdTime)
        self.fields = try container.decode(T.self, forKey: SubMoyResponse<T>.CodingKeys.fields)
        self.fields.idAT = self.id
    }
}

struct MoyRequest<T: Codable>: Codable {
    let records: [SubMoyRequest<T>]
    
    enum MoyRequestKeys: CodingKey {
        case records
    }
}

struct SubMoyRequest<T: Codable>: Codable {
    let id: String?
    let fields: T
    enum SubMoyRequestKeys: CodingKey {
        case id,createdTime,fields
    }
    
    func toJSON() -> Dictionary<String, Any> {
        do {
            let jsonData = try JSONEncoder().encode(self)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            
            if let data = jsonString.data(using: .utf8) {
                do {
                    return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] ?? Dictionary<String, Any>()
                } catch {
                    print(error.localizedDescription)
                }
            }
            return Dictionary<String, Any>()
        } catch { print(error) }
        return Dictionary<String, Any>()
    }
}
