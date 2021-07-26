main:
  addi $a0, $zero, 315 # n = 315;

  jal primeFactors
  j end

primeFactors:
  add $s0, $zero, $a0
  addi $t0, $zero, 2
  while:
    rem $t1, $s0, $t0
    bne $t1, $zero, doneWhile # n%2==0

    # cout << 2 << " ";	 

    div $s0, $t0
    mfhi $s0 # n=n/2

    j while
  doneWhile:
  addi $s1, $zero, 3
  for:
    mul $t1, $s1, $s1 # i^2
    slt $t2, $s0, $t1 # n < i^2 
    bne $t2, $zero, doneFor #  i^2 <= n

    whileInsideFor:
      rem $t1, $s0, $s1
      bne $t1, $zero, doneWhileInsideFor # n%i==0

      # cout << i << " ";
	    div $s0, $s0, $s1 # n=n/i
      
      j whileInsideFor

    doneWhileInsideFor:
    addi $s1, $s1, 2
    j for
  doneFor:

  if:
    slt $t2, $t0, $s0
    beq $t2, $zero, endPrimeFactors
    
    li $v0, 1										
	  add $a0, $zero, $s0					
	  syscall	

  endPrimeFactors:
  jr $ra
  
  end:
