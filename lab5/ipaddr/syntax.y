%{
    #define YYSTYPE char *
    #include "lex.yy.c"
    #include "stdlib.h"
    int yyerror(char* s);
%}

%token X
%token DOT
%token COLON

%%

// please design a grammar for the valid ip addresses and provide necessary semantic actions for production rules
Ip: Ipv {printf("IPv%d\n", $1);}
    ;
Ipv: V4 DOT V4 DOT V4 DOT V4 {$$ = 4;}
    |V6 COLON V6 COLON V6 COLON V6 COLON V6 COLON V6 COLON V6 COLON V6 {$$ = 6;}
    ;
V4: X {if(atoi($1) < 0 || atoi($1) > 255 || (strlen($1)>1 && $1[0] == '0')) return yyerror($1); $$ = $1;}
    ;
V6: X {if(strlen($1) < 1 || strlen($1) > 4) return yyerror($1); $$ = $1;}
    ;
%%

int yyerror(char* s) {
    fprintf(stderr, "%s\n", "Invalid");
    return 1;
}
int main() {
    yyparse();
}
