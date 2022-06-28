import UIKit
import CryptoKit

class ViewController: UIViewController {

    private let endpointClient = EndpointClient(applicationSettings: ApplicationSettingsService())

    override func viewDidLoad() {
        super.viewDidLoad()
        executeCall()
    }
    
    func executeCall() {
        let endpoint = GetNameEndpoint()
        let completion: EndpointClient.ObjectEndpointCompletion<String> = { result, response in
            guard let responseUnwrapped = response else { return }

            switch result {
            case .success(let team):
                print("team = \(team)")
            case .failure(let error):
                print(error)
            }
        }
        endpointClient.executeRequest(endpoint, completion: completion)
    }
}

final class GetNameEndpoint: ObjectResponseEndpoint<String> {
    
    override var method: RESTClient.RequestType { return .get }
    override var path: String { "v1/public/comics" }
    private let publicKey = "b77533b1ffc2ecba82522b696a9b5e4c"
    private let privateKey = "452d90f59d30f3245861743b5310c4b2c58bce44"
    static var ts = 20
    
    override init() {
        super.init()
        queryItems = [URLQueryItem(name: "ts", value: "\(GetNameEndpoint.ts)"),
                      URLQueryItem(name: "apikey", value: publicKey),
                      URLQueryItem(name: "hash", value: md5("\(GetNameEndpoint.ts)\(privateKey)\(publicKey)"))
        ]
    }
    
    func md5(_ string: String) -> String {
        let r = Insecure.MD5.hash(data: string.data(using: .utf8)!)
        return r.map {String(format: "%02x", $0)}
            .joined()
    }
}

func decodeJSONOld() {
    let str = """
        {\"team\": [\"ios\", \"android\", \"backend\"]}
    """
    let data = Data(str.utf8)

    do {
        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            if let names = json["team"] as? [String] {
                print(names)
            }
        }
    } catch let error as NSError {
        print("Failed to load: \(error.localizedDescription)")
    }
}

