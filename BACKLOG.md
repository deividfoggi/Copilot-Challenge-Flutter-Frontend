# Backlog - Secretaria Real Time Tracking MVP

**Projeto:** Sistema de Monitoramento em Tempo Real de Conectividade de Escolas  
**Tecnologia:** Flutter 3.27+ / Dart 3.6+  
**Objetivo:** MVP com todas as funcionalidades principais  
**Data de Início:** Fevereiro 2026

---

## 📊 Resumo de Épicos

| Épico | Prioridade | Status | Stories | Estimativa |
|-------|-----------|--------|---------|------------|
| EP01 - Setup e Infraestrutura | 🔴 Crítica | 📋 To Do | 3 | 2 dias |
| EP02 - Autenticação e Segurança | 🔴 Crítica | 📋 To Do | 4 | 3 dias |
| EP03 - Dashboard Principal | 🔴 Crítica | 📋 To Do | 5 | 4 dias |
| EP04 - Unidades Offline | 🟡 Alta | 📋 To Do | 4 | 3 dias |
| EP05 - Status Educação | 🟡 Alta | 📋 To Do | 3 | 2 dias |
| EP06 - Alertas Prioritários | 🟡 Alta | 📋 To Do | 4 | 3 dias |
| EP07 - Central de Unidades | 🟢 Média | 📋 To Do | 4 | 3 dias |
| EP08 - Componentes e UI/UX | 🟡 Alta | 📋 To Do | 4 | 3 dias |
| EP09 - Performance e Otimizações | 🟢 Média | 📋 To Do | 3 | 2 dias |
| EP10 - Qualidade e Testes | 🟡 Alta | 📋 To Do | 3 | 2 dias |

**Total Estimado:** 27 dias de desenvolvimento

---

## 🎯 EP01 - Setup e Infraestrutura

**Objetivo:** Preparar ambiente de desenvolvimento e estrutura base do projeto Flutter

### 📖 US01.1 - Configuração Inicial do Projeto
**Como** desenvolvedor  
**Quero** ter um projeto Flutter configurado corretamente  
**Para que** possa começar a desenvolver as funcionalidades

**Critérios de Aceitação:**
- [ ] Projeto Flutter criado com estrutura de pastas definida
- [ ] Dependências necessárias adicionadas ao pubspec.yaml
- [ ] Projeto executa sem erros em emulador/dispositivo

**Tasks:**
- [ ] Criar projeto Flutter com `flutter create --org com.secretaria.sample tracking`
- [ ] Estruturar pastas: `lib/core/`, `lib/features/`, `lib/shared/`, `lib/data/`
- [ ] Adicionar dependências: riverpod, go_router, dio, flutter_secure_storage, intl, data_table_2
- [ ] Configurar versão mínima SDK (Dart 3.6+, Flutter 3.27+)
- [ ] Testar build em Android e iOS

**Estimativa:** 4 horas

---

### 📖 US01.2 - Configuração de Lint e Qualidade de Código
**Como** desenvolvedor  
**Quero** ter regras de lint configuradas  
**Para que** o código mantenha padrões de qualidade

**Critérios de Aceitação:**
- [ ] Arquivo analysis_options.yaml configurado
- [ ] `flutter analyze` executa sem warnings críticos
- [ ] Regras de segurança aplicadas

**Tasks:**
- [ ] Configurar flutter_lints
- [ ] Adicionar regras customizadas de segurança
- [ ] Configurar prefer_const_constructors, avoid_print, etc.
- [ ] Documentar padrões de código no README

**Estimativa:** 2 horas

---

### 📖 US01.3 - Configuração de Ambientes (Dev/Prod)
**Como** desenvolvedor  
**Quero** suportar múltiplos ambientes  
**Para que** possa separar desenvolvimento de produção

**Critérios de Aceitação:**
- [ ] Flavors configurados (dev/prod)
- [ ] Constantes de ambiente separadas
- [ ] Scripts de build para cada ambiente

**Tasks:**
- [ ] Criar `lib/core/config/environment.dart`
- [ ] Configurar flavors no Android (build.gradle)
- [ ] Configurar schemes no iOS (Xcode)
- [ ] Criar scripts: `flutter run --flavor dev` e `--flavor prod`
- [ ] Documentar comandos de build

