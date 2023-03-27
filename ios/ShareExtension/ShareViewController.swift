import UIKit
import Social
import MobileCoreServices
import Foundation
import Photos
import Intents

class ShareViewController: SLComposeServiceViewController {

    let hostAppBundleIdentifier = "com.flutter.template"
    let imageContentType = UTType.image.identifier
    let movieContentType = UTType.movie.identifier
    let textContentType = UTType.text.identifier
    let urlContentType = UTType.url.identifier
    let fileURLType = UTType.fileURL.identifier
    let dataContentType = UTType.data.identifier

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Task {
            if let content = extensionContext!.inputItems[0] as? NSExtensionItem {
                if let contents = content.attachments {
                    for (_, attachment) in (contents).enumerated() {
                        await shareText(attachment: attachment)
                    }
                }
            }
            self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
        }
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }
    
    private func shareText(attachment: NSItemProvider) async {
        var text = "text"

        let originalData = try? await attachment.loadItem(forTypeIdentifier: textContentType, options: nil)
        
        text = originalData as? String ?? "text"
        
        text = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "text"
        

        let url = URL(string: "ShareMedia-com.flutter.template://com.pocket.scheudle?key=\(text)")
        
        var responder = self as UIResponder?
        
        let selectorOpenURL = sel_registerName("openURL:")
        
        while (responder != nil) {
            if (responder?.responds(to: selectorOpenURL))! {
                let _ = responder?.perform(selectorOpenURL, with: url)
            }
            responder = responder!.next
        }
    }
    
    private func dismissWithError() {
        print("[ERROR] Error loading data!")
        let alert = UIAlertController(title: "Error", message: "Error loading data", preferredStyle: .alert)

        let action = UIAlertAction(title: "Error", style: .cancel) { _ in
            self.dismiss(animated: true, completion: nil)
        }

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }
}
