import UIKit
import SnapKit
import Kingfisher

protocol PhoneBookDelegate: AnyObject {
  func didAddFriend(name: String, phoneNumber: String, imageUrl: String)
}

class PhoneBookViewController: UIViewController {
  
  weak var delegate: PhoneBookDelegate?
  var imageUrl: String = ""
  
  let viewImage: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 75
    imageView.layer.borderWidth = 1.0
    imageView.layer.borderColor = UIColor.gray.cgColor
    imageView.clipsToBounds = true
    return imageView
  }()
  
  let editImage: UIButton = {
    let button = UIButton()
    button.setTitle("랜덤 이미지 생성", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
    button.setTitleColor(.gray, for: .normal)
    button.addTarget(self, action: #selector(editImageButtonTapped), for: .touchUpInside)
    return button
  }()
  
  let textName: UITextView = {
    let textView = UITextView()
    textView.backgroundColor = .white
    textView.font = UIFont.systemFont(ofSize: 20)
    textView.layer.borderColor = UIColor.lightGray.cgColor
    textView.layer.borderWidth = 1.0
    textView.layer.cornerRadius = 8.0
    textView.isScrollEnabled = false
    return textView
  }()
  
  let textNumber: UITextView = {
    let textView = UITextView()
    textView.backgroundColor = .white
    textView.font = UIFont.systemFont(ofSize: 20)
    textView.layer.borderColor = UIColor.lightGray.cgColor
    textView.layer.borderWidth = 1.0
    textView.layer.cornerRadius = 8.0
    textView.isScrollEnabled = false
    return textView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "연락처 추가"
    view.backgroundColor = .white
    
    view.addSubview(viewImage)
    view.addSubview(editImage)
    view.addSubview(textName)
    view.addSubview(textNumber)
    
    let saveButton = UIBarButtonItem(title: "적용", style: .plain, target: self, action:#selector(save))
    self.navigationItem.rightBarButtonItem = saveButton
    
    viewImage.snp.makeConstraints {
      $0.width.height.equalTo(150)
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
      $0.centerX.equalToSuperview()
    }
    
    editImage.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(viewImage.snp.bottom).offset(20)
    }
    
    textName.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(editImage.snp.bottom).offset(20)
      $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
      $0.height.equalTo(40)
    }
    
    textNumber.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(textName.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
      $0.height.equalTo(40)
    }
  }
  
  @objc private func editImageButtonTapped() {
    makeRandomImage()
  }
  
  @objc private func save() {
    guard let name = textName.text, !name.isEmpty,
          let phoneNumber = textNumber.text, !phoneNumber.isEmpty else {
      let alert = UIAlertController(title: "오류", message: "모든 필드를 입력하세요.", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
      present(alert, animated: true, completion: nil)
      return
    }
    
    delegate?.didAddFriend(name: name, phoneNumber: phoneNumber, imageUrl: imageUrl)
    navigationController?.popViewController(animated: true)
  }
  
  private func makeRandomImage() {
    imageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(Int.random(in: 0...151)).png"
    viewImage.kf.setImage(with: URL(string: imageUrl))
  }
}
