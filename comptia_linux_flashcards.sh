#!/bin/bash

# Comptia Linux+ Flashcards
# Author: Aboulkacem KRADRA
# Github: kacemsys
# Description: A Linux-themed flashcards quiz for interactive learning.

# Directories and Configuration
questions_dir="questions"
answers_dir="answers"
question_max=300

# Initialize scores
correct_answers=0
total_questions=0

# Print Success Message in Green
print_success() {
  echo -e "\e[32m$1\e[0m"  # 32 corresponds to green, 0 resets the color
}

# Print Error Message in Red
echorange() {
  echo -e "\e[38;5;208m$1\e[0m"  # 38;5;208 corresponds to orange, 0 resets the color
}


print_error() {
  echo -e "\e[31m$1\e[0m"  # 31 corresponds to red, 0 resets the color
}

# Print Score
print_score() {
percentage=$(echo "scale=2; $correct_answers / $total_questions * 100 " | bc)
echorange  "╔════════════════════════════════════════════════════════════════════════════════════╗"
echorange  "║        Your Score: $percentage % ,  $correct_answers correct answer(s) out of $total_questions total question(s).     ║"
echorange  "╚════════════════════════════════════════════════════════════════════════════════════╝"
}

# Script Execution Starts Here

echo ""
echo "╔═══════════════════════════════════════════════════════════════════════╗"
echo "║                     Comptia Linux+ Flashcards	                        ║"
echo "╚═══════════════════════════════════════════════════════════════════════╝"
echo "Welcome to the Linux Flashcards quiz, designed for interactive learning."
echo "Feel free to test your knowledge and press Ctrl+C to quit at any time."
echo "If the answser is more than one option write both options, eg. A and B , type  ab or AB" 
echo " Aboulkacem KRADRA @kacemsys"
echo "═════════════════════════════════════════════════════════════════════════"
echo ""

# Main Loop for Flashcards Quiz
while true; do
        # Get a random question file
        random_question_number=$((1 + RANDOM % $question_max))
        random_question_file="${questions_dir}/question_${random_question_number}.txt"

        # Corresponding answer file
        answer_file="${answers_dir}/answer_${random_question_number}.txt"

        echo "Question:"
        cat "$random_question_file"

        # Prompt for user input
        read -p "Your Answer: " user_answer

        # Check the user's answer against the correct answer
        correct_answer=$(<"$answer_file")

        correct_option=$(echo "$correct_answer" | grep -oP 'Answer: \K[A-Z]+')

        # Enable case-insensitive matching
        shopt -s nocasematch

	#Clear the screen
	clear

	echo ""
	echo ""

        # Evaluate user's response and update the scores
        if [[ "$user_answer" == "$correct_option" ]]; then
          print_success "Correct! Well done!"
          ((correct_answers++))  # Increment correct answers
        else
          print_error "Incorrect. The correct answer to the previous question  was : $correct_option"
        fi

        ((total_questions++))  # Increment total questions

        # Display the current score
        print_score


done

# Disable case-insensitive matching
shopt -u nocasematch
