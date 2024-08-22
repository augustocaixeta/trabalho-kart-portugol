programa {
    /**
     * NOTAS
     * 
     * ~
     * 
     */

    inclua biblioteca Util --> u

    /**
     * Cabeçalho
     */

    inteiro
        MAX_KARTS = 3, // Números máximo de karts
        MAX_CIRCUITOS = 3 // Número máximo de circuitos (pistas)

    // Kart
    cadeia
        kartsModelo[MAX_KARTS]

    inteiro
        kartContador = 0,
        kartsCadastrado[MAX_KARTS],
        kartsLocado[MAX_KARTS],
        kartsVezesLocado[MAX_KARTS]

    real
        kartsValorLocacao[MAX_KARTS],
        kartsLucro[MAX_KARTS]
    
    // Circuito
    inteiro
        circuitosLocado[MAX_CIRCUITOS]
    
    real
        circuitosValorLocacao[MAX_CIRCUITOS],
        circuitosLucro[MAX_CIRCUITOS]

    // Receita e Lucro
    real
        lucroDoDia = 0.0,
        receitaDoDia = 0.0

    /**
     * Funções do Kart
     */

    funcao inteiro armazenarNovoKart(cadeia modelo, real valor) {
        // Função responsável por iniciar as variáveis do kart com os novos valores de cadastro.
        // A variável `kartContador` será uma variável global (visível para todas funções).
        // E sempre será incrementada `kartContador++` quando a função `armazenarNovoKart` for chamada (será a variável que definirá o total de karts cadastrados).

        inteiro kartId = kartContador

        kartsModelo[kartId]       = modelo
        kartsValorLocacao[kartId] = valor
        kartsLucro[kartId]        = 0.0
        kartsLocado[kartId]       = 0
        kartsVezesLocado[kartId]  = 0
        kartsCadastrado[kartId]   = 1

        retorne kartContador++
    }

    funcao inteiro locarKart(inteiro kartId) {
        se (nao (kartId >= 0 e kartId < MAX_KARTS)) {
            // ERRO: A função `locarKart` retornará `1` se caso o valor passado no parâmetro `kartId` NÃO for >= 0 e < MAX_KARTS (entre 0 e MAX_KARTS - 1).
            retorne 1
        }

        se (kartsCadastrado[kartId] == 0) {
            // ERRO: A função `locarKart` retornará `1` se caso o kart NÃO estiver cadastrado.
            retorne 1
        }

        se (kartsLocado[kartId] == 1) {
            // ERRO: A função `locarKart` retornará `2` se caso o kart ESTIVER locado.
            retorne 2
        }

        kartsLocado[kartId] = 1
        kartsLucro[kartId] += kartsValorLocacao[kartId]
        kartsVezesLocado[kartId]++

        // Receita do dia (a `receitaDoDia` aqui não atualiza na variável por algum motivo)
        receitaDoDia += kartsValorLocacao[kartId]

        retorne 0
    }

    funcao inteiro devolverKart(inteiro kartId) {
        se (nao (kartId >= 0 e kartId < MAX_KARTS)) {
            // ERRO: A função `devolverKart` retornará `1` se caso o valor passado no parâmetro `kartId` NÃO for >= 0 e < MAX_KARTS (entre 0 e MAX_KARTS - 1).
            retorne 1
        }

        se (kartsCadastrado[kartId] == 0) {
            // ERRO: A função `devolverKart` retornará `1` se caso o kart NÃO estiver cadastrado.
            retorne 1
        }

        se (kartsLocado[kartId] == 0) {
            // ERRO: A função `devolverKart` retornará `2` se caso o kart NÃO estiver locado.
            retorne 2
        }

        kartsLocado[kartId] = 0

        // Receita do dia
        receitaDoDia -= kartsValorLocacao[kartId]

        retorne 0
    }

    funcao inteiro obterKartMaisLucrativo() {
        real maiorValor = 0.0

        // A variável `kartId` será iniciada em `-1` para dizer que nenhum kart gerou lucro ainda.
        // Caso a condição `kartsLucro[contador] > maiorValor` achar um kart com ganhos, então a variável `kartId` abaixo
        // será atualizada para o ID `contador` do kart encontrado e a função não retornará mais o valor `-1`.
        inteiro kartId = -1

        para (inteiro contador = 0; contador < MAX_KARTS; contador++) {
            se (kartsLucro[contador] > maiorValor) {
                maiorValor = kartsLucro[contador]
                kartId = contador
            }
        }

        retorne kartId
    }

    /**
     * Funções do Circuito
     */

    funcao vazio iniciarDadosDoCircuito(inteiro valorLocacao[]) {
        para (inteiro i = 0; i < MAX_CIRCUITOS; i++) {
            circuitosLocado[i] = 0
            circuitosLucro[i] = 0
            circuitosValorLocacao[i] = valorLocacao[i]
        }
    }

    funcao inteiro locarCircuito(inteiro circuitoId) {
        se (nao (circuitoId >= 0 e circuitoId < MAX_CIRCUITOS)) {
            // ERRO: A função `locarCircuito` retornará `1` se caso o valor passado no parâmetro `circuitoId` NÃO for >= 0 e < MAX_CIRCUITOS (entre 0 e MAX_CIRCUITOS - 1).
            retorne 1
        }

        se (circuitosLocado[circuitoId] == 1) {
            // ERRO: A função `locarCircuito` retornará `2` se caso o circuito ESTIVER locado.
            retorne 2
        }

        real valorLocacaoComAcrescimo = circuitosValorLocacao[circuitoId] * 1.70

        circuitosLocado[circuitoId] = 1
        circuitosLucro += valorLocacaoComAcrescimo

        // Receita do dia
        receitaDoDia += valorLocacaoComAcrescimo

        retorne 0
    }

    /**
     * Funções do dia
     */

    funcao real obterLucroDoDia() {
        lucroDoDia = receitaDoDia * 0.30

        retorne lucroDoDia
    }

    funcao vazio atualizarDia(inteiro kartsLocados[], inteiro locadoContador) {
        // kartsLocados & locadoContador -> São parâmetros de referência
        // Pode perceber que os parâmetros passados por referência sempre estarão RECEBENDO um valor (Variável Receptora) (ex.: variavelReceptora = valor)

        inteiro contador

        para (contador = 0; contador < MAX_KARTS; contador++) {
            se (kartsLocado[contador] == 1) {
                kartsLocado[contador] = 0

                // Aviso de karts que deverão ser cobrados novos alugueis
                kartsLocados[locadoContador] = contador
                locadoContador++
            }
        }

        para (contador = 0; contador < MAX_CIRCUITOS; contador++) {
            se (circuitosLocado[contador] == 1) {
                circuitosLocado[contador] = 0
            }
        }

        receitaDoDia = 0
    }

    /**
     * Funções de exibição
     */

    funcao vazio mostrarCadastroDeKart() {
        limpa()

        se (kartContador != MAX_KARTS) {
            cadeia modelo
            real valor

            escreva("# CADASTRO DE KART\n\n")

            escreva("Modelo:\nR: ")
            leia(modelo)

            escreva("\nValor do aluguel (R$):\nR: ")
            leia(valor)
            
            // Como a função `armazenarNovoKart` tem um retorno `retorne kartContador++` então esse é valor que será armazenado na variável `kartId` abaixo.
            // A variável `kartId` receberá o número (ID) do novo kart cadastrado (Seria o mesmo de `kartContador`).
            inteiro kartId = armazenarNovoKart(modelo, valor)

            escreva("\nKart Nº ", kartId, " cadastrado!")
        } senao {
            escreva("O limite de cadastrar karts foi atingido.")
        }

        caracter pausar

        escreva("\n\nPressione qualquer caracter para retornar ao menu principal.\nR: ")
        leia(pausar)
    }

    funcao vazio mostrarKartsDisponiveis() {
        limpa()

        inteiro disponivelContador = 0

        escreva("# KARTS DISPONÍVEIS:\n\n")

        para (inteiro i = 0; i < kartContador; i++) {
            se (kartsCadastrado[i] == 1 e kartsLocado[i] == 0) {
                escreva("Nº ", i, " | MODELO: ", kartsModelo[i], " | ALUGUEL: R$ ", kartsValorLocacao[i], "\n")
                disponivelContador++
            }
        }

        se (disponivelContador == 0) {
            escreva("Não há nenhum kart disponível.\n")
        }

        caracter pausar

        escreva("\nPressione qualquer caracter para retornar ao menu principal.\nR: ")
        leia(pausar)
    }

    funcao vazio mostrarKartsLocados() {
        limpa()

        inteiro locadoContador = 0

        escreva("# KARTS LOCADOS:\n\n")

        para (inteiro i = 0; i < MAX_KARTS; i++) {
            se (kartsCadastrado[i] == 1 e kartsLocado[i] == 1) {
                escreva("Nº ", i, " | MODELO: ", kartsModelo[i], " | ALUGUEL: R$ ", kartsValorLocacao[i], "\n")
                locadoContador++
            }
        }

        se (locadoContador == 0) {
            escreva("Não há nenhum kart locado.\n")
        }

        caracter pausar

        escreva("\nPressione qualquer caracter para retornar ao menu principal.\nR: ")
        leia(pausar)
    }

    funcao vazio mostrarLocarKart() {
        limpa()

        inteiro kartIdEscolhido, respostaLocarKart = 0, i = 0

        faca {
            limpa()

            escreva("# LOCAR UM KART:\n\n")

            para (i = 0; i < kartContador; i++) {
                se (kartsCadastrado[i] == 1) {
                    se (kartsLocado[i] == 0) {
                        escreva("[", i+1, "] - MODELO: ", kartsModelo[i], " (R$ ", kartsValorLocacao[i], ")\n")
                    } senao {
                        escreva("[", i+1, "] - MODELO: ", kartsModelo[i], " (R$ ", kartsValorLocacao[i], ") (LOCADO)\n")
                    }
                }
            }

            escreva("[0] - Retornar\n\nR: ")
            leia(kartIdEscolhido)

            se (kartIdEscolhido >= 0 e kartIdEscolhido <= MAX_KARTS) {
                se (kartIdEscolhido == 0) {
                    limpa()

                    escreva("# LOCAR UM KART:\n\n")
                    escreva("Você decidiu retornar ao menu principal.")

                    // Caso a resposta for `0` (Retornar), a variável `respostaLocarKart` precisa ser `0` para sair do `faca-enquanto`.
                    respostaLocarKart = 0
                } senao {
                    // Como os índices dos vetores começam do `0` e vai até `max - 1`, então precisamos subtrair `1` de `kartIdEscolhido`.
                    // Porque na escolha de locação de um kart, os IDs começam do `1` e não no `0`, o número (0) serve para retornar.
                    kartIdEscolhido--

                    // Locando um kart pelo ID escolhido
                    respostaLocarKart = locarKart(kartIdEscolhido)

                    // Caso o retorno de `locarKart` for `0` é porque o kart foi locado com sucesso.
                    se (respostaLocarKart == 0) {
                        limpa()

                        escreva("KART LOCADO COM SUCESSO!\n")
                        escreva("\nModelo: ", kartsModelo[kartIdEscolhido])
                        escreva("\nValor de Locação: R$ ", kartsValorLocacao[kartIdEscolhido])
                    }
                }
            }
        } enquanto (respostaLocarKart != 0)

        caracter pausar

        escreva("\n\nPressione qualquer caracter para retornar ao menu principal.\nR: ")
        leia(pausar)
    }

    funcao vazio mostrarDevolverKart() {
        limpa()

        inteiro kartIdEscolhido, respostaDevolverKart = 0, i = 0

        faca {
          limpa()

            escreva("# DEVOLUÇÃO DE KART:\n\n")

            para (i = 0; i < kartContador; i++) {
                se (kartsCadastrado[i] == 1) {
                    se (kartsLocado[i] == 0) {
                        escreva("[", i+1, "] - MODELO: ", kartsModelo[i], " (R$ ", kartsValorLocacao[i], ")\n")
                    } senao {
                        escreva("[", i+1, "] - MODELO: ", kartsModelo[i], " (R$ ", kartsValorLocacao[i], ") (LOCADO)\n")
                    }
                }
            }

            escreva("[0] - Retornar\n\nR: ")
            leia(kartIdEscolhido)

            se (kartIdEscolhido >= 0 e kartIdEscolhido <= MAX_KARTS) {
                se (kartIdEscolhido == 0) {
                    limpa()

                    escreva("# DEVOLUÇÃO DE KART:\n\n")
                    escreva("Você decidiu retornar ao menu principal.")

                    // Caso a resposta for `0` (Retornar), a variável `respostaDevolverKart` precisa ser `0` para sair do `faca-enquanto`.
                    respostaDevolverKart = 0
                } senao {
                    // Como os índices dos vetores começam do `0` e vai até `max - 1`, então precisamos subtrair `1` de `kartIdEscolhido`.
                    // Porque na escolha de devolução de um kart, os IDs começam do `1` e não no `0`, o número (0) serve para retornar.
                    kartIdEscolhido--

                    // Locando um kart pelo ID escolhido
                    respostaDevolverKart = devolverKart(kartIdEscolhido)

                    // Caso o retorno de `devolverKart` for `0` é porque o kart foi locado com sucesso.
                    se (respostaDevolverKart == 0) {
                        limpa()

                        escreva("KART DEVOLVIDO COM SUCESSO!\n")
                        escreva("\nModelo: ", kartsModelo[kartIdEscolhido])
                        escreva("\nValor de Locação: R$ ", kartsValorLocacao[kartIdEscolhido])
                    }
                }
            }
        } enquanto (respostaDevolverKart != 0)

        caracter pausar

        escreva("\n\nPressione qualquer caracter para retornar ao menu principal.\nR: ")
        leia(pausar)
    }

    funcao vazio mostrarKartMaisLucrativo() {
        inteiro kartId = obterKartMaisLucrativo()

        limpa()

        escreva("# KART COM MAIOR GANHO:\n")

        // Se caso `kartId` que é o retorno da função `obterKartMaisLucrativo()` for `!= -1`, então pode
        // se concluir que há pelo menos (1) kart com maior ganho como nos comentários da função `obterKartMaisLucrativo()`.
        se (kartId != -1) {
            escreva("\nModelo: ", kartsModelo[kartId])
            escreva("\nValor de aluguel: R$ ", kartsValorLocacao[kartId])
            escreva("\nVezes locado: ", kartsVezesLocado[kartId])
            escreva("\nLucro: ", kartsLucro[kartId])
        } senao {
            escreva("\nNão foi encontado nenhum kart com maior ganho.\n")
        }

        caracter pausar

        escreva("\nPressione qualquer caracter para retornar ao menu principal.\nR: ")
        leia(pausar)
    }

    funcao vazio mostrarReceitaELucroDoDia() {
        limpa()

        real lucro = obterLucroDoDia()

        escreva("# LUCRO E RECEITA DO DIA:\n")

        escreva("\nLucro: R$ ", lucro)
        escreva("\nReceita: R$ ", receitaDoDia)

        caracter pausar

        escreva("\n\nPressione qualquer caracter para retornar ao menu principal.\nR: ")
        leia(pausar)
    }

    funcao vazio mostrarLocarCircuito() {
        inteiro circuitoIdEscolhido, respostaLocarCircuito = 0, i = 0

        faca {
            limpa()

            escreva("# ALUGAR CIRCUITO:\n\n")

            para (i = 0; i < MAX_CIRCUITOS; i++) {
                se (circuitosLocado[i] == 0) {
                    escreva("[", i+1, "] - Circuito ", i+1, "\n")
                } senao {
                    escreva("[", i+1, "] - Circuito ", i+1, " (LOCADO)\n")
                }
            }

            escreva("[0] - Retornar\n\nR: ")
            leia(circuitoIdEscolhido)

            se (circuitoIdEscolhido >= 0 e circuitoIdEscolhido <= MAX_CIRCUITOS) {
                se (circuitoIdEscolhido == 0) {
                    limpa()

                    escreva("# ALUGAR CIRCUITO:\n\n")
                    escreva("Você decidiu retornar ao menu principal.")

                    respostaLocarCircuito = 0
                } senao {
                    // Como os índices dos vetores começam do `0` e vai até `max - 1`, então precisamos subtrair `1` de `circuitoIdEscolhido`.
                    // Porque na escolha de locação de um circuito, os IDs começam do `1` e não no `0`, o número (0) serve para retornar.
                    circuitoIdEscolhido--

                    // Salvar a resposta da função `locarCircuito` na variável `respostaLocarCircuito`.
                    respostaLocarCircuito = locarCircuito(circuitoIdEscolhido)

                    // Como comentado os possíveis erros na função `locarCircuito`, apenas o `retorne 0` passa pelos retornos de erros (Sucesso).
                    se (respostaLocarCircuito == 0) {
                        limpa()

                        escreva("# CIRCUITO ALUGADO!\n")
                        escreva("\nCircuito ID: ", circuitoIdEscolhido + 1)
                        escreva("\nValor de Locação: R$ ", circuitosValorLocacao[circuitoIdEscolhido])

                        circuitosLocado[circuitoIdEscolhido] = 1
                    }
                }
            }
        } enquanto (respostaLocarCircuito != 0)
        
        caracter pausar

        escreva("\n\nPressione qualquer caracter para retornar ao menu principal.\nR: ")
        leia(pausar)
    }

    funcao vazio mostrarAtualizarDia() {
        real lucro = obterLucroDoDia()

        limpa()

        escreva("# DIA ATUALIZADO!\n\n")
        escreva("Lucros (R$ ", lucro, ")\n\n")

        inteiro kartsLocados[MAX_KARTS], locadoContador = 0

        // Como dito nos comentários da função `atualizarDia(inteiro &kartsLocados[], inteiro &locadoContador)`
        // Os valores vem de lá para cá, e precisam de novas variáveis aqui, como `kartsLocados` e `locadoContador` criadas acima (Usei os mesmos nomes).
        atualizarDia(kartsLocados, locadoContador)

        escreva("# KARTS DESALOCADOS:\n\n")

        para (inteiro i = 0; i < locadoContador; i++) {
            escreva("Nº ", kartsLocados[i], "\n")
        }

        se (locadoContador == 0) {
            escreva("Nenhum kart foi desalocado.\n\n")
        }

        caracter pausar

        escreva("Pressione qualquer caracter para retornar ao menu principal.\nR: ")
        leia(pausar)
    }

    /**
     * Inicio
     */

    funcao inicio() {
        inteiro opcao

        // Iniciar valores e variáveis no `0` para os circuitos:
        inteiro valorLocacao[] = {500, 500, 500}
        iniciarDadosDoCircuito(valorLocacao)

        faca {
            limpa()

            escreva("1. Cadastrar um Kart\n")
            escreva("2. Listar Karts disponíveis\n")
            escreva("3. Listar Karts locados\n")
            escreva("4. Alugar um Kart\n")
            escreva("5. Devolver um Kart\n")
            escreva("6. Kart que mais gerou ganhos\n")
            escreva("7. Receita e lucro do dia, considerando karts locados\n")
            escreva("8. Locação de circuito\n")
            escreva("9. Atualizar dia\n")
            escreva("0. Sair do programa\n\n")

            escreva("R: ")
            leia(opcao)

            escolha (opcao) {
                caso 1: {
                    mostrarCadastroDeKart()
                    pare
                }

                caso 2: {
                    mostrarKartsDisponiveis()
                    pare
                }

                caso 3: {
                    mostrarKartsLocados()
                    pare
                }

                caso 4: {
                    mostrarLocarKart()
                    pare
                }

                caso 5: {
                    mostrarDevolverKart()
                    pare
                }

                caso 6: {
                    mostrarKartMaisLucrativo()
                    pare
                }

                caso 7: {
                    mostrarReceitaELucroDoDia()
                    pare
                }

                caso 8: {
                    mostrarLocarCircuito()
                    pare
                }

                caso 9: {
                    mostrarAtualizarDia()
                    pare
                }
            }
        } enquanto (opcao != 0)
    }
}
