# Buscador de GIFs

Busca, visualização e compartilhamento de GIFs da Giphy.

## Stack e organização
Flutter/Dart, http, share e transparent_image.

Repositório da feature GIFs recebe HTTP e chave por injeção. A tela cuida de estado visual e chama o repositório; erros HTTP e formato são tratados fora do widget. Estado local continua adequado ao fluxo simples.

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

## Licença
Não há licença de distribuição definida neste repositório.


## Funcionalidades

- GIFs em destaque.
- busca e paginação.
- detalhes e compartilhamento.


## Organização e manutenção

Repositório da feature GIFs recebe HTTP e chave por injeção. A tela cuida de estado visual e chama o repositório; erros HTTP e formato são tratados fora do widget. Estado local continua adequado ao fluxo simples.

Veja [a revisão de desenvolvimento](docs/REVISAO.md) para decisões, testes e limites, e [o guia de contribuição](CONTRIBUTING.md) para o fluxo de manutenção.
