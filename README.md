

Task, Actor / Decodable


Decodable
1. 데이터를 모델로 Decoding을 할수 있다는 것을 표현하기 위한 Protocol.
   반대로 인스턴스를 데이터로 표현하기 위한 Encodable이 존재하고 이 둘을 합쳐 Codable로 선언가능
   (Decodable + Encodable = Codable)
   ```
   struct Home: Decodable {
    let videos: [Video]
    let rankings: [Ranking]
    let recents: [Recent]
    let recommends: [Recommend]
    }
   ```
2. 기본적으로 데이터의 key값은 property이름이 됨. CodingKeys 선언으로 custom 가능
3. 복잡한 처리는 init(decoder:)를 직접 구현해야 해결 가능.
      ```
    struct Ranking: Decodable {
        let imageUrl: URL
        let videoId: Int
        
        enum CodingKeys: CodingKey {
            case imageUrl
            case videoId
        }
        
        init(from decoder: any Decoder) throws {
            let container: KeyedDecodingContainer<Home.Ranking.CodingKeys> = try decoder.container(keyedBy: Home.Ranking.CodingKeys.self)
            self.imageUrl = try container.decode(URL.self, forKey: Home.Ranking.CodingKeys.imageUrl)
            self.videoId = try container.decode(Int.self, forKey: Home.Ranking.CodingKeys.videoId)
        }
    }
    ```
4. JSON의 경우 애플에서 제공해주는 JSONDecoder로 json을 모델로 decode 가능
   Decoder protocol을 구현하면 Custom Decoder를 만들 수도 있음
5. JSONDecoder/decoder



Task
1. 비동기 처리의 기본 단위. (https://developer.apple.com/documentation/swift/task)
2. 함수에 async 선언을 하면, Task에서는 await 키워드를 이용하여 비동기작업이 끝날때 까지 대기
3. Task내에서 await를 이용하면 OS에서 적절하게 스레드를 생성 및 관리 ( Task != Thread )
   -> Task가 비동기 처리의 기본 단위이지만 Task가 반드시 Thread를 의미하지는 않는다. 따라서 Task를 생성할 때마다 동일한 Thread를 보장 할수 없을수도있음
4. Task<Success: Sendable, Failure: Error>
   Task의 return 값은 반드시 Sendable protocol을 충족해야함
5. Task는 취소할 수 있고, Task.checkCancellation()을 통해서 취소여부를 확인할 수 있음
   Task취소시 하위 생성된 Task도 모두 취소됨



Actor
1. 여러 Task로부터 공유자원에 대한 접근 관리.
2. 공유자원을 격리(isolate)시키고, 공유자원에 대해서 Serial하게 접근하도록 처리. 이를 통해 Data race 해결
3. Actor 내부의 property는 외부에서 mutate 할 수 없음. Actor 내에서만 mutate 가능.
4. Actor는 기본적으로 Reference Type
5. 격리 시키지 않을 메소드는 nonisolated 키워드를 붙여서 제외 가능.
