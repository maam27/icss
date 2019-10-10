grammar ICSS;

//--- LEXER: ---
// IF support:
IF: 'if';
BOX_BRACKET_OPEN: '[';
BOX_BRACKET_CLOSE: ']';


//Literals
TRUE: 'TRUE';
FALSE: 'FALSE';
PIXELSIZE: [0-9]+ 'px';
PERCENTAGE: [0-9]+ '%';
SCALAR: [0-9]+;

//Color value takes precedence over id idents
COLOR: '#' [0-9a-f] [0-9a-f] [0-9a-f] [0-9a-f] [0-9a-f] [0-9a-f];

//Specific identifiers for id's and css classes
ID_IDENT: '#' [a-z0-9\-]+;
CLASS_IDENT: '.' [a-z0-9\-]+;

//General identifiers
LOWER_IDENT: [a-z] [a-z0-9\-]*;
CAPITAL_IDENT: [A-Z] [A-Za-z0-9_]*;

//All whitespace is skipped
WS: [ \t\r\n]+ -> skip;

//
OPEN_BRACE: '{';
CLOSE_BRACE: '}';
SEMICOLON: ';';
COLON: ':';
PLUS: '+';
MIN: '-';
MUL: '*';
ASSIGNMENT_OPERATOR: ':=';

//--- PARSER: ---
stylesheet: (variable|stylerule)*;
variable: CAPITAL_IDENT ASSIGNMENT_OPERATOR (value|expression) SEMICOLON;

//styles
stylerule: (LOWER_IDENT|ID_IDENT|CLASS_IDENT) OPEN_BRACE properties CLOSE_BRACE;
properties: (property |if | variable)*;
property: LOWER_IDENT COLON (value|expression) SEMICOLON;

//values
value:  SCALAR (PERCENTAGE)? | STRING | COLOR | PIXELSIZE | booleanValue | CAPITAL_IDENT;
booleanValue: TRUE | FALSE;
booleanExpression:booleanValue | CAPITAL_IDENT;
//if
if:IF BOX_BRACKET_OPEN booleanExpression BOX_BRACKET_CLOSE OPEN_BRACE properties CLOSE_BRACE;

//calculations
expression: value (operator value)+;
operator:PLUS|MIN|MUL|COLON;