**Estimativa:** 4 horas

---

## 🔐 EP02 - Autenticação e Segurança

**Objetivo:** Implementar sistema de autenticação OAuth2/SSO simulado com segurança

### 📖 US02.1 - Tela de Login
**Como** usuário do sistema  
**Quero** fazer login com minhas credenciais  
**Para que** possa acessar o sistema de monitoramento

**Critérios de Aceitação:**
- [ ] Tela de login com campos usuário e senha
- [ ] Validação de campos (obrigatórios, formato email)
- [ ] Botão de login funcional
- [ ] Loading state durante autenticação
- [ ] Mensagens de erro claras

**Tasks:**
- [ ] Criar `features/auth/presentation/login_screen.dart`
- [ ] Criar formulário com TextFormField e validações
- [ ] Implementar UI com logo Secretaria e branding
- [ ] Adicionar loading indicator
- [ ] Implementar tratamento de erros
- [ ] Adicionar animações de transição

**Estimativa:** 6 horas

---

### 📖 US02.2 - Serviço de Autenticação Mock
**Como** desenvolvedor  
**Quero** ter um serviço de autenticação simulado  
**Para que** possa testar fluxos de login/logout no MVP

**Critérios de Aceitação:**
- [ ] AuthService implementado com métodos login/logout/refresh
- [ ] Simulação de OAuth2 flow
- [ ] Armazenamento seguro de tokens
- [ ] Expiração e refresh de tokens simulados

**Tasks:**
- [ ] Criar `data/services/auth_service.dart`
- [ ] Implementar método `login(username, password)` (mock - aceita qualquer credencial válida)
- [ ] Implementar método `logout()`
- [ ] Implementar método `refreshToken()`
- [ ] Implementar método `getCurrentUser()`
- [ ] Usar flutter_secure_storage para persistir tokens mock
- [ ] Criar modelos: `UserModel`, `AuthToken`

**Estimativa:** 6 horas

---

### 📖 US02.3 - Proteção de Rotas
**Como** desenvolvedor  
**Quero** proteger rotas que requerem autenticação  
**Para que** usuários não autenticados não acessem áreas restritas

**Critérios de Aceitação:**
- [ ] Rotas protegidas redirecionam para login
- [ ] Usuário autenticado acessa todas as rotas
- [ ] Logout limpa sessão e redireciona para login

**Tasks:**
- [ ] Configurar GoRouter com redirect logic
- [ ] Criar `auth_guard.dart`
- [ ] Implementar verificação de token em cada navegação
- [ ] Criar provider para estado de autenticação (Riverpod)
- [ ] Testar fluxos: não autenticado → login → dashboard → logout

**Estimativa:** 4 horas

---

### 📖 US02.4 - Segurança de Dados
**Como** desenvolvedor  
**Quero** implementar práticas de segurança  
**Para que** dados sensíveis estejam protegidos

**Critérios de Aceitação:**
- [ ] Tokens não aparecem em logs
- [ ] Preparação para certificate pinning
- [ ] ProGuard configurado para Android
- [ ] Code obfuscation preparado

**Tasks:**
- [ ] Configurar Dio interceptor para logging seguro (mascarar tokens)
- [ ] Preparar estrutura para certificate pinning
- [ ] Adicionar ProGuard rules em `android/app/proguard-rules.pro`
- [ ] Configurar obfuscation em build.gradle
- [ ] Revisar permissões em AndroidManifest.xml e Info.plist
- [ ] Documentar práticas de segurança

**Estimativa:** 4 horas

---

## 📊 EP03 - Dashboard Principal

**Objetivo:** Implementar tela principal com visão geral de alertas e status

### 📖 US03.1 - Estrutura Base do Dashboard
**Como** usuário  
**Quero** ver uma visão geral do sistema ao fazer login  
**Para que** possa identificar rapidamente problemas

**Critérios de Aceitação:**
- [ ] Layout do dashboard com header e área de conteúdo
- [ ] Navigation drawer lateral funcionando
- [ ] Header com título, busca e notificações
- [ ] Filtro por região funcional

