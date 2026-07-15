-- GitHub: ui/InterfaceBuilder.lua
-- Módulo responsável exclusivamente pelo design e construção da Interface Gráfica (GUI)
-- VERSÃO FINAL DEFINITIVA: Fade-In (1s), Marca d'água "NEVASCA", Cantos Arredondados e Proteção de Clique.

local InterfaceBuilder = {}

function InterfaceBuilder.CriarMenu(LocalPlayer, COR_LIGADO, COR_DESLIGADO)
	local TweenService = game:GetService("TweenService")
	
	-- Cria o contêiner principal da interface que não some ao morrer
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "MenuHvH_Automatico"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

	-- Janela central em CanvasGroup para permitir o efeito de Fade-In coletivo
	local Painel = Instance.new("CanvasGroup")
	Painel.Name = "Painel"
	Painel.Size = UDim2.new(0, 260, 0, 700)
	Painel.Position = UDim2.new(0.5, -130, 0.5, -350)
	Painel.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	Painel.BorderSizePixel = 0 
	Painel.Visible = false -- Controlado externamente pela tecla '-' no Main.lua
	Painel.GroupTransparency = 1 -- Inicia totalmente invisível para a animação
	Painel.Parent = ScreenGui

	-- Fundo Temático: Marca d'água "NEVASCA" em formato de matriz ultra discreta
	local FundoNevasca = Instance.new("TextLabel")
	FundoNevasca.Name = "FundoNevasca"
	FundoNevasca.Size = UDim2.new(1, 0, 1, 0)
	FundoNevasca.Position = UDim2.new(0, 0, 0, 0)
	FundoNevasca.BackgroundTransparency = 1
	FundoNevasca.Font = Enum.Font.SourceSansBold
	FundoNevasca.TextSize = 9
	FundoNevasca.TextColor3 = Color3.fromRGB(255, 255, 255)
	FundoNevasca.TextTransparency = 0.96 -- Apenas um detalhe cirúrgico no plano de fundo
	FundoNevasca.TextXAlignment = Enum.TextXAlignment.Center
	FundoNevasca.TextYAlignment = Enum.TextYAlignment.Top
	FundoNevasca.TextWrapped = true
	FundoNevasca.Active = false -- GARANTIA: Não bloqueia cliques nos botões da frente
	FundoNevasca.ZIndex = 1 -- Mantido atrás de todos os elementos interativos
	
	-- Preenchimento matricial do texto de fundo
	local textoMatriz = ""
	for i = 1, 55 do
		textoMatriz = textoMatriz .. string.rep("NEVASCA  ", 5) .. "\n"
	end
	FundoNevasca.Text = textoMatriz
	FundoNevasca.Parent = Painel

	-- Estética Modern Dark: Cantos arredondados suaves
	local PainelCorner = Instance.new("UICorner")
	PainelCorner.CornerRadius = UDim.new(0, 8)
	PainelCorner.Parent = Painel

	-- Estética Modern Dark: Contorno metálico fino
	local PainelStroke = Instance.new("UIStroke")
	PainelStroke.Color = Color3.fromRGB(45, 45, 50)
	PainelStroke.Thickness = 1.5
	PainelStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	PainelStroke.Parent = Painel

	-- Funções auxiliares de renderização padronizada (ZIndex = 2 para sobrepor a marca d'água)
	local function criarBotaoConfiguracao(nome, textoInicial, posicaoY)
		local botao = Instance.new("TextButton")
		botao.Name = nome
		botao.Size = UDim2.new(0, 220, 0, 32)
		botao.Position = UDim2.new(0, 20, 0, posicaoY)
		botao.Text = textoInicial
		botao.Font = Enum.Font.GothamBold
		botao.TextSize = 13
		botao.TextColor3 = Color3.fromRGB(255, 255, 255)
		botao.BackgroundColor3 = COR_DESLIGADO
		botao.BorderSizePixel = 0
		botao.ZIndex = 2
		botao.Parent = Painel

		local BotaoCorner = Instance.new("UICorner")
		BotaoCorner.CornerRadius = UDim.new(0, 6)
		BotaoCorner.Parent = botao

		return botao
	end

	local function criarTextoIndicador(texto, posicaoY)
		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(0, 220, 0, 18)
		label.Position = UDim2.new(0, 20, 0, posicaoY)
		label.Text = texto
		label.Font = Enum.Font.GothamBold
		label.TextSize = 11
		label.TextColor3 = Color3.fromRGB(160, 160, 170)
		label.BackgroundTransparency = 1
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.ZIndex = 2
		label.Parent = Painel
		return label
	end

	local function criarCaixaDigitacao(nome, textoPadrao, posicaoY)
		local caixa = Instance.new("TextBox")
		caixa.Name = nome
		caixa.Size = UDim2.new(0, 220, 0, 28)
		caixa.Position = UDim2.new(0, 20, 0, posicaoY)
		caixa.Text = textoPadrao
		caixa.Font = Enum.Font.Gotham
		caixa.TextSize = 12
		caixa.TextColor3 = Color3.fromRGB(30, 30, 35)
		caixa.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
		caixa.BorderSizePixel = 0
		caixa.ZIndex = 2
		caixa.Parent = Painel

		local CaixaCorner = Instance.new("UICorner")
		CaixaCorner.CornerRadius = UDim.new(0, 5)
		CaixaCorner.Parent = caixa

		return caixa
	end

	-- Instanciação dos botões operacionais[span_3](start_span)[span_3](end_span)
	local BotaoAimbot = criarBotaoConfiguracao("BotaoAimbot", "Aimbot: DESLIGADO (M5 / Teclado L)", 15)
	local BotaoTrigger = criarBotaoConfiguracao("BotaoTrigger", "Triggerbot: DESLIGADO (M4 / Teclado K)", 55)
	local BotaoTeamCheck = criarBotaoConfiguracao("BotaoTeamCheck", "Focar Aliados: DESLIGADO", 95)
	local BotaoESP = criarBotaoConfiguracao("BotaoESP", "ESP: DESLIGADO (Teclado O)", 135)
	local BotaoSpinbot = criarBotaoConfiguracao("BotaoSpinbot", "Spinbot: DESLIGADO (Teclado P)", 175)

	-- Instanciação dos inputs interativos[span_4](start_span)[span_4](end_span)
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

	-- Rodapé fixo informativo[span_5](start_span)[span_5](end_span)
	local TextoInformativoRodape = Instance.new("TextLabel")
	TextoInformativoRodape.Size = UDim2.new(0, 260, 0, 30)
	TextoInformativoRodape.Position = UDim2.new(0, 0, 0, 665)
	TextoInformativoRodape.Text = "Menu: Tecla '-' | Attack Shark X11 Nativo"
	TextoInformativoRodape.Font = Enum.Font.GothamBold
	TextoInformativoRodape.TextSize = 10
	TextoInformativoRodape.TextColor3 = Color3.fromRGB(110, 110, 120)
	TextoInformativoRodape.BackgroundTransparency = 1
	TextoInformativoRodape.ZIndex = 2
	TextoInformativoRodape.Parent = Painel

	-- Mecânica Dinâmica: Efeito Fade-In Cinemático de exatamente 1.0 segundo[span_6](start_span)[span_6](end_span)
	Painel:GetPropertyChangedSignal("Visible"):Connect(function()
		if Painel.Visible then
			Painel.GroupTransparency = 1 -- Garante opacidade zero no disparo inicial
			local tweenInfo = TweenInfo.new(1.0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			local fadeTween = TweenService:Create(Painel, tweenInfo, {GroupTransparency = 0})
			fadeTween:Play()
		else
			Painel.GroupTransparency = 1 -- Reseta a propriedade para o próximo ciclo de abertura
		end
	end)

	-- Mecânica Dinâmica: Sistema de Arraste Livre com Eixos Corrigidos (Drag & Drop)
	local UserInputService = game:GetService("UserInputService")
	local arrastando, arrastoInput, cliqueStart, posicaoStart

	Painel.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			arrastando = true
			cliqueStart = input.Position
			posicaoStart = Painel.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					arrastando = false
				end
			end)
		end
	end)

	Painel.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			arrastoInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == arrastoInput and arrastando then
			local delta = input.Position - cliqueStart
			Painel.Position = UDim2.new(
				posicaoStart.X.Scale, 
				posicaoStart.X.Offset + delta.X, 
				posicaoStart.Y.Scale, 
				posicaoStart.Y.Offset + delta.Y
			)
		end
	end)

	-- Retorno estrito de instâncias na mesma ordem lida pelo Main.lua[span_7](start_span)[span_7](end_span)
	return Painel, BotaoAimbot, BotaoTrigger, BotaoTeamCheck, BotaoESP, BotaoSpinbot, InputAlvo, InputFOV, InputForca, InputReacao, InputReacaoTrigger, InputHBE
end

return InterfaceBuilder
