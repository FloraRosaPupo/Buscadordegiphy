# Buscador de GIFs

Busca, visualização e compartilhamento de GIFs da Giphy.

## Stack e organização
Flutter/Dart, HTTP, share e transparent_image. Defina `GIPHY_API_KEY` por `--dart-define`. A busca exige internet e chave válida. A configuração cliente é pública; restrinja a chave no provedor.

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
