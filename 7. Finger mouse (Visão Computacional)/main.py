# Importação das bibliotecas
import cv2
import mediapipe as mp
import pyautogui
import numpy as np
import speech_recognition as sr
import threading
import time
import pyttsx3
import webbrowser
from datetime import datetime
import tkinter as tk
from tkinter import messagebox
import os

# Inicializa configurações globais
pyautogui.FAILSAFE = True
voz = pyttsx3.init()
voz.setProperty('rate', 180)
voz.setProperty('volume', 1.0)

# Inicializa MediaPipe
mp_hands = mp.solutions.hands
mp_drawing = mp.solutions.drawing_utils
hands = mp_hands.Hands(min_detection_confidence=0.7, min_tracking_confidence=0.7)

# Captura resolução da tela e webcam
screen_width, screen_height = pyautogui.size()
cap = cv2.VideoCapture(0)

# Variável global
comando_voz = ""

# Funções auxiliares
def falar(texto):
    voz.say(texto)
    voz.runAndWait()

def distancia(a, b):
    return np.linalg.norm(np.array(a) - np.array(b))

def ouvir_comando():
    global comando_voz
    r = sr.Recognizer()
    with sr.Microphone() as source:
        while True:
            try:
                audio = r.listen(source, timeout=5)
                comando = r.recognize_google(audio, language='pt-BR')
                comando_voz = comando.lower()
            except:
                continue

def abrir_interface():
    def salvar():
        try:
            calibragem["pinça"] = int(entry_pinca.get())
            calibragem["copiar"] = int(entry_copiar.get())
            calibragem["enter"] = int(entry_enter.get())
            calibragem["fechar"] = int(entry_fechar.get())
            calibragem["print"] = int(entry_print.get())
            messagebox.showinfo("Sucesso", "Valores atualizados com sucesso!")
        except:
            messagebox.showerror("Erro", "Insira apenas números inteiros.")

# 🚩 Função para abrir o Windows Explorer
def executar_comando_explorer():
    try:
        os.system('start explorer')
        falar("Windows Explorer aberto.")
    except Exception as e:
        print(f"[Erro] {e}")
        falar("Erro ao abrir o Windows Explorer.")

# 🚩 Função para abrir as Configurações do Windows
def executar_comando_configuracoes():
    try:
        os.system('start ms-settings:')
        falar("Configurações do Windows abertas.")
    except Exception as e:
        print(f"[Erro] {e}")
        falar("Erro ao abrir as configurações do Windows.")

# 🚩 Função para abrir o Google, ativar microfone e pesquisar
def executar_comando_google():
    try:
        webbrowser.open("https://www.google.com")
        falar("Google aberto. Aguarde.")
        time.sleep(8)  # Tempo para carregar a página (ajustável)

        falar("O que você deseja pesquisar?")
        r = sr.Recognizer()
        with sr.Microphone() as source:
            try:
                audio = r.listen(source, timeout=5)
                comando = r.recognize_google(audio, language='pt-BR')
                print(f"🔍 Pesquisa: {comando}")
                falar(f"Pesquisando por {comando}")

                # Clica na caixa de texto de pesquisa
                pyautogui.click(600, 400)  # Ajuste a posição conforme seu monitor

                # Digita o que foi falado
                pyautogui.typewrite(comando)
                pyautogui.press('enter')

            except Exception as e:
                print(f"[Erro] {e}")
                falar("Não consegui ouvir. Tente novamente.")
    except Exception as e:
        print(f"[Erro] {e}")
        falar("Ocorreu um erro ao abrir o Google.")


    janela = tk.Tk()
    janela.title("Calibragem de Gestos")
    campos = ["Pinça (clique)", "Copiar", "Enter (print)", "Fechar aba", "Print antigo"]
    chaves = ["pinça", "copiar", "enter", "fechar", "print"]
    entradas = []
    for i, campo in enumerate(campos):
        tk.Label(janela, text=campo).grid(row=i, column=0)
        entry = tk.Entry(janela)
        entry.insert(0, str(calibragem[chaves[i]]))
        entry.grid(row=i, column=1)
        entradas.append(entry)
    entry_pinca, entry_copiar, entry_enter, entry_fechar, entry_print = entradas
    tk.Button(janela, text="Salvar", command="salvar").grid(row=5, columnspan=2)
    janela.mainloop()

def executar_comando_youtube():
    try:
        chrome_path = 'C:/Program Files/Google/Chrome/Application/chrome.exe %s'
        webbrowser.get(chrome_path).open("https://www.youtube.com")
        print("✅ YouTube aberto.")
        falar("YouTube aberto. Aguarde o carregamento da página.")
        time.sleep(8)  # Aguarda carregamento da página do YouTube

        # Clica no ícone do microfone (posição baseada em resolução padrão)
        pyautogui.moveTo(1290, 135)  # ajuste para resoluções diferentes
        pyautogui.click()
        print("🎤 Microfone do YouTube ativado")
        falar("Pode dizer o que deseja procurar")

        # Aguarda tempo suficiente para o usuário falar e YouTube processar
        time.sleep(6)

        # Pressiona ENTER para confirmar busca
        pyautogui.press('enter')
        time.sleep(5)
        pyautogui.press('tab')  # Seleciona primeiro vídeo
        pyautogui.press('enter')

    except Exception as e:
        print(f"[Erro] {e}")
        falar("Ocorreu um erro durante a busca.")