**Tasks:**
- [ ] Criar `features/dashboard/presentation/dashboard_screen.dart`
- [ ] Implementar AppBar com busca e filtros
- [ ] Criar drawer lateral (menu de navegação)
- [ ] Implementar layout responsivo (Grid/Wrap para cards)
- [ ] Adicionar dropdown de regiões

**Estimativa:** 6 horas

---

### 📖 US03.2 - Cards de Alertas
**Como** gestor  
**Quero** ver cards com contadores de alertas por tipo  
**Para que** possa priorizar ações

**Critérios de Aceitação:**
- [ ] 4 cards de alertas exibidos: ROTEADOR, FIREWALL, SDWAN, STARLINK
- [ ] Cada card mostra número de ocorrências
- [ ] Cards clicáveis levam para detalhes
- [ ] Visual consistente com design system

**Tasks:**
- [ ] Criar widget `alert_card.dart` em `shared/widgets/`
- [ ] Implementar grid de 4 cards
- [ ] Criar provider para buscar dados de alertas (Riverpod)
- [ ] Adicionar ícones customizados para cada tipo
- [ ] Implementar navegação ao clicar nos cards
- [ ] Adicionar animações de entrada

**Estimativa:** 6 hours

---

### 📖 US03.3 - Tabela de Alertas por Unidade Regional
**Como** gestor  
**Quero** ver uma tabela detalhada de alertas por unidade regional  
**Para que** possa entender a distribuição geográfica dos problemas

**Critérios de Aceitação:**
- [ ] Tabela com colunas para cada tipo de equipamento
- [ ] Dados exibidos por unidade regional (ADAMANTINA, AMERICANA, etc.)
- [ ] Células com números de ocorrências
- [ ] Valores "0" exibidos claramente

**Tasks:**
- [ ] Criar componente de tabela colapsável
- [ ] Implementar DataTable com colunas: UNIDADE, ROTEADOR, FIREWALL, STARLINK, etc.
- [ ] Criar model `UnidadeRegionalStatus`
- [ ] Implementar provider para dados da tabela
- [ ] Adicionar scroll horizontal para tabela larga
- [ ] Estilizar células (cores, padding)

**Estimativa:** 6 horas

---

### 📖 US03.4 - Auto-refresh do Dashboard
**Como** usuário  
**Quero** que os dados do dashboard sejam atualizados automaticamente  
**Para que** eu veja informações em tempo real

**Critérios de Aceitação:**
- [ ] Dashboard atualiza a cada 30 segundos
- [ ] Indicador visual de "última atualização"
- [ ] Botão manual para forçar refresh
- [ ] Auto-refresh pausa quando app está em background

**Tasks:**
- [ ] Implementar Timer.periodic para auto-refresh
- [ ] Adicionar indicador "Atualização em: ⏱️ 36s"
- [ ] Criar botão de refresh manual no AppBar
- [ ] Usar WidgetsBindingObserver para detectar app lifecycle
- [ ] Pausar timer quando app está inativo
- [ ] Adicionar pull-to-refresh gesture

**Estimativa:** 4 horas

---

### 📖 US03.5 - Estado de Loading e Erros
**Como** usuário  
**Quero** ver feedback visual quando dados estão carregando  
**Para que** eu saiba que o sistema está funcionando

**Critérios de Aceitação:**
- [ ] Skeleton loading ao carregar pela primeira vez
- [ ] Mensagem de erro quando falha
- [ ] Botão de retry em caso de erro
- [ ] Transições suaves entre estados

**Tasks:**
- [ ] Criar `loading_overlay.dart` widget
- [ ] Criar `error_widget.dart` com retry button
- [ ] Implementar estados AsyncValue do Riverpod
- [ ] Adicionar shimmer effect para skeleton
- [ ] Testar cenários de erro

**Estimativa:** 4 horas

---

## 📴 EP04 - Unidades Offline

**Objetivo:** Implementar listagem e filtragem de unidades offline

### 📖 US04.1 - Listagem de Unidades Offline
**Como** gestor técnico  
**Quero** ver uma lista de todas as unidades offline  
**Para que** possa tomar ações corretivas

