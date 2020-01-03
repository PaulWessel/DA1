/* $Id: checkfornonascii.c 183 2015-05-13 04:57:16Z pwessel $
 *
 * Simple code to check for non-ASCII characters in the Latex files.
*/

#include <stdio.h>
#include <ctype.h>
int main() {
	int k = 1, c, p = 0;
	while ((c = fgetc (stdin)) != EOF) {
		p++;
        	if (!isascii (c))
             		printf("Line: %d. Non-ASCII character [%c] in position %d\n", k, c, p);
		if (c == '\n') k++, p = 0;
	}
}
