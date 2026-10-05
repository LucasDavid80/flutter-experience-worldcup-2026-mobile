# WC 2026

Aplicação mobile e API para gerenciamento de um álbum virtual de figurinhas da Copa do Mundo de 2026. O projeto permite criar uma conta, acompanhar o preenchimento do álbum, registrar figurinhas, consultar repetidas e visualizar o progresso por seleção.

Este projeto foi desenvolvido durante o curso intensivo **Flutter Experience**, com foco em desenvolvimento multiplataforma usando Flutter, integração com APIs REST e organização de código em camadas.

## Visão geral

O repositório é composto por:

- **`wc_2026_mobile`**: aplicativo Flutter para Android, iOS e outras plataformas compatíveis.
- **`wc_2026_api`**: API REST distribuída como executável Windows, com banco SQLite, autenticação JWT e especificação OpenAPI.
- **`assets.zip`**: pacote auxiliar de assets do projeto.
- **`zip`**: arquivos compactados de distribuição da API.

## Funcionalidades

- Cadastro e autenticação de usuários.
- Persistência segura da sessão no dispositivo.
- Catálogo de seleções participantes.
- Visualização do álbum e do progresso de preenchimento.
- Registro de figurinhas por código.
- Consulta de detalhes e quantidade de cada figurinha.
- Identificação de figurinhas repetidas.
- Resumo do álbum por seleção.
- Lista de figurinhas adicionadas recentemente.
- Navegação protegida por autenticação.
- Health check da API.
- Documentação da API em OpenAPI.

## Tecnologias

### Aplicativo mobile

