***Documentation:**

**1. Data Section (.data):*
This section stores constant strings and product prices:

Prompts and messages:
- greeting_msg: Welcome message displayed at the start.
- input_balance_msg: Prompts user to input initial balance.
- display_menu_msg: Displays menu options to the user.
- water_msg, snacks_msg, sandwich_msg, meal_msg: Messages confirming the selected item.
- insufficient_msg: Message shown when the user’s balance is insufficient.
- remaining_balance_msg: Message to display the remaining balance.
- exit_vending_msg: Farewell message upon exiting the vending machine.

Product prices:
- price_water, price_snacks, price_sandwich, price_meal: Prices of items in the vending machine.

*2. Text Section (.text):*
This section contains the program logic.

Main Routine (main):
- Prints the greeting message using a syscall.
- Prompts the user for the initial balance, reads it into $s0.
- Main Loop (vending_loop):

Displays the menu.
- Reads user input (selection) into $t1.
- Handles the exit condition (-1), valid item selection (1–4), and invalid options.

*3. Item Selection Logic:*
Each item has its corresponding label:
- purchase_water: Loads water price into $t2 and prints water_msg.
- purchase_snacks: Loads snacks price into $t2 and prints snacks_msg.
- purchase_sandwich: Loads sandwich price into $t2 and prints sandwich_msg.
- purchase_meal: Loads meal price into $t2 and prints meal_msg.

**4. Balance Check (check_funds):*
- Compares the user’s balance ($s0) with the price of the selected item ($t2).

If sufficient:
- Deducts the item price from the balance.
- Returns to the menu loop.

If insufficient:
- Displays insufficient_msg and returns to the menu.

*5. Invalid Option Handling (invalid_option):*
- Redirects the user back to the menu for invalid selections (e.g., 0, 5).

**6. Exit Routine (exit_machine):*
- Prints the remaining balance (remaining_balance_msg).
- Displays a farewell message (exit_vending_msg) and exits the program.