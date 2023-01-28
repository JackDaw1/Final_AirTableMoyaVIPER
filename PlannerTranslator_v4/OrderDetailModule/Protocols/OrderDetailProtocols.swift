import UIKit

protocol OrderDetailViewProtocol: class {
    
    var presenter: OrderDetailPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showOrder(_ order: OrderItem)
}

protocol OrderDetailPresenterProtocol: class {
    
    var view: OrderDetailViewProtocol? { get set }
    var interactor: OrderDetailInteractorInputProtocol? { get set }
    var router: OrderDetailRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func editOrder(link: String?, deadline: Date?, made: Bool?, paid: Bool?, name: String, price: Double?, numberOfSigns: Int64?, customer:String?, time: Int64?)
    func deleteOrder()
}

protocol OrderDetailInteractorInputProtocol: class {
    
    var presenter: OrderDetailInteractorOutputProtocol? { get set }
    var orderItem: OrderItem? { get set }
    
    // PRESENTER -> INTERACTOR
    func deleteOrder()
    func editOrder(link: String?, deadline: Date?, made: Bool?, paid: Bool?, name: String, price: Double?, numberOfSigns: Int64?, customer:String?, time: Int64?)
}

protocol OrderDetailInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
    func didDeleteOrder()
    func didEditOrder(_ order: OrderItem) 
}

protocol OrderDetailRouterProtocol: class {
    
    static func createOrderDetailRouterModule(with order: OrderItem) -> UIViewController
    
    // PRESENTER -> ROUTER
    func navigateBackToListViewController(from view: OrderDetailViewProtocol)
    
}
