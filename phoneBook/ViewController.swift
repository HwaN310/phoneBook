import UIKit
import SnapKit
import CoreData

class ViewController: UIViewController {
  
  private let tableView = UITableView()
  var container: NSPersistentContainer!
  
  // 데이터를 저장할 배열
  private var data = [(name: String, number: String, imageUrl: String)]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    self.container = appDelegate.persistentContainer
    
    self.title = "친구 목록"
    view.backgroundColor = .white
    
    let addButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action:#selector(addFriend))
    self.navigationItem.rightBarButtonItem = addButton
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
    tableView.separatorStyle = .singleLine
    tableView.separatorColor = UIColor.black.withAlphaComponent(0.5)
    
    view.addSubview(tableView)
    
    tableView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
      $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).offset(10)
      $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
    }
    
    loadData()
  }
  //추가 버튼을 눌렀을 때 실행되는 메서드
  @objc func addFriend() {
    let addFriendVC = PhoneBookViewController()
    addFriendVC.delegate = self
    navigationController?.pushViewController(addFriendVC, animated: true)
  }
  //CoreData에서 데이터를 로드하고 테이블 뷰에 갱신하는 메서드
  private func loadData() {
    do {
      let fetchRequest: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
      let results = try self.container.viewContext.fetch(fetchRequest)
      data = results.map { ($0.name ?? "", $0.phoneNumber ?? "", $0.imageUrl ?? "") }
      data.sort {$0.name < $1.name}
      
      tableView.reloadData()
    } catch {
      print("데이터 읽기 실패")
    }
  }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
  //테이블 뷰에 있는 행의 갯수
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  //테이블 뷰의 각 행의 높이
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
  //각 행의 대한 셀을 구성
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id, for: indexPath) as! TableViewCell
    let (name, number, imageUrl) = data[indexPath.row]
    cell.configureCell(with: name, number: number, imageUrl: imageUrl)
    return cell
  }
}

extension ViewController: PhoneBookDelegate {
  //연락처가 추가되었을 때 호출되는 메서드
  func didAddFriend(name: String, phoneNumber: String, imageUrl: String) {
    // CoreData에 새 데이터 저장
    guard let entity = NSEntityDescription.entity(forEntityName: "Pokemon", in: self.container.viewContext) else {
      return
    }
    let newPhoneBook = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
    newPhoneBook.setValue(name, forKey: "name")
    newPhoneBook.setValue(phoneNumber, forKey: "phoneNumber")
    newPhoneBook.setValue(imageUrl, forKey: "imageUrl")
    
    do {
      //데이터 저장, 배열에 새 데이터를 추가하고 테이블 뷰 갱신
      try self.container.viewContext.save()
      data.append((name, phoneNumber, imageUrl))
      data.sort {$0.name < $1.name}
      tableView.reloadData()
    } catch {
      print("저장 실패")
    }
  }
}
