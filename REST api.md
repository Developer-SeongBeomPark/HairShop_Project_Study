## REST api를 사용하는 이유

#### REST api란?

- HTTP URI(Uniform Resource Identifier)를 통해 자원(Resource)을 명시하고, HTTP Method(Post,Get,Put,Delete 등)을 통해 해당 자원(URI)에 대한 CRUD Operation을 적용하는 것을 의미한다.



#### REST 특징

1. Server-Client 구조
   - Rest Server : API를 제공하고 비즈니스 로직 처리 및 저장을 책임진다.
   - Client : 사용자 인증이나 context(세션,로그인 정보) 등을 직접 관리하고 책임진다.
   - 서로 간 의존성이 줄어든다
2. Stateless
   - HTTP 프로토콜은 Stateless 프로토콜이므로 REST 역시 Stateless를 갖는다.
   - Client의 context를 Server에 저장하지 않는다.
3. Cacheable(캐시 처리 가능)
4. Layered System(계층화)
   - REST Server는 순수 비즈니스 로직을 수행하고 그 앞단에 보안, 로드밸런싱, 암호화, 사용자 인증 등을 추가하여 구조상의 유연성을 줄 수 있다.



#### RESTful의 목적

- 이해하기 쉽고 사용하기 쉬운 REST API를 만드는 것
- RESTful한 API를 구현하는 근본적인 목적은 성능 향상이 아니라 일관적인 컨벤션을 통한 API의 이해도 및 호환성을 높이는 것이다.
