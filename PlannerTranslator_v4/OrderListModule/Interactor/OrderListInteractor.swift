import Foundation

class OrderListInteractor: OrderListInteractorInputProtocol {
    
    weak var presenter: OrderListInteractorOutputProtocol?
    var orderStore = OrderAPI.shared
    var orders: [OrderItem] {
        return orderStore.orders
    }
    
    func retrieveOrders() {
        //TODO: Add load data from DB
        //coredata тут прописать загрузку
        //coreDatdBaseService.loadFrom....->[OrderItem] -> save to orderStore
        
        presenter?.didRetrieveOrders(orders)
    }
    
    func saveOrder(_ order: OrderItem) {
        //TODO: Add saveing to DB
        //coredata тут прописать сохранение
        //coreDatdBaseService.save....
        orderStore.addOrder(order) //а это потом удаляем
        
        presenter?.didAddOrder(order)
    }
    
    func deleteOrder(_ order: OrderItem) {
        orderStore.removeOrder(order)
        presenter?.didRemoveOrder(order)
    }
    
}
