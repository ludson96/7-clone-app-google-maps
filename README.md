# 7-clone-app-google-maps

Um aplicativo mobile desenvolvido em Flutter que recria a interface e algumas das funcionalidades principais do Google Maps.

## 🗺️ Funcionalidades

- **Exibição de Mapa Interativo:** Utiliza a SDK do Google Maps para exibir os mapas e explorar o ambiente.
- **Estilização Customizada:** Carrega um tema personalizado para o mapa em tempo de execução via arquivo JSON.
- **Geolocalização Dinâmica:** Identifica a localização atual do usuário.
- **Tratamento Inteligente de Permissões:**
  - Detecta e alerta caso o serviço de localização (GPS) esteja desligado.
  - Solicita permissões e guia o usuário até as configurações caso a permissão seja negada.
- **Gestão de Ciclo de Vida:** Atualiza automaticamente o mapa e verifica permissões quando o aplicativo volta do modo background para o primeiro plano.
- **Navegação (Bottom Navigation):** Interface moderna baseada em Material Design 3 com abas funcionais (Explorar, Salvos, Contribuir).

## 🛠️ Tecnologias e Pacotes Utilizados

- [Flutter](https://flutter.dev/) - Framework de UI
- [google_maps_flutter](https://pub.dev/packages/google_maps_flutter) - Integração oficial com a API do Google Maps
- [geolocator](https://pub.dev/packages/geolocator) - Gerenciamento robusto de localização e permissões de GPS

## 🚀 Como executar o projeto

### Pré-requisitos
- Ter o Flutter SDK instalado em sua máquina.
- Um emulador ou dispositivo físico (Android/iOS) para testes.
- Configurar as suas próprias **Chaves de API do Google Maps** nas plataformas nativas.

### Passos de Instalação

1. Clone este repositório:
   ```bash
   git clone https://github.com/ludson96/7-clone-app-google-maps.git
   ```
2. Acesse a pasta do projeto e instale as dependências:
   ```bash
   flutter pub get
   ```
3. Execute o aplicativo:
   ```bash
   flutter run
   ```