- [Flutter](https://flutter.dev/)
- Dart
- GoRouter
- Provider
- Dio
- Retrofit
- JSON Serializable
- Flutter Secure Storage
- Google Fonts

### API

- Dart Frog
- SQLite
- JWT com algoritmo HS256
- Bcrypt para hash de senhas
- OpenAPI 3.0.3

## Arquitetura do aplicativo

O aplicativo mobile segue uma organização em camadas:

```text
wc_2026_mobile/
├── lib/
│   ├── config/       # Configurações do ambiente
│   ├── core/         # Infraestrutura compartilhada, autenticação e resultados
│   ├── data/         # APIs, modelos, mappers e repositories
│   ├── domain/       # Modelos e casos de uso
│   ├── routing/      # Rotas e proteção de navegação
│   └── ui/           # Telas, bindings, view models e widgets
├── assets/           # Imagens e padrões visuais
├── android/
└── ios/
```

As telas principais são:

- Splash e boas-vindas.
- Login e cadastro.
- Home.
- Álbum.
- Registro de figurinha.
- Detalhes da figurinha.
- Trocas.
- Perfil e outras opções.

## Pré-requisitos

- Flutter instalado e configurado.
- Dart SDK compatível com a versão declarada em `wc_2026_mobile/pubspec.yaml`.
- Android Studio e/ou Xcode, caso deseje executar em um dispositivo ou emulador.
- Windows, para executar o binário da API disponibilizado neste repositório.

Confira a instalação do Flutter em [docs.flutter.dev/get-started/install](https://docs.flutter.dev/get-started/install).

## Configuração da API

Entre na pasta da API:

```powershell
cd wc_2026_api
```

Configure o arquivo `.env` com um segredo forte para os tokens JWT:

```env
JWT_SECRET=seu-segredo-forte-com-pelo-menos-256-bits
DB_PATH=./data/wc_2026.db
BCRYPT_COST=10
```

O banco SQLite padrão fica em `wc_2026_api/data/wc_2026.db`. As variáveis de ambiente têm precedência sobre os valores definidos no arquivo `.env`.

Inicie o servidor distribuído para Windows:

```powershell
.\bin\server.exe
```

Por padrão, a API fica disponível em:

```text
http://localhost:8080
```

Verifique se o servidor está respondendo:

```powershell
Invoke-WebRequest http://localhost:8080/health
```

> O executável incluído em `wc_2026_api/bin` é destinado ao Windows x64. Para executar a API em outro sistema operacional, é necessário gerar uma versão compatível a partir do código-fonte da API.

## Configuração do aplicativo mobile

Instale as dependências:

```powershell
cd wc_2026_mobile
flutter pub get
```

O aplicativo usa `http://localhost:8080` como endereço padrão da API. Para alterar o endereço, informe `BASE_URL` durante a execução:

```powershell
flutter run --dart-define=BASE_URL=http://localhost:8080
```

### Android

Ao executar em um dispositivo físico Android, `localhost` aponta para o próprio dispositivo. Use o endereço IP da máquina que está executando a API:

```powershell
flutter run --dart-define=BASE_URL=http://192.168.0.10:8080
```

Em um emulador Android, o endereço especial `10.0.2.2` normalmente aponta para o `localhost` da máquina host:

```powershell
flutter run --dart-define=BASE_URL=http://10.0.2.2:8080
```

### iOS

Em um simulador iOS, `localhost` normalmente aponta para a máquina host. Em um dispositivo físico, use o IP local da máquina e verifique se ambos estão na mesma rede.

## API

A especificação completa está em [`wc_2026_api/public/openapi.yaml`](wc_2026_api/public/openapi.yaml).

Principais endpoints:

| Método | Endpoint | Descrição |
| --- | --- | --- |
| `GET` | `/health` | Health check da aplicação |
| `POST` | `/v1/auth/login` | Autenticação e emissão do JWT |
| `POST` | `/v1/users` | Cadastro de usuário |
| `GET` | `/v1/users/me` | Consulta do usuário autenticado |
| `GET` | `/v1/teams` | Lista de seleções |
| `GET` | `/v1/album` | Consulta o álbum |
| `POST` | `/v1/album/stickers` | Registra uma figurinha |
| `GET` | `/v1/album/stickers/{code}` | Consulta uma figurinha |
| `DELETE` | `/v1/album/stickers/{code}` | Remove uma figurinha |
| `GET` | `/v1/album/summary` | Consulta o resumo do álbum |
| `GET` | `/v1/album/recent` | Lista figurinhas recentes |

Com exceção das rotas públicas, os endpoints versionados exigem:

```http
Authorization: Bearer <token>
```

As rotas públicas incluem login, cadastro de usuário e consulta das seleções.

## Convenções de códigos

- Figurinhas de seleções: `<CODE>-<1..20>`, por exemplo `BRA-1` e `ARG-20`.
- Figurinhas especiais: `00` e `FWC-1` até `FWC-19`.
- Total previsto do álbum: **980 posições**.

## Geração de código

O aplicativo usa `build_runner` para gerar código de Retrofit e JSON Serializable. Após alterar modelos ou contratos de API, execute:

```powershell
cd wc_2026_mobile
dart run build_runner build --delete-conflicting-outputs
```

Para verificar o projeto:

```powershell
flutter analyze
flutter test
```

## Build

Para gerar um APK de release:

```powershell
cd wc_2026_mobile
flutter build apk --release --dart-define=BASE_URL=https://seu-servidor.example.com
```

Para gerar um app bundle Android:

```powershell
flutter build appbundle --release --dart-define=BASE_URL=https://seu-servidor.example.com
```

## Segurança e direitos autorais

- Nunca use um segredo JWT de exemplo em produção.
- Não compartilhe o arquivo `.env` com segredos reais.
- O JWT é assinado com HS256 e possui validade definida pela API.
- As imagens, marcas, nomes e demais elementos relacionados à Panini, FIFA, Copa do Mundo e seleções podem estar sujeitos a direitos autorais e marcas registradas próprias.
- A licença MIT deste repositório se aplica ao código disponibilizado pelo autor; ela não concede direitos sobre assets ou marcas de terceiros.

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).

Copyright (c) 2026 Lucas David.