**Critérios de Aceitação:**
- [ ] Tabela com todas as unidades offline
- [ ] Colunas: Ocorrência Ativa, Tipo Unidade, CIE, Tipo de Ocorrência, Tipo de Link, Nome Unidade, Ações
- [ ] Dados carregados do mock
- [ ] Paginação funcional

**Tasks:**
- [ ] Criar `features/unidades/presentation/unidades_offline_screen.dart`
- [ ] Criar model `UnidadeOffline`
- [ ] Criar JSON mock em `assets/mock_data/unidades_offline.json`
- [ ] Implementar repository `UnidadeRepository`
- [ ] Criar DataTable com data_table_2 package
- [ ] Implementar paginação (20 itens por página)
- [ ] Adicionar números de ocorrência clicáveis (navegação)

**Estimativa:** 6 horas

---

### 📖 US04.2 - Filtros e Busca
**Como** usuário  
**Quero** filtrar unidades por tipo de link, ocorrência e unidade  
**Para que** possa encontrar informações específicas rapidamente

**Critérios de Aceitação:**
- [ ] 3 dropdowns de filtro: Tipo de Link, Tipo de Ocorrência, Tipo de Unidade
- [ ] Filtros aplicam-se em tempo real
- [ ] Contador de resultados filtrados
- [ ] Botão para limpar filtros

**Tasks:**
- [ ] Criar componente `filter_section.dart`
- [ ] Implementar 3 dropdowns com opções
- [ ] Criar provider para estado dos filtros
- [ ] Implementar lógica de filtragem
- [ ] Adicionar contador "Total: X unidades"
- [ ] Botão "Limpar Filtros"

**Estimativa:** 4 horas

---

### 📖 US04.3 - Ordenação de Colunas
**Como** usuário  
**Quero** ordenar a tabela por qualquer coluna  
**Para que** possa analisar dados de forma organizada

**Critérios de Aceitação:**
- [ ] Clique no header ordena crescente/decrescente
- [ ] Indicador visual de coluna ordenada
- [ ] Ordenação mantida ao filtrar

**Tasks:**
- [ ] Implementar sorting em data_table_2
- [ ] Adicionar ícones de ordenação (↑↓)
- [ ] Criar lógica de sort para cada tipo de coluna
- [ ] Testar sort com filtros ativos

**Estimativa:** 3 horas

---

### 📖 US04.4 - Export de Dados
**Como** gestor  
**Quero** exportar a lista de unidades offline  
**Para que** possa compartilhar com equipe ou gerar relatórios

**Critérios de Aceitação:**
- [ ] Botão "Excel" presente
- [ ] Botão "CSV" presente
- [ ] Ao clicar, mostra mensagem de confirmação (mock)
- [ ] Exporta apenas dados filtrados

**Tasks:**
- [ ] Criar componente `export_buttons.dart`
- [ ] Implementar botões Excel e CSV
- [ ] Mock de export (mostrar SnackBar: "Exportado com sucesso")
- [ ] Preparar estrutura para futura implementação real
- [ ] Documentar formato de export esperado

**Estimativa:** 2 horas

---

## 📊 EP05 - Status Educação

**Objetivo:** Monitorar status de plataformas educacionais e administrativas

### 📖 US05.1 - Visualização de Status das Plataformas
**Como** gestor de TI  
**Quero** ver o status de todas as plataformas educacionais  
**Para que** possa garantir disponibilidade dos serviços

**Critérios de Aceitação:**
- [ ] 2 tabelas: Administrativas e Educacionais Core
- [ ] Indicadores de status (online/offline/intermitente)
- [ ] Métricas: Load Página, Login, Deploy, Uptime/Downtime
- [ ] Legendas claras

**Tasks:**
- [ ] Criar `features/status/presentation/status_secretaria_screen.dart`
- [ ] Criar model `PlataformaStatus`
- [ ] Criar JSON mock com dados das 11 plataformas
- [ ] Implementar 2 DataTables separadas
- [ ] Criar widget `status_indicator.dart` (ícone colorido)
- [ ] Adicionar legenda com cores

**Estimativa:** 6 horas

---

### 📖 US05.2 - Auto-refresh de Status
**Como** usuário  
**Quero** que o status das plataformas seja atualizado automaticamente  
**Para que** eu veja dados em tempo real

**Critérios de Aceitação:**
- [ ] Atualização a cada 60 segundos
- [ ] Indicador de última atualização
- [ ] Transições suaves ao atualizar dados

**Tasks:**
- [ ] Implementar Timer.periodic (60s)
- [ ] Adicionar timestamp "Atualização em: ⏱️"
- [ ] Simular mudanças de status no mock
- [ ] Adicionar animações de transição

**Estimativa:** 3 horas

---

### 📖 US05.3 - Detalhamento de Métricas
**Como** analista técnico  
**Quero** ver métricas detalhadas de performance  
**Para que** possa identificar gargalos

**Critérios de Aceitação:**
- [ ] Métricas exibidas em milissegundos
- [ ] Formatação clara (263ms, 136ms)
- [ ] Deploy status indicado (ícone ou texto)
- [ ] Porcentagens de uptime/downtime

**Tasks:**
- [ ] Implementar formatação de números (intl package)
- [ ] Criar helper para formatar métricas
- [ ] Adicionar formatação de porcentagens
- [ ] Implementar ícones para deploy status
- [ ] Adicionar tooltips explicativos

**Estimativa:** 3 horas

---

## 🚨 EP06 - Alertas Prioritários

**Objetivo:** Gerenciar e visualizar alertas com maior tempo de inatividade

### 📖 US06.1 - Listagem de Alertas Prioritários
**Como** gestor  
**Quero** ver alertas ordenados por prioridade/tempo  
**Para que** possa resolver problemas mais críticos primeiro

**Critérios de Aceitação:**
- [ ] Tabela com todos os alertas
- [ ] Colunas: Cód. Ocorrência, Tipo Conexão, Tipo Ocorrência, Tempo Aberta, URE, CIE/COD, Unidade, Ações
- [ ] Total de ocorrências exibido
- [ ] Cores diferentes por tempo offline

**Tasks:**
- [ ] Criar `features/alertas/presentation/alertas_prioritarios_screen.dart`
- [ ] Criar model `AlertaPrioritario`
- [ ] Criar JSON mock com ~2600 alertas
- [ ] Implementar DataTable com paginação
- [ ] Adicionar lógica de cores por tempo (>4h: preto, 4h: vermelho, <12min: amarelo)
- [ ] Adicionar legenda de cores

**Estimativa:** 6 horas

---

### 📖 US06.2 - Ordenação de Alertas
**Como** usuário  
**Quero** ordenar alertas por diferentes critérios  
**Para que** possa priorizar minha análise

**Critérios de Aceitação:**
- [ ] Dropdown "Ordenar por" com opções
- [ ] Opção "Maior tempo" como padrão
- [ ] Ordenação aplicada instantaneamente

**Tasks:**
- [ ] Criar dropdown de ordenação
- [ ] Implementar opções: Maior tempo, Menor tempo, URE, Tipo de ocorrência
- [ ] Atualizar provider com lógica de sort
- [ ] Manter ordenação ao paginar

**Estimativa:** 3 horas

---

### 📖 US06.3 - Filtros de Alertas
**Como** usuário  
**Quero** filtrar alertas por múltiplos critérios  
**Para que** possa focar em problemas específicos

**Critérios de Aceitação:**
- [ ] Filtros por coluna funcionais
- [ ] Múltiplos filtros aplicáveis simultaneamente
- [ ] Contador de alertas filtrados

**Tasks:**
- [ ] Implementar filtros em cada coluna do DataTable
- [ ] Criar lógica de filtro combinado
- [ ] Atualizar contador "Total de Ocorrências: X (Filtradas: Y)"
- [ ] Adicionar clear filters button

**Estimativa:** 4 horas

---

### 📖 US06.4 - Ações em Alertas
**Como** técnico  
**Quero** visualizar detalhes de um alerta  
**Para que** possa tomar ação corretiva

**Critérios de Aceitação:**
- [ ] Ícone de ação/visualizar em cada linha
- [ ] Clique abre detalhes do alerta (modal ou página)
- [ ] Informações completas exibidas

**Tasks:**
- [ ] Adicionar coluna "Ações" com ícone
- [ ] Criar modal/página de detalhes
- [ ] Implementar navegação para detalhes
- [ ] Mostrar timeline da ocorrência (mock)

**Estimativa:** 4 horas

---

## 🏢 EP07 - Central de Unidades

**Objetivo:** Gerenciar cadastro de unidades escolares

### 📖 US07.1 - Listagem de Unidades
**Como** administrador  
**Quero** ver todas as unidades cadastradas  
**Para que** possa gerenciar o cadastro

**Critérios de Aceitação:**
- [ ] Tabela com todas as unidades
- [ ] Colunas: Id, Tipo unidade, COD/CIE, URE, Nome Unidade, Ações
- [ ] Paginação funcional
- [ ] Botões de editar e excluir

**Tasks:**
- [ ] Criar `features/unidades/presentation/central_unidades_screen.dart`
- [ ] Criar model `Unidade`
- [ ] Criar JSON mock com unidades
- [ ] Implementar DataTable com ações
- [ ] Adicionar ícones de editar (lápis) e excluir (lixeira)

**Estimativa:** 5 horas

---

### 📖 US07.2 - Busca e Filtros
**Como** usuário  
**Quero** buscar unidades por nome, tipo ou CIE  
**Para que** possa encontrar rapidamente uma unidade específica

**Critérios de Aceitação:**
- [ ] Barra de busca com debounce
- [ ] Filtros: Tipo de Unidade, Nome, CIE
- [ ] Resultados em tempo real

**Tasks:**
- [ ] Implementar search bar com debounce (500ms)
- [ ] Criar 3 filtros dropdown/input
- [ ] Implementar lógica de busca combinada
- [ ] Adicionar clear search button

**Estimativa:** 4 horas

---

### 📖 US07.3 - Adicionar Nova Unidade
**Como** administrador  
**Quero** adicionar uma nova unidade ao sistema  
**Para que** ela seja monitorada

**Critérios de Aceitação:**
- [ ] Botão "Adicionar uma nova Unidade"
- [ ] Formulário com todos os campos necessários
- [ ] Validações de campos obrigatórios
- [ ] Mock de salvamento

**Tasks:**
- [ ] Criar botão no header
- [ ] Criar `unidade_form_screen.dart` ou modal
- [ ] Implementar formulário com campos: Tipo, COD/CIE, URE, Nome
- [ ] Adicionar validações
- [ ] Mock de POST (mostrar SnackBar de sucesso)
- [ ] Atualizar lista após adicionar

**Estimativa:** 5 horas

---

### 📖 US07.4 - Editar e Excluir Unidade
**Como** administrador  
**Quero** editar ou excluir unidades existentes  
**Para que** possa manter o cadastro atualizado

**Critérios de Aceitação:**
- [ ] Botão de editar abre formulário preenchido
- [ ] Botão de excluir mostra confirmação
- [ ] Mock de update/delete funcionando

**Tasks:**
- [ ] Implementar ação de editar (reutilizar form)
- [ ] Preencher form com dados existentes
- [ ] Implementar dialog de confirmação para exclusão
- [ ] Mock de PUT e DELETE
- [ ] Atualizar lista após editar/excluir

**Estimativa:** 4 horas

---

## 🎨 EP08 - Componentes e UI/UX

**Objetivo:** Criar componentes reutilizáveis e tema consistente

### 📖 US08.1 - Tema e Design System
**Como** desenvolvedor  
**Quero** ter um tema consistente em toda a aplicação  
**Para que** a UI seja profissional e coesa

**Critérios de Aceitação:**
- [ ] Tema Material 3 configurado
- [ ] Cores consistentes com mockups
- [ ] Tipografia definida
- [ ] Componentes seguem design system

**Tasks:**
- [ ] Criar `core/theme/app_theme.dart`
- [ ] Definir ColorScheme (azul #1976D2, teal #26A69A)
- [ ] Configurar ThemeData para light e dark mode
- [ ] Definir TextTheme (tamanhos, pesos)
- [ ] Criar constantes de spacing e corners
- [ ] Documentar design tokens

**Estimativa:** 4 horas

---

### 📖 US08.2 - Navigation Drawer
**Como** usuário  
**Quero** um menu lateral para navegar entre seções  
**Para que** possa acessar todas as funcionalidades

**Critérios de Aceitação:**
- [ ] Drawer com logo e nome do usuário
- [ ] Todos os itens do menu clicáveis
- [ ] Item ativo destacado
- [ ] Funcionamento em todas as telas

**Tasks:**
- [ ] Criar `shared/widgets/app_drawer.dart`
- [  ] Adicionar header com logo Secretaria
- [ ] Implementar 11 itens do menu
- [ ] Adicionar ícones para cada item
- [ ] Implementar navegação com GoRouter
- [ ] Destacar item ativo

**Estimativa:** 5 horas

---

### 📖 US08.3 - Componentes Reutilizáveis
**Como** desenvolvedor  
**Quero** componentes reutilizáveis para UI comum  
**Para que** o desenvolvimento seja mais rápido e consistente

**Critérios de Aceitação:**
- [ ] 5+ componentes criados
- [ ] Componentes documentados
- [ ] Componentes usados em múltiplas telas

**Tasks:**
- [ ] Criar `shared/widgets/alert_card.dart` (card de alerta com ícone)
- [ ] Criar `shared/widgets/status_indicator.dart` (verde/vermelho/amarelo)
- [ ] Criar `shared/widgets/data_table_with_filters.dart` (tabela genérica)
- [ ] Criar `shared/widgets/export_buttons.dart` (Excel/CSV)
- [ ] Criar `shared/widgets/loading_overlay.dart`
- [ ] Criar `shared/widgets/error_widget.dart`
- [ ] Documentar uso de cada componente

**Estimativa:** 6 horas

---

### 📖 US08.4 - Responsividade
**Como** usuário  
**Quero** que o app funcione bem em tablet e celular  
**Para que** eu possa usar em qualquer dispositivo

**Critérios de Aceitação:**
- [ ] Layout adapta-se a diferentes tamanhos de tela
- [ ] Tabelas scrollam horizontalmente em mobile
- [ ] Drawer funciona bem em ambos os formatos
- [ ] Testado em phone e tablet

**Tasks:**
- [ ] Implementar LayoutBuilder para detecção de tamanho
- [ ] Ajustar grid de cards (1 col mobile, 2-4 cols tablet/desktop)
- [ ] Tornar tabelas scrollable horizontalmente
- [ ] Testar em diferentes resoluções
- [ ] Ajustar padding/margin por breakpoint

**Estimativa:** 4 horas

---

## ⚡ EP09 - Performance e Otimizações

**Objetivo:** Garantir app fluido e responsivo

### 📖 US09.1 - Otimização de Renderização
**Como** desenvolvedor  
**Quero** minimizar rebuilds desnecessários  
**Para que** o app tenha 60 FPS constantes

**Critérios de Aceitação:**
- [ ] FPS médio > 60 em profile mode
- [ ] Sem janks visíveis em DevTools
- [ ] Lista longa com lazy loading

**Tasks:**
- [ ] Adicionar `const` constructors onde possível
- [ ] Implementar RepaintBoundary em widgets estáticos
- [ ] Usar ListView.builder e ListView.separated
- [ ] Implementar lazy loading em tabelas
- [ ] Profile com DevTools e corrigir jank
- [ ] Documentar otimizações aplicadas

**Estimativa:** 4 horas

---

### 📖 US09.2 - Otimização de Assets e Bundles
**Como** desenvolvedor  
**Quero** minimizar tamanho do app  
**Para que** download e instalação sejam rápidos

**Critérios de Aceitação:**
- [ ] Bundle size < 20MB
- [ ] Imagens otimizadas
- [ ] Code splitting implementado

**Tasks:**
- [ ] Analisar bundle com `flutter build apk --analyze-size`
- [ ] Otimizar imagens (webp, compressão)
- [ ] Remover dependências não utilizadas
- [ ] Configurar deferred loading para rotas
- [ ] Documentar tamanho final do app

**Estimativa:** 3 horas

---

### 📖 US09.3 - Cache e Persistência
**Como** usuário  
**Quero** que o app carregue rápido em uso subsequente  
**Para que** eu tenha uma experiência fluida

**Critérios de Aceitação:**
- [ ] Dados em cache após primeira carga
- [ ] App funciona offline com dados cached
- [ ] Cache expira apropriadamente

**Tasks:**
- [ ] Implementar cache em memória com Riverpod
- [ ] Adicionar estratégia de cache (stale-while-revalidate)
- [ ] Implementar persistência local (shared_preferences)
- [ ] Adicionar lógica de expiração de cache
- [ ] Testar modo offline

**Estimativa:** 5 horas

---

## 🧪 EP10 - Qualidade e Testes

**Objetivo:** Garantir qualidade e estabilidade do código

### 📖 US10.1 - Análise Estática
**Como** desenvolvedor  
**Quero** garantir qualidade do código  
**Para que** não haja bugs óbvios

**Critérios de Aceitação:**
- [ ] `flutter analyze` sem erros
- [ ] Cobertura de código > 70%
- [ ] Documentação dos principais componentes

**Tasks:**
- [ ] Executar `flutter analyze` e corrigir issues
- [ ] Adicionar dartdoc nos principais arquivos
- [ ] Revisar código seguindo checklist
- [ ] Documentar arquitetura no README

**Estimativa:** 4 horas

---

### 📖 US10.2 - Testes Automatizados
**Como** desenvolvedor  
**Quero** ter testes automatizados  
**Para que** mudanças futuras não quebrem funcionalidades

**Critérios de Aceitação:**
- [ ] Testes unitários de models e services
- [ ] Testes de widgets principais
- [ ] CI configurado (opcional para MVP)

**Tasks:**
- [ ] Criar testes unitários para models
- [ ] Criar testes para repositories (mock)
- [ ] Criar widget tests para componentes principais
- [ ] Criar integration test do fluxo principal
- [ ] Configurar test coverage report
- [ ] Documentar como executar testes

**Estimativa:** 8 horas

---

### 📖 US10.3 - Validação Final
**Como** product owner  
**Quero** validar que todos os requisitos foram atendidos  
**Para que** o MVP possa ser entregue

**Critérios de Aceitação:**
- [ ] Todas as telas funcionando
- [ ] Navegação fluida
- [ ] Performance aceitável
- [ ] Build em Android e iOS sem erros

**Tasks:**
- [ ] Testar fluxo completo: login → dashboard → todas as telas → logout
- [ ] Verificar filtros e ordenação em todas as tabelas
- [ ] Testar auto-refresh
- [ ] Verificar responsividade em phone e tablet
- [ ] Executar `flutter run --profile` e verificar FPS
- [ ] Build APK e testar em dispositivo real
- [ ] Build iOS e testar em simulador
- [ ] Criar checklist de validação
- [ ] Documentar issues encontrados

**Estimativa:** 4 horas

---

## 📋 Notas de Implementação

### Ordem Sugerida de Desenvolvimento
1. **Semana 1:** EP01 → EP02 → EP03 → EP08.1 → EP08.2
2. **Semana 2:** EP04 → EP05 → EP06 → EP08.3
3. **Semana 3:** EP07 → EP08.4 → EP09 → EP10

### Dependências entre Épicos
- EP02 deve ser concluído antes de qualquer EP03-EP07
- EP08.1 e EP08.2 podem ser feitos em paralelo com outras features
- EP09 deve ser feito após maioria das features implementadas
- EP10 deve ser feito ao final

### Definition of Done (DoD)
Cada User Story está completa quando:
- [ ] Todas as tasks foram concluídas
- [ ] Código revisado por par
- [ ] `flutter analyze` sem erros
- [ ] Funcionalidade testada manualmente
- [ ] Documentação atualizada (se aplicável)
- [ ] Commit com mensagem descritiva
- [ ] Demo para stakeholder (se necessário)

### Estimativas Totais
- **Total de User Stories:** 37
- **Total de Tasks:** ~150
- **Estimativa Total:** 27 dias de desenvolvimento
- **Considerando overhead:** 4-5 semanas de calendário

---

*Documento criado em: Fevereiro 2026*  
*Última atualização: {{ date }}*
