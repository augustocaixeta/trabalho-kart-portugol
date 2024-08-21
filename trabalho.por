programa {
    inclua biblioteca Util --> u
    inclua biblioteca Matematica --> m

    /**
     * Cabeçalho
     */

    inteiro
        MAX_KARTS = 3 // Números máximo de karts

    cadeia
        kartModelo[MAX_KARTS]

    inteiro
        kartCadastrado[MAX_KARTS],
        kartAlocado[MAX_KARTS],
        kartVezesAlocado[MAX_KARTS]

    real
        kartValor[MAX_KARTS],
        kartLucro[MAX_KARTS]
    
    inteiro
        diaAtual = 0,
        kartContador = 0

    /**
     * Funções
     */

    funcao inteiro novoKart(cadeia modelo, real valor) {
        // Função responsável por iniciar as variáveis do kart com os novos valores de cadastro.
        // A variável `kartContador` será uma variável global (visível para todas funções).
        // E sempre será incrementada `kartContador++` quando a função `novoKart` for chamada (será a variável que definirá o total de karts cadastrados).

        inteiro
            kartId = kartContador
        
        kartModelo[kartId]       = modelo
        kartValor[kartId]        = valor
        kartLucro[kartId]        = 0.0
        kartAlocado[kartId]      = 0
        kartVezesAlocado[kartId] = 0
        kartCadastrado[kartId]   = 1

        retorne kartContador++
    }

    funcao vazio mostrarCadastroDeKart() {
        limpa()

        se (kartContador != MAX_KARTS) {
            cadeia
                modelo
            real
                valor

            escreva("# CADASTRO DE KART\n\n")

            escreva("Modelo:\nR: ")
            leia(modelo)

            escreva("\nValor do aluguel (R$):\nR: ")
            leia(valor)
            
            // Como a função `novoKart` tem um retorno `retorne kartContador++` então esse é valor que será armazenado na variável `kartId` abaixo.
            // A variável `kartId` receberá o número (ID) do novo kart cadastrado (Seria o mesmo de `kartContador`).
            inteiro
                kartId = novoKart(modelo, valor)

            escreva("\nKart Nº ", kartId, " cadastrado!")
        } senao {
            escreva("O limite de cadastrar karts foi atingido.")
        }

        caracter
            pausar

        escreva("\n\nPressione qualquer caracter para retornar ao menu principal.\nR: ")
        leia(pausar)
    }

    funcao vazio mostrarKartsDisponiveis() {
        limpa()

        inteiro
            disponivelContador = 0

        escreva("# KARTS DISPONÍVEIS:\n\n")

        para (inteiro i = 0; i < kartContador; i++) {
            se (kartCadastrado[i] == 1 e kartAlocado[i] == 0) {
                escreva("Nº ", i, " | MODELO: ", kartModelo[i], " | ALUGUEL: R$ ", m.arredondar(kartValor[i], 2), "\n")
                disponivelContador++
            }
        }

        se (disponivelContador == 0) {
            escreva("Não há nenhum kart disponível.\n")
        }

        caracter
            pausar

        escreva("\nPressione qualquer caracter para retornar ao menu principal.\nR: ")
        leia(pausar)
    }

    funcao alugarKart(){

      inteiro numeroKart
      cadeia nome[3]

      para(inteiro i = 0; i<3; i++){
      escreva("Digite o seu nome: ")
      leia(nome[i])
      }

      limpa()

      escreva("Estes são os Karts disponíveis: \n")
      mostrarKartsDisponiveis()

      escreva("Informe o número do Kart que deseja alugar: ")
      leia(numeroKart)
      
  }

    funcao locacaoCircuito(){

      inteiro opcaoCircuito, circuito[3]
      
      faca{
      escreva("# Alugar Circuitos \n")

      escreva("Circuitos disponíveis: \n")
      escreva("1- Circuito 1 \n")
      escreva("2- Circuito 2 \n")
      escreva("3 -Circuito 3 \n")

      leia(opcaoCircuito)

     circuitoAlocado[opcaoCircuito] = 1

     para(inteiro i = 1; i <= 3; i++){
      se( circuitoAlocado[opcaoCircuito] == 1){
        escreva("Circuito Já foi alugado! Tente outro \n")
      }
     }

    }enquanto((nao (opcaoCircuito >= 0 e opcaoCircuito< 3)))
    }
}


    funcao vazio atualizarDiaAtual() {
        // O faça enquanto abaixo será para o usuário colocar um dia do mês entre 1 e 30.
        // O código sempre repetirá se caso o dia inserido NÃO for >= 1 e <= 30.
        faca {
            limpa()

            escreva("# ATUALIZAR DIA:\n\n")

            escreva("Coloque o dia abaixo para atualizar\nR: ")
            leia(diaAtual)
        } enquanto (nao (diaAtual >= 1 e diaAtual <= 30))

        caracter
            pausar

        escreva("\nPressione qualquer caracter para retornar ao menu principal.\nR: ")
        leia(pausar)
    }

    /**
     * Inicio
     */

    funcao inicio() {
        inteiro
            opcao

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

                caso 9: {
                    atualizarDiaAtual()
                }
            }
        } enquanto (opcao != 0)
    }
}
