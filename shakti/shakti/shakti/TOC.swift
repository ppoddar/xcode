import UIKit

class TOC: UITableView,UITableViewDelegate {
    init() {
        super.init(frame: .zero, style: UITableView.Style.plain)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.delegate = self
        self.register(IndexEntry.self, forCellReuseIdentifier: TOCViewController.cellIdentifer)
        self.backgroundColor = .white
        self.rowHeight = 24
        
        self.delegate = self
        self.dataSource = Poems.instance
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("selected poem \(indexPath.row)")
        guard let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        else {
            NSLog("***ERROR: can not get scene")
            return
        }
        guard let controller = scene.window?.rootViewController
        else {
            NSLog("***ERROR: can not get root view controller")
            return
        }
        let poem = PoemViewController()
        poem.index = indexPath.row
        poem.original = true
        controller.show(poem, sender: self)
        //controller.show(porm,sender: self)
     }
    
    override var intrinsicContentSize: CGSize {
        get {
            let w:CGFloat = UIScreen.main.bounds.width
            let h:CGFloat = rowHeight * CGFloat(numberOfRows(inSection: 0))
            return CGSize(width: w, height: h)
        }
    }

}

class IndexEntry : UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier:String?) {
        self.titles = ["",""]
        super.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: TOCViewController.cellIdentifer)
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var titles:[String?] {
        didSet {
            textLabel!.text       = titles[0]
            detailTextLabel!.text = titles[1]
        }
    }
    
}
