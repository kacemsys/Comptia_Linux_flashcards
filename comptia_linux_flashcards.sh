#!/bin/bash

questions_dir="questions"
answers_dir="answers"
question_max=300

print_green() {
  echo -e "\e[32m$1\e[0m"  # 32 corresponds to green, 0 resets the color
}

# Function to print text in red
print_red() {
  echo -e "\e[31m$1\e[0m"  # 31 corresponds to red, 0 resets the color
}
echo ""
echo "-----------------------"
echo "Linux + Flash cards "
echo "PS : Keep playing if bored ,  Press Ctrl+C to quit "
echo "-----------------------"
echo ""


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


	correct_option=$(echo "$correct_answer" | grep -oE 'Answer: [A-Z]+' | grep -oE '[A-Z]$')

	# Enable case-insensitive matching
	shopt -s nocasematch

	if [[ "$user_answer" == "$correct_option" ]]; then
	  print_green "Correct! Well done!"
	else
	  print_red "Incorrect. The correct answer is: $correct_option"
	fi
done

# Disable case-insensitive matching 
shopt -u nocasematch
