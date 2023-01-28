import Foundation

class OrderDetailPresenter: OrderDetailPresenterProtocol {

    weak var view: OrderDetailViewProtocol?
    var router: OrderDetailRouterProtocol?
    var interactor: OrderDetailInteractorInputProtocol?
    
    
    func viewDidLoad() {
        if let orderItem = interactor?.orderItem {
            view?.showOrder(orderItem)
        }
    }
    
    func editOrder(link: String?, deadline: Date?, made: Bool?, paid: Bool?, name: String, price: Double?, numberOfSigns: Int64?, customer:String?, time: Int64?) {
        
        interactor?.editOrder(link: link, deadline: deadline, made: made, paid: paid, name: name, price: price, numberOfSigns: numberOfSigns, customer: customer, time: time)
    }
    
    func deleteOrder() {
        interactor?.deleteOrder()
    }
    
}

extension OrderDetailPresenter: OrderDetailInteractorOutputProtocol {
    
    func didDeleteOrder() {
        if let view = view {
            router?.navigateBackToListViewController(from: view)
        }
    }
    
    func didEditOrder(_ order: OrderItem) {
        view?.showOrder(order)
    }
    
}
