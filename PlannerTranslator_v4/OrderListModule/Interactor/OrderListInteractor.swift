import Foundation
import CoreData
class OrderListInteractor: OrderListInteractorInputProtocol {
    
    weak var presenter: OrderListInteractorOutputProtocol?
//    var orderStore = OrderAPI.shared
//    var orders: [OrderItem] {
//        return orderStore.orders
//    }
//    let context = PTDataBaseService.shared.persistentContainer.viewContext
    
    func retrieveOrders() {
        //TODO: Add load data from DB
        //coredata тут прописать загрузку
        //coreDatdBaseService.loadFrom....->[OrderItem] -> save to orderStore
        
//        let request = Order.fetchRequest()
//        let contextObject = self.context
//        let ordersDB = try? contextObject.fetch(request)
        
        OrdersModel.loadTasks(completionHandler: { [weak self] orderList in
            guard let self = self else { return }
            
            self.presenter?.didRetrieveOrders(orderList)
            //костыль
//            if let ordersDB = ordersDB, ordersDB.isEmpty, !orderList.isEmpty {
//                PTDataBaseService.shared.reloadOrders(by: orderList)
//            }
        }, errorHandler: { [weak self] error in
//            guard let self = self, let ordersDB = ordersDB else { return }
//            DispatchQueue.main.async {
//                self.presenter?.didRetrieveOrders(ordersDB.compactMap({ OrderItem.init(order: $0) }))
//            }
        })
    }
    
    func saveOrder(_ order: OrderItem) {
        //TODO: Add saveing to DB
        //coredata тут прописать сохранение
        //coreDatdBaseService.save....
        //        orderStore.addOrder(order) //а это потом удаляем
        OrdersModel.create(order) { [weak self] responseOrder in
            if let order = responseOrder {
                self?.presenter?.didAddOrder(order)
            }
        } errorHandler: { error in
            
        }
    }
    
    func deleteOrder(_ order: OrderItem) {
        presenter?.didRemoveOrder(order)
    }
}
