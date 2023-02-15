
import UIKit

class AddOrderViewController: UIViewController, UIPickerViewDelegate {
    
    var nameTextField: UITextField = UITextField()
    var customerTextField: UITextField = UITextField()
    var saveButton: UIButton = UIButton()
    var switchView: UISwitch = UISwitch()
    var pickView: UIPickerView = UIPickerView()
    
    var handler: ((OrderItem) -> Void)?
    
    private func baseConfigure() {
        view.backgroundColor = UIColor.white
        
        nameTextField.placeholder = "Enter name"
        customerTextField.placeholder = "Enter customer name"
        saveButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        saveButton.setTitleColor(UIColor.gray, for: UIControl.State.selected)
        
        saveButton.setTitle("Save", for: UIControl.State.normal)
        saveButton.setTitle("Save", for: UIControl.State.selected)
        saveButton.addTarget(self, action: #selector(save), for: UIControl.Event.touchUpInside)
        
        pickView.delegate = self
    }
    
    func setupConstraints() {
        [
            nameTextField,
            customerTextField,
            saveButton
        ].forEach { customView in
            view.addSubview(customView)
            customView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            nameTextField.heightAnchor.constraint(equalToConstant: 60),
            
            customerTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            customerTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            customerTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor),
            customerTextField.heightAnchor.constraint(equalToConstant: 60),
            customerTextField.bottomAnchor.constraint(equalTo: saveButton.topAnchor),
            
            saveButton.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            saveButton.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        baseConfigure()
    }
    
    @objc
    func save() {
        //TODO: настроить алерт сообщение о важности внесения имени
        handler?(OrderItem(summary: nil, deadline: nil, name: nameTextField.text ?? "", customer: customerTextField.text))
        self.dismiss(animated: true)
    }

    
}
