import UIKit
import Magic

class QuestionListTableViewController: UITableViewController {

    @IBOutlet weak var cellCategoryLabel: UILabel!
    
    let questionTitles  = ["Медицина", "Продукты", "Отношения", "Право", "Образование", "Спорт"]
//  let imagesArray     = ["HealthCategory", "AutoCategory", "HealthCategory", "AutoCategory", "HealthCategory", "AutoCategory", "HealthCategory", "AutoCategory", "HealthCategory", "AutoCategory", "HealthCategory", "AutoCategory", "HealthCategory", "AutoCategory", "HealthCategory", "AutoCategory"]
  
  var questions = [Question]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navBarBackground.png"), for: .default)
    navigationItem.leftBarButtonItem = NavigationButton.createNavigationButtonOf(type: .menuButton, with: #selector(SWRevealViewController.revealToggle(_:)), on: revealViewController())
    navigationItem.rightBarButtonItem = NavigationButton.createNavigationButtonOf(type: .askQuestion, with: #selector(questionButtonTapped), on: self)
    
    self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    
    let tempImageView = UIImageView(image: UIImage(named: "background"))
    tempImageView.frame = tableView.frame
    tableView.backgroundView = tempImageView
    
    app.api.loadUserInfo(id: 6, completion: {
      magic("User info loaded")
    })
    
    self.tableView.rowHeight  = 100
  }
  
  override func viewWillAppear(_ animated: Bool) {
    app.api.loadQuestionList(completion: { (questions) in
      //magic("QL loaded")
      self.questions = questions
    })
  }
    
    // убрать в отдельный класс ButtonsBehavior
    @objc func questionButtonTapped() {
        print("There will be asking functionallity")
        performSegue(withIdentifier: "askQuestion", sender: nil)
    }
    @objc func filterButtonTapped() {
        print("There will be filtering functionallity")
    }

  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return 16
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "questionListCell", for: indexPath)
//    cell.backgroundColor = UIColor(patternImage: UIImage(named: imagesArray[indexPath.row])!)
//    let question = questions[indexPath.row]
//
//    cell.questionTitleLabel.text = question.subject
//    cell.questionPreviewLabel.text = question.question
//    cell.questionImage.image = imagesArray[0]
    
    return cell
  }
  
}
