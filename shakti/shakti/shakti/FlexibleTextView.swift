import UIKit

class FlexibleTextView: UITableView,UITableViewDataSource,UITableViewDelegate {
    var text: String!
    var font: UIFont = UIFont.preferredFont(forTextStyle: .body)
    var cellIdentifer:String = "cell"
    init() {
        
        super.init(frame: .zero, style: .plain)
        
        isScrollEnabled = true
        delegate = self
        dataSource = self
        
        register(DummyCell.self, forCellReuseIdentifier: cellIdentifer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("++++++++++++ numberOfRowsInSection \(section) +++++++++++++")
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("get cell at \(indexPath)")
        return DummyCell(text:text, font:font)
    }
    
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat.greatestFiniteMagnitude
    }
    
    func setString(text:String) {
        print("=========== reload data =======")
        self.text = text
        super.reloadData()
    }
}

class DummyCell : UITableViewCell {
    
    init(text:String, font:UIFont) {
        let cell:UITableViewCell = UITableViewCell()
        let textview:UITextView = UITextView()
        textview.text = text
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.isScrollEnabled = false
        textview.automaticallyAdjustsScrollIndicatorInsets = false
        textview.textAlignment = .center
        cell.addSubview(textview)
        
        super.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
