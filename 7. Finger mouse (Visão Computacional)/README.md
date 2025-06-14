# 🎯 Controle de Computador com Gestos e Voz

Este projeto permite **controlar o computador usando gestos das mãos e comandos de voz**, combinando visão computacional, automação de interface e reconhecimento de fala. Ideal para acessibilidade, automação pessoal ou experimentos com interfaces naturais.

---

## 🧠 Tecnologias Utilizadas

- **OpenCV** – Para captura e exibição da webcam.
- **MediaPipe** – Para rastreamento das mãos e detecção de gestos.
- **PyAutoGUI** – Para controle do mouse, teclado e ações de automação.
- **SpeechRecognition + Pyttsx3** – Para ouvir comandos de voz e responder com voz sintetizada.
- **Tkinter** – Para uma interface gráfica simples de calibragem.
- **Webbrowser + OS** – Para abrir sites e aplicativos do sistema.

---

## ⚙️ Funcionalidades

### ✋ Controle por Gestos:
- **Mover o cursor** com o dedo indicador.
- **Clique** com gesto de pinça (polegar + indicador).
- **Copiar** com gesto indicador + dedo médio próximos.
- **Colar** com gesto de mão fechada.
- **Print da tela** com gesto do polegar afastado para baixo.
- **Fechar aba** com gesto estilo "rock" 🤘.
- **Scroll para cima/baixo** com movimentos verticais do dedo médio.

### 🎙️ Comandos de Voz:
- `abrir youtube` – Abre o YouTube e permite buscar por voz.
- `fechar o youtube` – Fecha a aba atual.
- `abrir windows explorer` – Abre o gerenciador de arquivos do Windows.
- `abrir configurações` – Abre as configurações do Windows.
- `abrir google` – Abre o Google, escuta o termo desejado e realiza a pesquisa.

---

## 🖥️ Requisitos do Sistema

- Python 3.7 ou superior
- Webcam funcional
- Microfone (para comandos de voz)
- Sistema operacional Windows (para suporte ao `explorer`, `ms-settings:`)

---

## 📦 Instalação

1. **Clone o repositório**:
   ```bash
   git clone https://github.com/seu-usuario/seu-repositorio.git
   cd seu-repositorio
