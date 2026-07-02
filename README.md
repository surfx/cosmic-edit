# Obs:

Fork do projeto [COSMIC EDITOR](https://github.com/pop-os/cosmic-edit), todos os direitos reservados aos autores.
# Cosmic Edit (fork)

Sessões habilitadas no cosmic edit

![Cosmic Edit Sessoes](res/screenshots/cosmic_fork_sessoes.png)

Este é um fork do [cosmic-edit](https://github.com/pop-os/cosmic-edit) com melhorias focadas em produtividade e experiência de usuário.

## Implementações Realizadas:

### 1. Persistência de Sessão e Gestão de Cache
*   **Salvamento Automático e em Tempo Real**: O editor agora salva o estado de todas as abas e projetos abertos não apenas ao fechar, mas também ao alternar abas, salvar arquivos ou fechar abas individuais.
*   **Restauração Inteligente**: Ao abrir o editor (mesmo clicando em um arquivo externo), ele primeiro restaura sua sessão anterior e backups não salvos de `~/.cache/cosmic-edit/backups/`.
*   **Indicadores Visuais de Alteração**: Corrigido o bug onde o indicador visual (ponto) de arquivos modificados não aparecia após restaurar a sessão.
*   **Limpeza Imediata de Cache**: Ao fechar uma aba sem salvar ou realizar um `Ctrl+S`, o cache de backup é removido instantaneamente do disco, garantindo higiene dos dados.

### 2. Arquitetura de Instância Única (Single-Instance IPC)
*   **Abertura em Abas**: Implementação de IPC via Unix Sockets. Se o editor já estiver aberto, novos arquivos clicados no gerenciador de arquivos abrem instantaneamente como novas abas na janela existente, em vez de criar múltiplas janelas.
*   **Foco Inteligente**: Tentar abrir o editor quando ele já está rodando (mesmo sem arquivos) traz a janela existente para o foco.

### 3. Suporte a Drag and Drop (Arrastar e Soltar) no Wayland
*   **Abertura Instantânea**: Agora é possível arrastar arquivos e pastas do gerenciador de arquivos diretamente para a janela do editor.
*   **Suporte Nativo COSMIC/Wayland**: Implementado usando `dnd_destination` com suporte a `text/uri-list` e decodificação de URIs, garantindo compatibilidade com caminhos contendo espaços e caracteres especiais (como "Área de Trabalho").

### 4. Otimização de Performance e Scripts
*   **Startup Instantâneo**: O script `run.sh` foi otimizado para executar o binário compilado diretamente, eliminando a lentidão das checagens do `cargo run` no uso diário.
*   **Scripts de Utilidade**:
    *   `kill.sh`: Finaliza instâncias de forma segura.
    *   `build.sh`: Compila o projeto de forma limpa.
    *   `run.sh`: Execução rápida com suporte a múltiplos argumentos.

### 5. Integração com o Sistema
*   **Atalho Desktop**: Criado o arquivo `cosmic-edit.desktop` e integrado ao menu do sistema (`~/.local/share/applications/`).
*   **Filtros de Log**: O terminal agora exibe logs limpos, ocultando erros irrelevantes de DBus/WGPU e focando nas ações do usuário.
*   **Limpeza de Código**: Removidos avisos de compilação (dead code) e variáveis não utilizadas.

### 5. Substituição do Editor do Sistema
Foi criado um script de instalação (`scripts/install_system_links.sh`) que permite usar esta versão modificada como o editor padrão do seu perfil de usuário:
*   **Override de Binário**: Cria um link em `~/.local/bin/cosmic-edit` para que o comando no terminal abra esta versão.
*   **Override de Menu**: Substitui o atalho original do COSMIC no menu de aplicativos para lançar esta versão com todas as melhorias.

## Como Executar
```bash
# Para integrar com o seu sistema (fazer uma vez):
./scripts/install_system_links.sh

# Via terminal
cosmic-edit

# Ou via menu do sistema procurando pelo ícone oficial do Cosmic Edit
```
# COSMIC Text Editor
Text editor for the COSMIC desktop

![Screenshot](res/screenshots/screenshot-1.png)

Currently an incomplete **pre-alpha**, this project is a work in progress - issues are expected.

## Testing
You can test by installing a current version of Rust and then building with `cargo`.

```SHELL
git clone https://github.com/pop-os/cosmic-edit
cd cosmic-edit
cargo build
```

You can get more detailed errors by using the `RUST_LOG` environment variables, that you can invoke for just that one command like this: `RUST_LOG=debug cargo run`. This will give you more detail about the application state. You can go even further with `RUST_LOG=trace cargo run`, that shows all logging details about the application.

## Clippy Lints
PRs are welcome, as it builds a better product for everyone. It is recommended that you check your code with Clippy Lints turned on. You can find more about [Configuring Clippy](https://doc.rust-lang.org/nightly/clippy/configuration.html) here.
