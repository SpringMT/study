#ifndef TOKEN_H_INCLUDED
#define TOKEN_H_INCLUDED

typedef enum {
  BAD_TOKEN,
  NUMBER_TOKEN,
  ADD_OPERATION_TOKEN,
  SUB_OPERATION_TOKEN,
  MUL_OPERATION_TOKEN,
  DIV_OPERATION_TOKEN,
  END_OF_LINE_TOKEN,
} TokenKind;

#define MAX_TOKEN_SIZE (100)

typedef struct {
  TokenKind kind;
  double  value;
  char    str[MAX_TOKEN_SIZE];
} Token;

void set_line(char *line);
void get_line(Token *token);

#endif /* TOKEN_H_INCLUDED */

