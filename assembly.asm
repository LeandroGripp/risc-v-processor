main:
  addi a0, zero, 630 # n = 315;

  jal ra, primeFactors
  jal zero, end #jump incondicional

primeFactors:
  add s0, zero, a0
  addi t0, zero, 2
  while:
    rem t1, s0, t0
    bne t1, zero, doneWhile # n%2==0

    # cout << 2 << " ";
    addi a7, zero, 1
    add a0, zero, t0
    ecall	 

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
      addi a7, zero, 1
	    add a0, zero, s1
	    ecall

	    div s0, s0, s1 # n=n/i
      
      jal zero, whileInsideFor

    doneWhileInsideFor:
    add s1, s1, t0
    jal zero, for
  doneFor:

  if:
    blt s0, t0, endPrimeFactors # n<2
    
    addi a7, zero, 1
	  add a0, zero, s0
	  ecall

  endPrimeFactors:
  jalr zero, ra, 0
  
  end:
