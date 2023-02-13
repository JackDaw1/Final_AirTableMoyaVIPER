import UIKit

class OrderTableViewCell: UITableViewCell {
    
    var order: OrderItem? {
        didSet {
            guard let orderItem = order else {return}
            let nameOfArticle = orderItem.name
            nameOfArticleLabel.text = nameOfArticle
        }
    }
    
    let nameOfArticleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(nameOfArticleLabel)
        
        NSLayoutConstraint.activate([
            
            nameOfArticleLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 10),
            nameOfArticleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            nameOfArticleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                      constant: 5),
            nameOfArticleLabel.heightAnchor.constraint(equalToConstant: 40),
            nameOfArticleLabel.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor),
            
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

