import Foundation

class OrderListPresenter: OrderListPresenterProtocol {
    
    // хранит слабую ссылку на TodoListViewProtocol, чтобы он мог обновлять пользовательский интерфейс.
    weak var view: OrderListViewProtocol?
    // хранит ссылку на TodoListInteractorInputProtocol, поэтому презентер может передать пользовательский ввод для получения или изменения данных через интерактор
    var interactor: OrderListInteractorInputProtocol?
    //Он также хранит объект TodoListRouterProtocol, чтобы он мог перейти к TodoDetailModule, когда пользователь выбирает TodoItem в табличном представлении.
    var router: OrderListRouterProtocol?
    
    func showOrderDetail(_ order: OrderItem) {
        guard let view = view else { return }
        router?.presentOrderDetailScreen(from: view,
                                         for: order)
    }
    
    func addOrder(_ order: OrderItem) {
        interactor?.saveOrder(order)
    }
    
    //При реализации TodoPresenterProtocol представление будет вызывать представление презентатора viewWillAppear, когда представление появится на экране.
    func viewWillAppear() {
        interactor?.retrieveOrders()
    }
    
}

extension OrderListPresenter: OrderListInteractorOutputProtocol {
    
    func didAddOrder(_ order: OrderItem) {
        interactor?.retrieveOrders()
    }
    
    func didRetrieveOrders(_ orders: [OrderItem]) {
        let deadline = orders.first?.deadline?.toDate()
        guard !orders.isEmpty else { return }
        let array = orders
            .sorted { order1, order2 in
                guard let deadline1 = order1.deadline?.toDate(), let deadline2 = order2.deadline?.toDate() else {
                    return false
                }
                return deadline1 < deadline2
            }
        
        var sectionsResult = [SectionOrdersItem]()
        var currentDate = deadline ?? Date()
        var sectionItem: SectionOrdersItem = SectionOrdersItem(date: currentDate)
        for order in array {
            if let deadline = order.deadline?.toDate(),  abs(deadline.timeIntervalSince(currentDate)) > 24*60*59 {
                if sectionItem.orders.isEmpty != true {
                    sectionsResult.append(sectionItem)
                }
                currentDate = order.deadline?.toDate() ?? Date()
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

