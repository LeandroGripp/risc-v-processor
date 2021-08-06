# A primeira instrução ficará armazenada no endereço 0x00400000
# Variáveis globais
  # O endereço definido para a entrada de dados será 0x100100f8
  # O endereço definido para a saída de dados será 0x100100fc 
  # (considera-se que o sistema se ocupa de capturar a saída e o endereço é reaproveitado)
# Na função main, o valor de n é lido do endereço de input e então alocado em a0, 
# que será passado como parâmetro
# Na função primeFactors, n está em s0
# t0 é a constante 2 - isso é necessário porque não há implementação de multiplicação,
# divisão e resto com imediatos em RISC V.
# Em s1 estoca-se os números ímpares que serão usados para teste dos fatores primos
# Em t1, estocamos o valor corrente ao quadrado, para compará-lo com n
# Ao longo de todo o programa, escrevemos no endereço de saída os fatores primos

main:
  #lw a0, 0x100100f8 
  lui a0, 0x00010010
  lw a0, 0x000000f8(a0)

  jal ra, primeFactors
  jal zero, end #jump incondicional

primeFactors:
  add s0, zero, a0
  addi t0, zero, 2
  while:
    rem t1, s0, t0
    bne t1, zero, doneWhile # n%2==0

    # cout << 2 << " ";
    lui t3, 0x00010010
    sw, t0, 0x000000fc(t3) 

    div s0, s0, t0 # n=n/2

    jal zero, while #jump incondicional
  doneWhile:
  addi s1, zero, 3
  for:
    mul t1, s1, s1 # i^2
    blt s0, t1, doneFor # n < i^2

    whileInsideFor:
      rem t1, s0, s1
      bne t1, zero, doneWhileInsideFor # n%i==0

      # cout << i << " ";
      lui t3, 0x00010010
      sw s1, 0x000000fc(t3)

      div s0, s0, s1 # n=n/i
      
      jal zero, whileInsideFor

    doneWhileInsideFor:
    add s1, s1, t0
    jal zero, for
  doneFor:

  if:
    blt s0, t0, endPrimeFactors # n<2
    
    lui t3, 0x00010010
    sw, s0, 0x000000fc(t3)

  endPrimeFactors:
  jalr zero, ra, 0
  
  end:
