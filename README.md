# Buscador de GIFs — Giphy

## Descrição

Aplicativo Flutter para visualizar GIFs em destaque, pesquisar no Giphy, carregar mais resultados e compartilhar GIFs. O acesso ao serviço exige uma chave da API Giphy.

## Stack e bibliotecas

Flutter/Dart, http, share e transparent_image.

Dependências e versões declaradas: [pubspec.yaml](pubspec.yaml).

## Funcionalidades

- GIFs em destaque.
- Busca e paginação.
- Detalhes e compartilhamento.

## Licença

Não há uma licença de distribuição definida para este repositório. Nenhuma licença MIT, Apache ou equivalente é concedida por este README. As atribuições e os direitos dos materiais de terceiros permanecem preservados.

## Validação e limites

Configuração ausente, query codificada, paginação e respostas inválidas. Compartilhamento e rede real exigem plataforma alvo.

## Executar
Use a versão de Flutter registrada em `.github/workflows/ci.yml`.
```sh
git clone https://github.com/FloraRosaPupo/Buscadordegiphy.git
cd Buscadordegiphy
flutter pub get
flutter run --dart-define=GIPHY_API_KEY=SUA_CHAVE
```

## Verificações
```sh
flutter analyze --no-fatal-infos --no-fatal-warnings
flutter test
```
A CI verifica erros de análise e os testes. Avisos e sugestões continuam visíveis no relatório do analisador. Testes locais não substituem a validação no dispositivo e dos serviços externos.

## Contribuir
Abra uma branch por alteração, descreva o comportamento esperado e inclua testes para regras ou regressões. Mantenha credenciais e arquivos gerados fora do Git.

## Organização e manutenção

Repositório da feature GIFs recebe HTTP e chave por injeção. A tela cuida de estado visual e chama o repositório; erros HTTP e formato são tratados fora do widget. Estado local continua adequado ao fluxo simples.

Veja [a revisão de desenvolvimento](docs/REVISAO.md) para decisões, testes e limites, e [o guia de contribuição](CONTRIBUTING.md) para o fluxo de manutenção.
