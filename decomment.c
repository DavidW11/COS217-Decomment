# include <stdio.h>

/* define constants representing each of 8 states in the DFA */
enum State {NORMAL, AFTER_SLASH, IN_COMMENT, AFTER_STAR, 
            IN_STRING, IN_CHAR, BACKSLASH_STRING, BACKSLASH_CHAR};

/* declare state handling functions to be used in main */
enum State handleNormal(int c);
enum State handleAfterSlash(int c);
enum State handleInComment(int c);
enum State handleAfterStar(int c);
enum State handleInString(int c);
enum State handleBackslashString(int c);
enum State handleInChar(int c);
enum State handleBackslashChar(int c);

/* main function called during execution*/
int main(void) {
    /* tracks current number of lines read*/
    int lineCount = 1;
    /* tracks last line at which a comment began */
    int errorLine = 1;
    /* current character in file */
    int c;
    /* current state of DFA */
    enum State state = NORMAL;

    /* reads characters until end of file */
    while ((c=getchar())!=EOF) {
        /* increment line count at every newline character */
        if (c=='\n') {
            lineCount+=1;
        }
        /* only update line of last comment when not in comment */
        if (state!=IN_COMMENT && state!=AFTER_STAR) {
            errorLine = lineCount;
        }
        switch(state) {
            case NORMAL:
                state = handleNormal(c);
                break;
            case AFTER_SLASH:
                state = handleAfterSlash(c);
                break;
            case IN_COMMENT:
                state = handleInComment(c);
                break;
            case AFTER_STAR:
                state = handleAfterStar(c);
                break;
            case IN_STRING:
                state = handleInString(c);
                break;
            case BACKSLASH_STRING:
                state = handleBackslashString(c);
                break;
            case IN_CHAR:
                state = handleInChar(c);
                break;
            case BACKSLASH_CHAR:
                state = handleBackslashChar(c);
                break;
        }
    }
    /* edge case: if last character of file is a slash */
    if (state==AFTER_SLASH) {
        putchar('/');
    }
    /* rejection states - file has ended while inside comment */
    if (state==IN_COMMENT || state==AFTER_STAR) {
        fprintf(stderr, "Error: line %i: unterminated comment\n", 
                errorLine);
        return 1;
    }
    else {
        return 0;
    }
}

/* implement the NORMAL state of the DFA. 
c is the current DFA character. 
check for beginning of either a comment or a literal and write
character if it does not begin a comment. 
return next DFA state. */
enum State handleNormal(int c) {
    enum State state;

    if (c=='/') {
        state = AFTER_SLASH;
    }
    else if (c=='"') {
        state = IN_STRING;
        putchar(c);
    }
    else if (c=='\'') {
        state = IN_CHAR;
        putchar(c);
    }
    else {
        state = NORMAL;
        putchar(c);
    }

    return state;
}

/* implement the AFTER_SLASH state of the DFA. 
c is the current DFA character. 
check if character marks the beginning of a comment (*) and write 
a space. otherwise, write a slash and process the character under
NORMAL circumstances.
return next DFA state. */
enum State handleAfterSlash(int c) {
    enum State state;

    if (c=='*') {
        state = IN_COMMENT;
        putchar(' ');
    }
    else {
        putchar('/');
        state = handleNormal(c);
    }

    return state;
}

/* implement the IN_COMMENT state of the DFA. 
c is the current DFA character. 
check if character implies the end of a comment (*). only write newline 
characters. 
return next DFA state. */
enum State handleInComment(int c) {
    enum State state;

    if (c=='*') {
        state = AFTER_STAR;
    }
    else if (c=='\n') {
        state = IN_COMMENT;
        putchar('\n');
    }
    else {
        state = IN_COMMENT;
    }

    return state;
}

/* implement the AFTER_STAR state of the DFA. 
c is the current DFA character. 
change back to NORMAL state if character marks end of comment (/).
otherwise, treat character under IN_COMMENT circumstances.
return next DFA state. */
enum State handleAfterStar(int c) {
    enum State state;

    if (c=='/') {
        state = NORMAL;
    }
    else {
        state = handleInComment(c);
    }

    return state;
}

/* implement the IN_STRING state of the DFA. 
c is the current DFA character. 
change back to NORMAL state if character marks end of string (").
check if character is backslash and always write character to stdout.
return next DFA state. */
enum State handleInString(int c) {
    enum State state;

    if (c=='"') {
        state = NORMAL;
        putchar(c);
    }
    else if (c=='\\') {
        state = BACKSLASH_STRING;
        putchar(c);
    }
    else {
        state = IN_STRING;
        putchar(c);
    }

    return state;
}

/* implement the BACKSLASH_STRING state of the DFA.
c is the current DFA character. 
simply writes character and returns to IN_STRING state.
return next DFA state. */
enum State handleBackslashString(int c) {
    enum State state = IN_STRING;

    putchar(c);
    return state;
}

/* implement the IN_CHAR state of the DFA. 
c is the current DFA character. 
change back to NORMAL state if character marks end of literal (').
check if character is backslash and always write character to stdout.
return next DFA state. */
enum State handleInChar(int c) {
    enum State state;

    if (c=='\'') {
        state = NORMAL;
        putchar(c);
    }
    else if (c=='\\') {
        state = BACKSLASH_CHAR;
        putchar(c);
    }
    else {
        state = IN_CHAR;
        putchar(c);
    }

    return state;
}

/* implement the BACKSLASH_CHAR state of the DFA.
c is the current DFA character. 
simply writes character and returns to IN_CHAR state.
return next DFA state. */
enum State handleBackslashChar(int c) {
    enum State state = IN_CHAR;

    putchar(c);
    return state;
}