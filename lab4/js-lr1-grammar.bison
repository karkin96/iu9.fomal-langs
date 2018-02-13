primary_expression
  : simple_expression
  | function_expression
  | object_literal
  ;

simple_expression
  : THIS
  | NULL
  | TRUE
  | FALSE
  | NUMBER
  | STRING
  | IDENTIFIER
  | REGULAR_EXPRESSION
  | paranthesized_expression
  | array_literal
  ;

paranthesized_expression
  : '(' expression ')'
  ;

function_expression
  : anonymous_function
  | named_function
  ;

object_literal
  : '{' '}'
  | '{' field_list '}'
  ;

field_list
  : literal_field
  | field_list , literal_field
  ;

literal_field
  : IDENTIFIER ':' assignment_expression
  ;

array_literal
  : '[' ']'
  | '[' element_list ']'
  ;

element_list
  : assignment_expression
  | element_list ',' assignment_expression
  ;

call_expression
  : primary_expression
  | call_expression arguments_or_member_operator
	;

arguments_or_member_operator
	: arguments
	| member_operator
	;


member_operator
  : '[' expression ']'
  | '.' IDENTIFIER
  ;

arguments
  : assignment_expression
  | argument_list , assignment_expression
  ;

postfix_expression
  : call_expression
  | call_expression '+' '+'
  | call_expression '-' '-'
  ;

unary_expression
  : postfix_expression
  | DELETE call_expression
  | VOID unary_expression
  | TYPEOF unary_expression
  | '+' '+' call_expression
  | '-' '-' call_expression
  | '+' unary_expression
  | '-' unary_expression
  | '~' unary_expression
  | '!' unary_expression
  ;

multiplicative_expression
  : unary_expression
  | multiplicative_expression '*' unary_expression
  | multiplicative_expression '/' unary_expression
  | multiplicative_expression '%' unary_expression
  ;

addtive_expression
  : multiplicative_expression
  | additive_expression '+' multiplicative_expression
  | additive_expression '-' multiplicative_expression
  ;

shift_expression
  : shift_expression '<' '<' additive_expression
  | shift_expression '>' '>' additive_expression
  | shift_expression '>' '>' '>' additive_expression
  ;

relatonal_expression
  : shift_expression
  | relatonal_expression '<' shift_expression
  | relatonal_expression '>' shift_expression
  | relatonal_expression '<' '=' shift_expression
  | relatonal_expression '>' '=' shift_expression
  | relatonal_expression INSTANCEOF shift_expression
  | relatonal_expression IN shift_expression
  ;

equality_expression
  : relatonal_expression
  | equality_expression '=' '=' relatonal_expression
  | equality_expression '!' '=' relatonal_expression
  | equality_expression '=' '=' '=' relatonal_expression
  | equality_expression '!' '=' '=' relatonal_expression
  ;

bitwise_and_expression
  : equality_expression
  | bitwise_and_expression '&' equality_expression
  ;

bitwise_xor_expression
  : bitwise_and_expression
  | bitwise_xor_expression '^' bitwise_and_expression
  ;

bitwise_or_expression
  : bitwise_xor_expression
  | bitwise_or_expression '|' bitwise_xor_expression
  ;

logical_and_expression
  : bitwise_or_expression
  | logical_and_expression '&' '&' logical_and_expression
  ;

conditional_expression
  : logical_or_expression
  | logical_or_expression '?' assignment_expression ':' assignment_expression
  ;

assignment_expression
  : conditional_expression
  | call_expression '=' assignment_expression
  | call_expression compound_assignment assignment_expression
  ;

compound_assignment
  : '*' '='
  | '/' '='
  | '%' '='
  | '+' '='
  | '-' '='
  | '<' '<' '='
  | '>' '>' '='
  | '>' '>' '>' '='
  | '&' '='
  | '^' '='
  | '|' '='
  ;

expression
  : assignment_expression
  | expression ',' assignment_expression
  ;

optional_expression
  : expression
  | EMPTY
  ;

statement
  : empty_statement
  | epxression_statement semicolon
  | variable_definition semicolon
  | block
  | labled_statement
  | if_statement
  | while_statement
  | for_statement
  | conditional_statement semicolon
  | break_statement semicolon
  | continue_statement semicolon
  | return_statement semicolon
  ;

semicolon
  : ';'
  ;

empty_statement
  : ';'
  ;

expression_statement
  : expression
  ;

variable_definition
  : VAR variable_declaration_list
  ;

variable_declaration_list
  : variable_declaration
  | variable_declaration_list ',' variable_declaration
  ;

variable_declaration
  : IDENTIFIER variable_initializer
  ;

variable_initializer
  : EMPTY
  | '=' assignment_expression
  ;

block
  : '{' block_statements '}'
  ;

block_statements
  : EMPTY
  | block_statement_prefix
  ;

block_statement_prefix
  : statement
  | block_statement_prefix statement
  ;

labled_statement
  : IDENTIFIER ':' statement
  ;

if_statement
  : IF paranthesized_expression statement if_tail
  ;

if_tail
	: ELSE statement
	| EMPTY
	;

while_statement
  : WHILE paranthesized_expression statement
  ;

for_statement
  : FOR '(' for_initializer ';' optional_expression ';' optional_expression ')' statement
  | FOR '(' for_in_binding IN expression ')' statement
  ;

for_initializer
  : EMPTY
  | expression 
  | VAR variable_declaration_list
  ;

for_in_binding
  : call_expression
  | VAR variable_declaration
  ;

break_statement
  : BREAK
  ;

continue_statement
  : CONTINUE
  ;

return_statement
  : RETURN expression
  ;

function_definition
  : named_function
  ;

anonymous_function
  : FUNCTION formal_parameters_and_body
  ;

named_function
  : FUNCTION IDENTIFIER formal_parameters_and_body
  ;

formal_parameters_and_body
  : '(' formal_parameters ')' '{' top_statements '}'
  ;

formal_parameters
  : EMPTY
  | formal_parameters_prefix
  ;

formal_parameters_prefix
  : formal_parameter
  | formal_parameters_prefix ',' formal_parameter
  ;

formal_parameter
  : IDENTIFIER
  ;

program
  : top_statements
  ;

top_statements
  : EMPTY
  | top_statements_prefix
  ;

top_statements_prefix
  : top_statement
  | top_statements_prefix top_statement
  ;

top_statement
  : statement
  | function_definition
  ;
