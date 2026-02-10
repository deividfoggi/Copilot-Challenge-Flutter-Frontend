# Contoso Real Time Tracking

Sistema de Monitoramento em Tempo Real de Conectividade de Escolas.

## 🚀 Tecnologias

- **Flutter** 3.27+
- **Dart** 3.6+
- **Riverpod** - State Management
- **GoRouter** - Navigation
- **Dio** - HTTP Client
- **Flutter Secure Storage** - Secure Storage

## 📁 Estrutura do Projeto

```
lib/
├── core/
│   ├── config/         # Configurações de ambiente
│   ├── routes/         # Configuração de rotas
│   ├── theme/          # Tema e estilos
│   └── constants/      # Constantes da aplicação
├── features/
│   ├── auth/           # Autenticação
│   └── dashboard/      # Dashboard principal
├── shared/
│   ├── widgets/        # Widgets compartilhados
│   └── utils/          # Utilitários
└── main.dart
```

## 🔧 Configuração

### Pré-requisitos

- Flutter 3.27 ou superior
- Dart 3.6 ou superior

### Instalação

```bash
# Instalar dependências
flutter pub get

# Gerar código (Riverpod)
dart run build_runner build --delete-conflicting-outputs

# Executar análise de código
flutter analyze
```

### Executar o projeto

```bash
# Desenvolvimento
flutter run --flavor dev

# Produção
flutter run --flavor prod
```

## 🏗️ Ambientes

- **dev**: Ambiente de desenvolvimento
- **prod**: Ambiente de produção

## 📝 Padrões de Código

- Usar `const` sempre que possível
- Evitar `print()` (usar logger)
- Seguir as regras do `analysis_options.yaml`
- Documentar métodos públicos
- Preferir `single quotes` para strings

## 🧪 Testes

```bash
# Executar todos os testes
flutter test

# Executar testes com coverage
flutter test --coverage
```

## 🔒 Segurança

- Tokens armazenados com `flutter_secure_storage`
- Code obfuscation habilitado em produção
- Certificate pinning preparado para implementação
- ProGuard configurado para Android

## 📄 Licença

Propriedade da Contoso
