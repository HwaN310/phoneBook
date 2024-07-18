import UIKit
import SnapKit
import Kingfisher

final class TableViewCell: UITableViewCell {
  static let id = "TableViewCell"
  
  private let profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 25
    imageView.clipsToBounds = true
    imageView.layer.borderWidth = 1.0 // 테두리 두께 설정
    imageView.layer.borderColor = UIColor.black.cgColor // 테두리 색상 설정
    return imageView
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = .black
    return label
  }()
  
  private let numberLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    label.textColor = .black
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    configureUI()
  }
  
  private func configureUI() {
    contentView.backgroundColor = .white
    [
      profileImageView,
      nameLabel,
      numberLabel
    ].forEach { contentView.addSubview($0) }
    
    profileImageView.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().inset(40)
      $0.width.height.equalTo(50)
    }
    nameLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalTo(profileImageView.snp.trailing).offset(30)
    }
    numberLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().offset(-30)
    }
  }
  
  public func configureCell(with name: String, number: String, imageUrl: String) {
    profileImageView.kf.setImage(with: URL(string: imageUrl))
    nameLabel.text = name
    numberLabel.text = number
  }
}
