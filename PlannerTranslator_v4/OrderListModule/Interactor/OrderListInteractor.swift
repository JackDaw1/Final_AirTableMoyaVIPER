import Foundation
import CoreData
class OrderListInteractor: OrderListInteractorInputProtocol {
    
    weak var presenter: OrderListInteractorOutputProtocol?
    func retrieveOrders() {
        OrdersModel.loadTasks(completionHandler: { [weak self] orderList in
            guard let self = self else { return }
            self.presenter?.didRetrieveOrders(orderList)
        }, errorHandler: { [weak self] error in
        })
    }
    
    func saveOrder(_ order: OrderItem) {
        OrdersModel.create(order) { [weak self] responseOrder in
            if let order = responseOrder {
                self?.presenter?.didAddOrder(order)
            }
        } errorHandler: { error in
            
        }
    }
    
}
