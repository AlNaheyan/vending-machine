.data
    # Prompts and messages
    greeting_msg:      .asciiz "Welcome to the Vending Machine!\n"
    input_balance_msg: .asciiz "Please enter the amount of money ($): "
    display_menu_msg:  .asciiz "\nMenu:\n1. Water ($1)\n2. Snacks ($2)\n3. Sandwiches ($3)\n4. Meals ($4)\n-1. Exit\n\nSelect an item: "
    water_msg:         .asciiz "You selected Water.\n"
    snacks_msg:        .asciiz "You selected Snacks.\n"
    sandwich_msg:      .asciiz "You selected Sandwich.\n"
    meal_msg:          .asciiz "You selected Meal.\n"
    insufficient_msg:  .asciiz "Insufficient balance. Please choose another item or add more money.\n"
    remaining_balance_msg: .asciiz "Remaining balance: $"
    exit_vending_msg:  .asciiz "Thank you for your purchase! Exiting vending machine.\n"

    # Product prices (in whole dollars)
    price_water:       .word 1
    price_snacks:      .word 2
    price_sandwich:    .word 3
    price_meal:        .word 4

.text
.globl main

main:
    # Print greeting message
    li $v0, 4
    la $a0, greeting_msg
    syscall

    # Prompt for initial balance
    li $v0, 4
    la $a0, input_balance_msg
    syscall

    # Read balance input
    li $v0, 5           # Read integer
    syscall

    # Store balance in $s0
    move $s0, $v0

vending_loop:
    # Display menu and prompt for selection
    li $v0, 4
    la $a0, display_menu_msg
    syscall

    # Read user selection
    li $v0, 5
    syscall
    move $t1, $v0       # Store selection in $t1

    # Check exit condition
    beq $t1, -1, exit_machine

    # Check valid menu option
    blt $t1, 1, invalid_option
    bgt $t1, 4, invalid_option

    # Determine price based on selection
    beq $t1, 1, purchase_water
    beq $t1, 2, purchase_snacks
    beq $t1, 3, purchase_sandwich
    beq $t1, 4, purchase_meal

purchase_water:
    lw $t2, price_water
    li $v0, 4
    la $a0, water_msg
    syscall
    j check_funds

purchase_snacks:
    lw $t2, price_snacks
    li $v0, 4
    la $a0, snacks_msg
    syscall
    j check_funds

purchase_sandwich:
    lw $t2, price_sandwich
    li $v0, 4
    la $a0, sandwich_msg
    syscall
    j check_funds

purchase_meal:
    lw $t2, price_meal
    li $v0, 4
    la $a0, meal_msg
    syscall
    j check_funds

check_funds:
    # Compare remaining balance with item price
    blt $s0, $t2, insufficient_funds

    # Subtract price from balance
    sub $s0, $s0, $t2
    j vending_loop

insufficient_funds:
    # Print insufficient balance message
    li $v0, 4
    la $a0, insufficient_msg
    syscall
    j vending_loop

invalid_option:
    # Handle invalid menu option
    li $v0, 4
    la $a0, display_menu_msg
    syscall
    j vending_loop

exit_machine:
    # Print remaining balance
    li $v0, 4
    la $a0, remaining_balance_msg
    syscall

    # Display remaining balance
    li $v0, 1
    move $a0, $s0
    syscall

    # Print exit message
    li $v0, 4
    la $a0, exit_vending_msg
    syscall

    # Exit program
    li $v0, 10
    syscall
