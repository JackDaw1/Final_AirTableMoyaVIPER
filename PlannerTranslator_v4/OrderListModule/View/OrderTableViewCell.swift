import UIKit

class OrderTableViewCell: UITableViewCell {
    
    var order: OrderItem? {
        didSet {
            guard let orderItem = order else {return}
            let nameOfArticle = orderItem.name
            //profileImageView.image = UIImage(named: name)
            nameOfArticleLabel.text = nameOfArticle
            
            if let customer = orderItem.customer {
                profileImageView.image = UIImage(named: customer)
                customerDetailedLabel.text = " \(customer) "
            }
            
            if let price = orderItem.price {
                //countryImageView.image = UIImage(named: country)
                priceDetailedLabel.text = " \(price) "
                
            }
        }
    }
    
    let profileImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
    let nameOfArticleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let customerDetailedLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor =  .white
        label.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceDetailedLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor =  .black
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(nameOfArticleLabel)
        self.contentView.addSubview(customerDetailedLabel)
        self.contentView.addSubview(priceDetailedLabel)
        
        priceDetailedLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.horizontal)
        customerDetailedLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.horizontal)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor),
            profileImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                     constant: 10),
            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            profileImageView.heightAnchor.constraint(equalToConstant: 70),
            profileImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor),
            
            nameOfArticleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                    constant: 5.0),
            nameOfArticleLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 5.0),
            nameOfArticleLabel.heightAnchor.constraint(equalToConstant: 40.0),
            nameOfArticleLabel.trailingAnchor.constraint(equalTo: priceDetailedLabel.leadingAnchor, constant: -5.0),
            
            customerDetailedLabel.topAnchor.constraint(equalTo: nameOfArticleLabel.bottomAnchor),
            customerDetailedLabel.leadingAnchor.constraint(equalTo: nameOfArticleLabel.leadingAnchor),
            customerDetailedLabel.heightAnchor.constraint(equalToConstant: 30.0),
            customerDetailedLabel.trailingAnchor.constraint(lessThanOrEqualTo: priceDetailedLabel.leadingAnchor),
            customerDetailedLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -5),
            
            priceDetailedLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            priceDetailedLabel.heightAnchor.constraint(equalToConstant: 40.0),
            priceDetailedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
