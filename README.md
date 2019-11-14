# Undo-Redo Calculator
A simple calculator with the common four operators (+ ,- ,* ,/) but also with the ability to undo and redo the operations with a simple UI.



<img width="365" alt="Screenshot at Nov 15 00-16-16" src="https://user-images.githubusercontent.com/36597057/68900778-3877db80-073d-11ea-9b54-17be6f9f9fb1.png">


## Application Requirements
Application should contain
- 7 buttons for (multiplication, division, addition, subtraction, equal, undo and redo).
  - undo and redo buttons to be enabled only when they could execute their functions.
  - Equal button to be active only when operation button ‘*, +, /, -‘ is selected and text field is not
empty.
  - Selecting any operation button ‘*, +, /, -’ should deselect all of the other operations buttons.
- Text field that accepts numbers only which is the second operand in all operation performed as the
first operand would be the last result value that is initially equals zero.
- Label to show the result of the operations.
- Flow layout collection view with a cell contains only a bordered Label to show the history of the
operations performed, cell should fit the label with a little padding.
And do the following:
- User should select the needed operation ‘ex: +’ then enters the second operand in the text field ‘ex:
5’ then tap on equal to perform that operation on the first operand that has initial value of zero.
- Once the operation is done
  - Result label should have the operation result ‘ex: 5’.
  - Text field to be empty.
  - Operation button to be deselected.
  - Collection view to add an item of the operation done ‘ex: + 5’ in the first index.
- Collection view cell selection should undo this operation, considering point 1&2 check the below
  sequence example
  - result = 25.
  - user select ‘+ 5’ item from collection view.
  - result should equal 20.
- Undo and Redo buttons to perform undo redo actions on the previously performed operations,
considering point 1&2 check the below sequence example
  - result = 25 and last two operations in sequence were ‘+ 2’ then ‘*5’.
  - undo twice should make result equals 3.
  - Redo should make result equals 5.
  - add 3 ‘+3’ result equals 8.
  - undo 4 times would make result equals 25 again
  
 
