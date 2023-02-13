
import UIKit

class OrderDetailRouter: OrderDetailRouterProtocol {
    
    func navigateBackToListViewController(from view: OrderDetailViewProtocol) {
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid view protocol type")
        }
        viewVC.navigationController?.popViewController(animated: true)
    }
    
    static func createOrderDetailRouterModule(with order: OrderItem) -> UIViewController {
        
        let orderDetailVC = OrderDetailViewController()
        let presenter: OrderDetailPresenter & OrderDetailInteractorOutputProtocol = OrderDetailPresenter()
        orderDetailVC.presenter = presenter
        presenter.view = orderDetailVC
        let interactor: OrderDetailInteractorInputProtocol = OrderDetailInteractor()
        interactor.orderItem = order
        interactor.presenter = presenter
        presenter.interactor = interactor
        let router: OrderDetailRouterProtocol = OrderDetailRouter()
        presenter.router = router
        
        return orderDetailVC
    }
    
}