# Calibragem inicial dos gestos
calibragem = {
    "pinça": 20,
    "copiar": 25,
    "enter": 80,
    "fechar": 15,
    "print": 100
}

# Inicia as threads
threading.Thread(target=ouvir_comando, daemon=True).start()
threading.Thread(target=abrir_interface, daemon=True).start()

# Loop principal
while cap.isOpened():
    ret, frame = cap.read()
    if not ret:
        break

    frame = cv2.flip(frame, 1)
    h, w, _ = frame.shape
    rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    results = hands.process(rgb)

    if results.multi_hand_landmarks:
        for hand in results.multi_hand_landmarks:
            mp_drawing.draw_landmarks(frame, hand, mp_hands.HAND_CONNECTIONS)
            lm = hand.landmark
            pos = lambda id: (int(lm[id].x * w), int(lm[id].y * h))

            id_x, id_y = pos(mp_hands.HandLandmark.INDEX_FINGER_TIP)
            th_x, th_y = pos(mp_hands.HandLandmark.THUMB_TIP)
            mi_x, mi_y = pos(mp_hands.HandLandmark.MIDDLE_FINGER_TIP)
            ri_x, ri_y = pos(mp_hands.HandLandmark.RING_FINGER_TIP)
            pi_x, pi_y = pos(mp_hands.HandLandmark.PINKY_TIP)

            cursor_x = np.interp(id_x, [0, w], [0, screen_width])
            cursor_y = np.interp(id_y, [0, h], [0, screen_height])
            try: pyautogui.moveTo(cursor_x, cursor_y)
            except: pass

            if distancia((id_x, id_y), (th_x, th_y)) < calibragem["pinça"]:
                try: pyautogui.click(); time.sleep(0.3)
                except: pass

            if distancia((id_x, id_y), (mi_x, mi_y)) < calibragem["copiar"] and distancia((th_x, th_y), (ri_x, ri_y)) > 40:
                try: pyautogui.hotkey('ctrl', 'c'); time.sleep(0.5)
                except: pass

            if th_y < id_y and distancia((th_x, th_y), (id_x, id_y)) > calibragem["enter"]:
                try:
                    # Cria a pasta "Capturas" se não existir
                    if not os.path.exists("Capturas"):
                        os.makedirs("Capturas")

                    # Gera o nome do arquivo e salva na pasta
                    now = datetime.now().strftime("%Y%m%d_%H%M%S")
                    caminho_arquivo = os.path.join("Capturas", f"screenshot_{now}.png")
                    pyautogui.screenshot(caminho_arquivo)
                    print(f"📸 Print tirado: {caminho_arquivo}")
                except:
                    print("[Erro] Falha ao tirar print.")

            if all(distancia(pos(mp_hands.HandLandmark.INDEX_FINGER_TIP), pos(id)) < 30 for id in [
                mp_hands.HandLandmark.MIDDLE_FINGER_TIP,
                mp_hands.HandLandmark.RING_FINGER_TIP,
                mp_hands.HandLandmark.PINKY_TIP,
                mp_hands.HandLandmark.THUMB_TIP]):
                try: pyautogui.hotkey('ctrl', 'v'); time.sleep(0.5)
                except: pass

            rock_dist = distancia(pos(mp_hands.HandLandmark.MIDDLE_FINGER_TIP), pos(mp_hands.HandLandmark.RING_FINGER_TIP))
            if rock_dist < calibragem["fechar"] and distancia(pos(mp_hands.HandLandmark.PINKY_TIP), pos(mp_hands.HandLandmark.INDEX_FINGER_TIP)) > 60:
                try: pyautogui.hotkey('ctrl', 'w'); time.sleep(0.5)
                except: pass

            if mi_y > id_y + 40:
                try: pyautogui.scroll(-300); time.sleep(0.5)
                except: pass
            if mi_y < id_y - 40:
                try: pyautogui.scroll(300); time.sleep(0.5)
                except: pass

    if "abrir youtube" in comando_voz:
        comando_voz = ""
        executar_comando_youtube()

    if "fechar o youtube" in comando_voz:
        comando_voz = ""
        pyautogui.hotkey('ctrl', 'w')
        falar("YouTube fechado.")
    # ✅ Abrir Windows Explorer
    if "abrir windows explorer" in comando_voz:
        comando_voz = ""
        executar_comando_explorer()

    # ✅ Abrir Configurações do Windows
    if "abrir configurações" in comando_voz:
        comando_voz = ""
        executar_comando_configuracoes()

    # ✅ Abrir Google, ativar microfone e pesquisar
    if "abrir google" in comando_voz:
        comando_voz = ""
        executar_comando_google()

    cv2.imshow("Controle com Gestos + Voz", frame)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Finaliza recursos
cap.release()
cv2.destroyAllWindows()
