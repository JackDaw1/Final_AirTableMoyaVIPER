import UIKit

protocol OrderListViewProtocol: class {
    
    var presenter: OrderListPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showOrders(_ sections: [SectionOrdersItem])
    func showErrorMessage(_ message: String)
}

protocol OrderListPresenterProtocol: class {
    
    var view: OrderListViewProtocol? { get set }
    var interactor: OrderListInteractorInputProtocol? { get set }
    var router: OrderListRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewWillAppear()
    func showOrderDetail(_ order: OrderItem)
    func addOrder(_ order: OrderItem)
    func removeOrder(_ order: OrderItem)
}

protocol OrderListInteractorInputProtocol: class {
    
    var presenter: OrderListInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveOrders()
    func saveOrder(_ order: OrderItem)
    func deleteOrder(_ order: OrderItem)
}

protocol OrderListInteractorOutputProtocol: AnyObject {
    
    // INTERACTOR -> PRESENTER
    func didAddOrder(_ order: OrderItem)
    func didRemoveOrder(_ order: OrderItem)
    func didRetrieveOrders(_ orders: [OrderItem])
    func onError(message: String)
}

protocol OrderListRouterProtocol: AnyObject {
    
    static func createOrderListModule() -> UIViewController
    
    // PRESENTER -> ROUTER
    func presentOrderDetailScreen(
    from view: OrderListViewProtocol,
//    outputPreneter: OrderDetailPresenterOutputProtocol,
    for order: OrderItem)
}
