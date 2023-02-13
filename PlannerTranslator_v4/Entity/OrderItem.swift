//
//  Order.swift
//  PlannerTranslator_v4
//
//  Created by Galina Iaroshenko on 05.01.2023.
//

import Foundation

struct SectionOrdersItem {
    var orders: [OrderItem] = []
    var date: Date
}

struct OrderItem: ATProtocol {
    var idAT: String?
    var summary: String?
    var deadline: String?
    var name: String = ""
    var customer: String?
    
    init(
        idAT: String? = nil,
        summary: String?,
        deadline: String?,
        name: String = "",
        customer:String?) {
            self.idAT = idAT
            self.deadline = deadline
            self.name = name
            self.customer = customer
        }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: OrderKeys.self)
        self.summary = try container.decodeIfPresent(String.self, forKey: .summary)
        self.deadline = try container.decodeIfPresent(String.self, forKey: .deadline)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.customer = try container.decodeIfPresent(String.self, forKey: .customer) ?? ""

    }
    
    enum OrderKeys: CodingKey {
        case idAT
        case summary
        case deadline
        case name
        case customer
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: OrderKeys.self)
        try container.encodeIfPresent(self.summary, forKey: .summary)
        try container.encodeIfPresent(self.deadline, forKey: .deadline)
        try container.encode(self.name, forKey: .name)
        try container.encodeIfPresent(self.customer, forKey: .customer)
    }
    
}
