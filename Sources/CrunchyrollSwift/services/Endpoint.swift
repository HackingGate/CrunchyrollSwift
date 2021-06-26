extension CRAPIService {
    public enum Endpoint {
        case startSession, startUSSession, autocomplete, listCollections, listMedia, info
        func path() -> String {
            switch self {
            case .startSession:
                return "start_session.0.json"
            case .startUSSession:
                return "start_session"
            case .autocomplete:
                return "autocomplete.0.json"
            case .listCollections:
                return "list_collections.0.json"
            case .listMedia:
                return "list_media.0.json"
            case .info:
                return "info.0.json"
            }
        }
    }
}
