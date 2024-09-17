# include <stdio.h>

enum State handleNormal(int c);
enum State handleAfterSlash(int c);
enum State handleInComment(int c);
enum State handleAfterStar(int c);
enum State handleInString(int c);
enum State handleBackslashString(int c);
enum State handleInChar(int c);
enum State handleBackslashChar(int c);

/* TODO: count lines, exit failure, character literals */

enum State {NORMAL, AFTER_SLASH, IN_COMMENT, AFTER_STAR, IN_STRING, IN_CHAR, BACKSLASH_STRING, BACKSLASH_CHAR};

int main(void) {
    int lineCount = 1;
    int c;
    enum State state = NORMAL;

    while ((c=getchar())!=EOF) {
        if (c=='\n') {
            lineCount+=1;
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
    if (state==IN_COMMENT || state==AFTER_STAR) {
        fprintf(stderr, "Error: line %i: unterminated comment", lineCount);
    }
    else {
        return 0;
    }
}

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

enum State handleAfterStar(int c) {
    enum State state;

    if (c=='/') {
        state = NORMAL;
    }
    else {
        state = IN_COMMENT;
    }

    return state;
}

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

enum State handleBackslashString(int c) {
    enum State state = IN_STRING;

    putchar(c);
    return state;
}

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

enum State handleBackslashChar(int c) {
    enum State state = IN_CHAR;

    putchar(c);
    return state;
}