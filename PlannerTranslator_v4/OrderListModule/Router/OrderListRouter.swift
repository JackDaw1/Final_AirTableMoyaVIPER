import UIKit

class OrderListRouter: OrderListRouterProtocol {
    
    static func createOrderListModule() -> UIViewController {
        let orderListViewController = OrderListViewController()
        let presenter: OrderListPresenterProtocol & OrderListInteractorOutputProtocol = OrderListPresenter()
        let interactor: OrderListInteractorInputProtocol = OrderListInteractor()
        let router = OrderListRouter()
        
        orderListViewController.presenter = presenter
        presenter.view = orderListViewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return orderListViewController
    }

    func presentOrderDetailScreen(from view: OrderListViewProtocol, for order: OrderItem) {
        
        let orderDetailVC = OrderDetailRouter.createOrderDetailRouterModule(with: order)
        
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid View Protocol type")
        }
        
        viewVC.navigationController?.pushViewController(orderDetailVC, animated: true)
    }

    
}
