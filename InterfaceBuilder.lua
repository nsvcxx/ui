-- GitHub: ui/InterfaceBuilder.lua
-- Módulo responsável exclusivamente pelo design e construção da Interface Gráfica (GUI)

local InterfaceBuilder = {}

function InterfaceBuilder.CriarMenu(LocalPlayer, COR_LIGADO, COR_DESLIGADO)
	-- Cria o contêiner principal da interface que não some ao morrer
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "MenuHvH_Automatico"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

	-- Cria a janela central do painel
	local Painel = Instance.new("Frame")
	Painel.Name = "Painel"
	Painel.Size = UDim2.new(0, 260, 0, 700)
	Painel.Position = UDim2.new(0.5, -130, 0.5, -350)
	Painel.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	Painel.BorderSizePixel = 2
	Painel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Painel.Visible = false -- Começa escondido, abre com a tecla '-'
	Painel.Parent = ScreenGui

	-- Funções auxiliares para padronizar o design dos componentes
	local function criarBotaoConfiguracao(nome, textoInicial, posicaoY)
		local botao = Instance.new("TextButton")
		botao.Name = nome
		botao.Size = UDim2.new(0, 220, 0, 32)
		botao.Position = UDim2.new(0, 20, 0, posicaoY)
		botao.Text = textoInicial
		botao.Font = Enum.Font.SourceSansBold
		botao.TextSize = 14
		botao.TextColor3 = Color3.fromRGB(255, 255, 255)
		botao.BackgroundColor3 = COR_DESLIGADO
		botao.BorderSizePixel = 0
		botao.Parent = Painel
		return botao
	end

	local function criarTextoIndicador(texto, posicaoY)
		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(0, 220, 0, 18)
		label.Position = UDim2.new(0, 20, 0, posicaoY)
		label.Text = texto
		label.Font = Enum.Font.SourceSansBold
		label.TextSize = 12
		label.TextColor3 = Color3.fromRGB(200, 200, 200)
		label.BackgroundTransparency = 1
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.Parent = Painel
		return label
	end

	local function criarCaixaDigitacao(nome, textoPadrao, posicaoY)
		local caixa = Instance.new("TextBox")
		caixa.Name = nome
		caixa.Size = UDim2.new(0, 220, 0, 28)
		caixa.Position = UDim2.new(0, 20, 0, posicaoY)
		caixa.Text = textoPadrao
		caixa.Font = Enum.Font.SourceSans
		caixa.TextSize = 13
		caixa.TextColor3 = Color3.fromRGB(0, 0, 0)
		caixa.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
		caixa.BorderSizePixel = 0
		caixa.Parent = Painel
		return caixa
	end

	-- Instanciação dos botões de ligar/desligar
	local BotaoAimbot = criarBotaoConfiguracao("BotaoAimbot", "Aimbot: DESLIGADO (M5 / Teclado L)", 15)
	local BotaoTrigger = criarBotaoConfiguracao("BotaoTrigger", "Triggerbot: DESLIGADO (M4 / Teclado K)", 55)
	local BotaoTeamCheck = criarBotaoConfiguracao("BotaoTeamCheck", "Focar Aliados: DESLIGADO", 95)
	local BotaoESP = criarBotaoConfiguracao("BotaoESP", "ESP: DESLIGADO (Teclado O)", 135)
	local BotaoSpinbot = criarBotaoConfiguracao("BotaoSpinbot", "Spinbot: DESLIGADO (Teclado P)", 175)

	-- Instanciação dos campos de texto reguláveis
	criarTextoIndicador("Focar Membro (CABECA, TORSO, PERNAS):", 215)
	local InputAlvo = criarCaixaDigitacao("InputAlvo", "CABECA", 235)

	criarTextoIndicador("Raio do Aimbot (FOV: 1 a 800):", 270)
	local InputFOV = criarCaixaDigitacao("InputFOV", "400", 290)

	criarTextoIndicador("Força/Suavidade da Mira (0.01 a 1.0):", 325)
	local InputForca = criarCaixaDigitacao("InputForca", "1.0", 345)

	criarTextoIndicador("Tempo Reação Aimbot (0.0s a 0.5s):", 380)
	local InputReacao = criarCaixaDigitacao("InputReacao", "0.0", 400)

	criarTextoIndicador("Tempo Reação Trigger (0.0s a 0.5s):", 435)
	local InputReacaoTrigger = criarCaixaDigitacao("InputReacaoTrigger", "0.0", 455)

	criarTextoIndicador("Multiplicador HBE Cabeça (0.0 a 100.0x):", 490)
	local InputHBE = criarCaixaDigitacao("InputHBE", "3.0", 510)

	-- Texto informativo fixo no rodapé
	local TextoInformativoRodape = Instance.new("TextLabel")
	TextoInformativoRodape.Size = UDim2.new(0, 260, 0, 30)
	TextoInformativoRodape.Position = UDim2.new(0, 0, 0, 665)
	TextoInformativoRodape.Text = "Menu: Tecla '-' | Attack Shark X11 Nativo"
	TextoInformativoRodape.Font = Enum.Font.SourceSansItalic
	TextoInformativoRodape.TextSize = 11
	TextoInformativoRodape.TextColor3 = Color3.fromRGB(150, 150, 150)
	TextoInformativoRodape.BackgroundTransparency = 1
	TextoInformativoRodape.Parent = Painel

	return Painel, BotaoAimbot, BotaoTrigger, BotaoTeamCheck, BotaoESP, BotaoSpinbot, InputAlvo, InputFOV, InputForca, InputReacao, InputReacaoTrigger, InputHBE
end

return InterfaceBuilder
