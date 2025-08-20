
# 🌐 Npcap – Packet Capture Library for Windows

![License](https://img.shields.io/badge/license-GPL--2.0-blue) ![Platform](https://img.shields.io/badge/platform-Windows%207%2B-lightgrey) ![Build](https://img.shields.io/badge/build-stable-green)

> 📦 Npcap é a biblioteca oficial de captura e envio de pacotes para **Windows**, desenvolvida pelo projeto **Nmap**. Permite que aplicações capturem e injetem tráfego de rede bruto — incluindo tráfego local (loopback), redes sem fio, Ethernet e muitas VPNs — usando uma API simples e portável.

Se você usa ferramentas como **Wireshark**, **Nmap**, ou qualquer software de análise de rede no Windows, o Npcap é o motor por trás da captura de pacotes. Ele traz para o Windows os mesmos recursos poderosos que o `libpcap` oferece em Linux e macOS.

🔗 **Site Oficial:** [https://npcap.com](https://npcap.com)  
🛠️ **Compatível com:** Nmap, Wireshark, Microsoft Defender for Identity e mais!

---

## 🚀 Recursos Principais

✅ **Captura de Loopback (Localhost)**  
> Npcap permite capturar tráfego entre aplicações na mesma máquina (ex: `127.0.0.1`) usando o **Windows Filtering Platform (WFP)**.  
> Após instalar, aparece uma interface chamada `NPF_Loopback` no Wireshark — use-a para ver todo tráfego local!

📡 **Suporte a Modo Monitor (Wireless 802.11)**  
> Capture tráfego Wi-Fi bruto com cabeçalhos **radiotap**, ideal para análise de segurança e pentest.

🛡️ **Segurança Aprimorada**  
> - Opção para restringir captura apenas a **Administradores**  
> - Suporte a **UAC**, **ASLR**, **DEP**  
> - Drivers e binários assinados digitalmente (EV + Microsoft)

💾 **Compatibilidade com WinPcap**  
> A maioria dos softwares feitos para WinPcap funciona com Npcap (com recompilação ou até mesmo binariamente).  
> ⚠️ *WinPcap está descontinuado — Npcap é o sucessor moderno!*

🔄 **Suporte a Todas as Arquiteturas do Windows**  
> - ✅ x86 (32-bit)  
> - ✅ x64 (64-bit)  
> - ✅ ARM64 (Surface Pro X, Galaxy Book Go, etc.)

📦 **Suporte a Todas as Versões Modernas do Windows**  
> Windows 7, 8, 8.1, 10, 11, Server 2008R2 até 2022.  
> Usa **NDIS 6 LWF** (mais rápido e seguro que o antigo NDIS 5 do WinPcap).

🧩 **API Libpcap Atualizada**  
> Baseado na versão mais recente do `libpcap`, com melhorias contínuas e compatibilidade multiplataforma.

---

## 📥 Download e Instalação

### 🔽 Versão Gratuita (Free Edition)

> Ideal para uso pessoal, educação e ferramentas como Wireshark e Nmap.

📥 **Instalador Npcap 1.83**  
[Download Npcap 1.83](https://npcap.com/dist/npcap-1.83.exe)  
✔️ Suporta: Windows 7 até 11 / Server 2008R2 até 2022  
✔️ Arquiteturas: x86, x64, ARM64

📦 **Npcap SDK 1.15 (para desenvolvedores)**  
[Download Npcap SDK](https://npcap.com/dist/Npcap-SDK-1.15.zip)  
Use para compilar seus próprios aplicativos com suporte a captura de pacotes no Windows.

📁 **Código-Fonte e Símbolos de Depuração**  
- [Source Code (1.83)](https://npcap.com/dist/Npcap-src-1.83.zip)  
- [Debug Symbols](https://npcap.com/dist/Npcap-symbols-1.83.zip)

> 💡 O código-fonte também está disponível no GitHub:  
> 👉 [https://github.com/nmap/npcap](https://github.com/nmap/npcap)

---

## 💼 Licenças Comerciais (Npcap OEM)

> O projeto Npcap é mantido com o apoio de licenças comerciais. A versão gratuita **não permite redistribuição** e tem limite de 5 máquinas (exceto quando usada com Nmap, Wireshark ou Microsoft Defender for Identity).

### 🏢 1. Licença de Redistribuição (OEM Redistribution)
> Para empresas que querem **incluir o Npcap em seus produtos**.  
> Inclui:
> - Instalador silencioso (sem intervenção do usuário)
> - Direitos de redistribuição
> - Suporte técnico e atualizações
> - Licença perpétua ou anual

📄 [Detalhes da licença de redistribuição](https://npcap.com/redist-license.html)

### 🏢 2. Licença de Uso Interno (Internal-Use)
> Para organizações que querem usar Npcap em **múltiplas máquinas internamente**, sem redistribuir.  
> Ideal para TI corporativa, SOC, pentest interno.

📄 [Detalhes da licença interna](https://npcap.com/internal-license.html)

---

## 📚 Documentação

📘 [Npcap User's Guide](https://npcap.com/guide/) – Guia completo de instalação, configuração e uso  
📘 [Npcap Changelog](https://npcap.com/changelog.html) – Histórico de mudanças por versão  
📘 [README no GitHub](https://github.com/nmap/npcap/blob/master/README.md) – Informações técnicas para desenvolvedores

📊 Comparação com WinPcap: [Npcap vs WinPcap](https://npcap.com/comparison.html)


*Este README foi feito com 💙 para desenvolvedores, pentesters e analistas de segurança.*
