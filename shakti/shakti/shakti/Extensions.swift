import UIKit

extension UIViewController {
    func setNavigationBar() {
        //navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.isTranslucent = false
        let appearance = UINavigationBar.appearance()
        appearance.titleTextAttributes = [
            .font: UIStyle.ENGLISH_FONT,
            .foregroundColor:UIStyle.FONT_COLOR]
        
        appearance.tintColor    = UIStyle.FONT_COLOR
        appearance.barTintColor = UIStyle.FONT_COLOR
        
        let barappearance = UINavigationBarAppearance()

        navigationItem.standardAppearance   = barappearance
        navigationItem.scrollEdgeAppearance = barappearance
        navigationItem.compactAppearance    = barappearance // For iPhone small navigation bar in landscape.

    }
}

extension UILabel {
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 24)
    }
}


extension UIView {

    func pin(_ to:UIView?) {
        guard let other = to else {return}
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: other.topAnchor),
            self.leftAnchor.constraint(equalTo: other.leftAnchor),
            self.widthAnchor.constraint(equalTo: other.widthAnchor),
            self.heightAnchor.constraint(equalTo: other.heightAnchor),
        ])
    }
    func pin(_ to:UILayoutGuide?) {
        guard let other = to else {return}
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: other.topAnchor),
            self.leftAnchor.constraint(equalTo: other.leftAnchor),
            self.widthAnchor.constraint(equalTo: other.widthAnchor),
            self.heightAnchor.constraint(equalTo: other.heightAnchor),
        ])
    }

    
func subviewsRecursive() -> [UIView] {
    return subviews + subviews.flatMap { $0.subviewsRecursive() }
}

func dump(name:String, tab:Int) {
    print("\(makeTab(tab))\(name)[\(type(of:self))] frame=\(self.frame)")
    var idx = 0
    for v in self.subviews {
        let childName = "\(name)-\(idx)"
        v.dump(name:childName, tab:tab+1)
        idx += 1
    }
}

func makeTab(_ tab:Int) -> String {
    var str  = ""
    for _ in 0..<tab {
        str += " "
    }
    return str
}

}
