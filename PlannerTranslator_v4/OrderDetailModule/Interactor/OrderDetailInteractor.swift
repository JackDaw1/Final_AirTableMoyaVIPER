
import Foundation

class OrderDetailInteractor: OrderDetailInteractorInputProtocol {
    
    weak var presenter: OrderDetailInteractorOutputProtocol?
    //var orderStore = OrderAPI.shared
    var orderItem: OrderItem?
    
    func deleteOrder() {
        guard let orderItem = orderItem else { return }
        //orderStore.removeOrder(orderItem)
        presenter?.didDeleteOrder()
    }
    
    func editOrder(summary: String?, deadline: Date?, name: String, customer: String?) {
        guard let orderItem = orderItem else { return }
        //orderItem.name = name
        //orderItem.content = content
        presenter?.didEditOrder(orderItem)
    }
    
}
