import UIKit

struct SectionOrdersItem {
    var orders: [OrderItem] = []
    var date: Date
}

class OrderListViewController: UITableViewController {
    
    var presenter: OrderListPresenterProtocol?
    var sectionsArray: [SectionOrdersItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private func baseConfigure() {
        view.backgroundColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseConfigure()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewWillAppear()
    }
    
    private func setupView() {
        tableView.tableFooterView = UIView()
        tableView.register(OrderTableViewCell.self, forCellReuseIdentifier: "OrderTableViewCell")
        
        let newRightBarButtonItem = UIBarButtonItem(title: "+", style: UIBarButtonItem.Style.plain, target: self, action: #selector(addTapped))//
        //  let newRightBarButtonItem = UIBarButtonItem(image: <#T##UIImage?#>, style: UIBarButtonItem.Style.plain, target: self, action: #selector(addTapped))
        //Настройка текста кнопки если она использует текст
        newRightBarButtonItem.setTitleTextAttributes(
            [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 36.0),
             NSAttributedString.Key.foregroundColor : UIColor.blue],
            for: UIControl.State.normal)
        
        newRightBarButtonItem.setTitleTextAttributes(
            [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 36.0),
             NSAttributedString.Key.foregroundColor : UIColor.gray],
            for: UIControl.State.selected)
        //
        navigationItem.rightBarButtonItem = newRightBarButtonItem
    }
    //определяем сколько секций в таблице
    override func numberOfSections(in tableView: UITableView) -> Int {
        sectionsArray.count
    }
    
    //настраиваем строки секции (в ней хранятся 1 хедер и множество ячеек (строк))
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsArray[section].orders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as? OrderTableViewCell
        else {
            return UITableViewCell()
        }
        
        let order = sectionsArray[indexPath.section].orders[indexPath.row]
        cell.order = order
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionsArray[section].date.toString()
    }
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        <#code#>
//    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionObject = sectionsArray[indexPath.section]
        let order = sectionObject.orders[indexPath.row]
        presenter?.showOrderDetail(order)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let sectionObject = sectionsArray[indexPath.section]
            let orderItem = sectionObject.orders[indexPath.row]
            presenter?.removeOrder(orderItem)
        }
    }
    
@objc
func addTapped(_ sender: Any) {
    var addVC = AddOrderViewController()
    addVC.handler = { [weak self] newOrder in
        guard let self = self else { return }
        self.presenter?.addOrder(newOrder)
    }
    addVC.modalPresentationStyle = .formSheet
    present(addVC, animated: true)
    }
    
}

extension OrderListViewController: OrderListViewProtocol {
    
    func showOrders(_ sections: [SectionOrdersItem]) {
        self.sectionsArray = sections
    }
    
    func showErrorMessage(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
}
