import UIKit

extension UIColor {
    
    class var titleText: UIColor {
        return darkGray
    }
    
    class var subtitleText: UIColor {
        return lightGray
    }
    
    class var bodyText: UIColor {
        return gray
    }
}

extension UIFont {
    
    class var title: UIFont {
        return preferredFont(forTextStyle: UIFontTextStyle.largeTitle)
    }
    
    class var subtitle: UIFont {
        return preferredFont(forTextStyle: UIFontTextStyle.headline)
    }
    
    class var body: UIFont {
        return preferredFont(forTextStyle: UIFontTextStyle.body)
    }
    
}
