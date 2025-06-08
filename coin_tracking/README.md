# 🌧️ Acompanhamento de Cotação das Moedas

Projeto de desenvolvimento de um aplicativo mobile intuitivo em Flutter para acompanhar as cotações de criptomoedas em tempo real, utilizando a API da Coin Market Cap. O projeto segue o padrão arquitetural MVVM e implementa boas práticas de desenvolvimento mobile.

## 📚 Sobre o Projeto

Este aplicativo foi desenvolvido como parte de uma disciplina de Desenvolvimento de Software. Seu objetivo principal é fornecer uma interface clara e funcional para visualizar e pesquisar as cotações atuais de diversas criptomoedas, com valores formatados em USD e BRL.

A proposta é aplicar conceitos de arquitetura MVVM, gerenciamento de estado, consumo de APIs externas e boas práticas, resultando em uma ferramenta útil para quem deseja monitorar o mercado de criptoativos.

---

## ⚙️ Tecnologias Utilizadas

### 🔙 Mobile
- **Flutter**: Desenvolvimento mobile para criar uma interface de usuário nativa e de alta performance para Android e iOS.
- **Provider**: Pacote para gerenciamento de estado.
- **HTTP**: Realização de requisições.
- **Connectivity (Conexão)**: Verificação de conexão via internet.
- **Intl (Formatação)**: Formatação de valores sensíveis.


---

## 🧠 Como Funciona

1. **Requisição à API**: O aplicativo se "conecta" à API da Coin Market Cap para obter os dados das criptomoedas. A pesquisa pode ser feita por símbolos (separados por vírgula) ou usando uma lista padrão de criptomoedas.
2. **Processamento dos Dados**: Os dados recebidos da API são mapeados e processados.
3. **Exibição na Tela Principal**: A lista de criptomoedas é exibida com a sigla, nome, cotação em USD e BRL e sua variação.
4. **Interação do Usuário**: O usuário pode pesquisar criptomoedas por símbolo, usar um botão "Buscar e Atualizar" ou puxar a tela para baixo na lista para obter os dados mais recentes.

---

## 🛠️ Estrutura do Projeto

```bash
└───coin_tracking
    ├───lib
    │   ├───models
    │   └─crypto_currency.dart
    │   ├───services
    │   └─coinmkt_service.dart
    │   ├───views
    │   └─cryptoListVM.dart
    │   └───view_models
    │   └─cryptoListHM.dart
    └───main.dart

```

## 🚀 Como Rodar o Projeto Localmente

### Pré-requisitos

- Flutter 3.x.x
- API Key - Coin Market Cap
- Emulador ou Dispositivo Móvel

### Passo a passo

1. Clone o repositório:
```bash
git clone https://github.com/gabrsantos1/coin-tracking
cd coin_tracking
```

2. Realize a instalação das depenmdecias:
```bash
flutter pub get
```

3. Adicione sua API Key em lib\services\coin_market_cap_service.dart (desconsiderar esse passo para a correção)
```bash
final String _apiKey = 'API-KEY';
```

4. Executar a aplicação
```bash
flutter run
```


### 📝 Licença
Este projeto está sob a licença MIT. Veja o arquivo LICENSE para mais detalhes.