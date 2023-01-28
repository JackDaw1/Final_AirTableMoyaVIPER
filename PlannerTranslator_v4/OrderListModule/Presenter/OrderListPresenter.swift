import Foundation

class OrderListPresenter: OrderListPresenterProtocol {
    
    weak var view: OrderListViewProtocol?
    var interactor: OrderListInteractorInputProtocol?
    var router: OrderListRouterProtocol?
    
    func showOrderDetail(_ order: OrderItem) {
        guard let view = view else { return }
        router?.presentOrderDetailScreen(from: view, for: order)
    }
    
    func addOrder(_ order: OrderItem) {
        interactor?.saveOrder(order)
    }
    
    func viewWillAppear() {
        interactor?.retrieveOrders()
    }
    
    func removeOrder(_ order: OrderItem) {
        interactor?.deleteOrder(order)
    }
    
}

extension OrderListPresenter: OrderListInteractorOutputProtocol {
    func didRemoveOrder(_ order: OrderItem) {
        
    }
    
    
    func didAddOrder(_ order: OrderItem) {
        interactor?.retrieveOrders()
    }
    
    func didRetrieveOrders(_ orders: [OrderItem]) {
        guard !orders.isEmpty else { return }
        
        let array = orders
            .filter({ !$0.made })
            .sorted { order1, order2 in
            guard let deadline1 = order1.deadline, let deadline2 = order2.deadline else {
                return false
            }
            return deadline1 < deadline2
        }
        
        var sectionsResult = [SectionOrdersItem]()
        var currentDate = orders.first?.deadline ?? Date()
        var sectionItem: SectionOrdersItem = SectionOrdersItem(date: currentDate)
        for order in array {
            if let deadline = order.deadline, abs(deadline.timeIntervalSince(currentDate)) > 24*60*59 {
                sectionsResult.append(sectionItem)
                currentDate = order.deadline ?? Date()
                sectionItem = SectionOrdersItem(date: currentDate)
                sectionItem.orders.append(order)
            } else {
                sectionItem.orders.append(order)
            }
        }
        sectionsResult.append(sectionItem)
        view?.showOrders(sectionsResult)
    }
    
    func onError(message: String) {
        view?.showErrorMessage(message)
    }
}
