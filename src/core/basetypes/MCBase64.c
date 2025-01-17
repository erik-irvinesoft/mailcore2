//
//  MCBase64.c
//  mailcore2
//
//  Created by DINH Viêt Hoà on 7/30/13.
//  Copyright (c) 2013 MailCore. All rights reserved.
//

#include "MCBase64.h"

#include <stdlib.h>

#define CHAR64(c)  (((c) < 0 || (c) > 127) ? -1 : index_64[(c)])

static char index_64[128] = {
    -1,-1,-1,-1, -1,-1,-1,-1, -1,-1,-1,-1, -1,-1,-1,-1,
    -1,-1,-1,-1, -1,-1,-1,-1, -1,-1,-1,-1, -1,-1,-1,-1,
    -1,-1,-1,-1, -1,-1,-1,-1, -1,-1,-1,62, -1,-1,-1,63,
    52,53,54,55, 56,57,58,59, 60,61,-1,-1, -1,-1,-1,-1,
    -1, 0, 1, 2,  3, 4, 5, 6,  7, 8, 9,10, 11,12,13,14,
    15,16,17,18, 19,20,21,22, 23,24,25,-1, -1,-1,-1,-1,
    -1,26,27,28, 29,30,31,32, 33,34,35,36, 37,38,39,40,
    41,42,43,44, 45,46,47,48, 49,50,51,-1, -1,-1,-1,-1
};

static char basis_64[] =
"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

char * MCEncodeBase64(const char * in, int len)
{
    char * output, * tmp;
    unsigned char oval;
    int out_len;
    const unsigned char * uin = (const unsigned char *) in;
    
    out_len = ((len + 2) / 3 * 4) + 1;
    
    if ((len > 0) && (in == NULL))
        return NULL;
    
    output = malloc(out_len);
    if (!output)
        return NULL;
    
    tmp = output;
    while (len >= 3) {
        *tmp++ = basis_64[uin[0] >> 2];
        *tmp++ = basis_64[((uin[0] << 4) & 0x30) | (uin[1] >> 4)];
        *tmp++ = basis_64[((uin[1] << 2) & 0x3c) | (uin[2] >> 6)];
        *tmp++ = basis_64[uin[2] & 0x3f];
        uin += 3;
        len -= 3;
    }
    if (len > 0) {
        *tmp++ = basis_64[uin[0] >> 2];
        oval = (uin[0] << 4) & 0x30;
        if (len > 1) oval |= uin[1] >> 4;
        *tmp++ = basis_64[oval];
        *tmp++ = (len < 2) ? '=' : basis_64[(uin[1] << 2) & 0x3c];
        *tmp++ = '=';
    }
    
    *tmp = '\0';
    
    return output;
}

char * MCDecodeBase64(const char * in, int len, int * p_outlen)
{
    char * output, * out;
    int i, c1, c2, c3, c4;
    int max_out_len;
    
    max_out_len = ((len + 3) * 4 / 3) + 1;
    
    output = malloc(max_out_len);
    if (output == NULL)
        return NULL;
    out = output;
    
    if (in[0] == '+' && in[1] == ' ')
        in += 2;
    
    for (i = 0; i < (len / 4); i++) {
        c1 = in[0];
        c2 = in[1];
        c3 = in[2];
        c4 = in[3];
        if (CHAR64(c1) == -1 || CHAR64(c2) == -1 ||
            (c3 != '=' && CHAR64(c3) == -1) ||
            (c4 != '=' && CHAR64(c4) == -1)) {
            free(out);
            return NULL;
        }
        
        in += 4;
        *output++ = (CHAR64(c1) << 2) | (CHAR64(c2) >> 4);
        
        if (c3 != '=') {
            *output++ = ((CHAR64(c2) << 4) & 0xf0) | (CHAR64(c3) >> 2);
            
            if (c4 != '=') {
                *output++ = ((CHAR64(c3) << 6) & 0xc0) | CHAR64(c4);
            }
        }
    }
    
    *output = 0;
    if (p_outlen != NULL) {
        *p_outlen = (int) (output - out);
    }

    return out;
}

char * MCDecodeBase64ByLines(const char * in, int len, int * p_outlen) {
    if (len < 4) {
        return NULL;
    }

    char * output, * out;
    int c1, c2, c3, c4;
    const char * end = in + len;
    char * end_of_last_line;

    output = malloc((len * 3 / 4) + 1);
    if (output == NULL)
        return NULL;
    out = output;
    end_of_last_line = out;

    if (in[0] == '+' && in[1] == ' ')
        in += 2;

    int isEOL = 0;
    
    while (in < end) {
        
        while (isEOL && in < end && in[0] == 0x20) {
            in++;
        }
        
        isEOL = 0;
        
        if (in == end) {
            break;
        }
        
        if (in[0] == 0x0a || in[0] == 0x0d) {
            end_of_last_line = output;
            isEOL = 1;
            in++;
            continue;
        }

        c1 = in[0];
        in++;

        c2 = 0;
        c3 = 0;
        c4 = 0;

        while (in < end) {
            
            while (isEOL && in < end && in[0] == 0x20) {
                in++;
            }
            
            isEOL = 0;
            
            if (in == end) {
                break;
            }
            
            if (in[0] == 0x0a || in[0] == 0x0d) {
                isEOL = 1;
                in++;
                continue;
            }
            c2 = in[0];
            in++;
            break;
        }

        while (in < end) {
            
            while (isEOL && in < end && in[0] == 0x20) {
                in++;
            }
            
            isEOL = 0;
            
            if (in == end) {
                break;
            }
            
            if (in[0] == 0x0a || in[0] == 0x0d) {
                isEOL = 1;
                in++;
                continue;
            }
            c3 = in[0];
            in++;
            break;
        }

        while (in < end) {
            
            while (isEOL && in < end && in[0] == 0x20) {
                in++;
            }
            
            isEOL = 0;
            
            if (in == end) {
                break;
            }
            
            if (in[0] == 0x0a || in[0] == 0x0d) {
                isEOL = 1;
                in++;
                continue;
            }
            c4 = in[0];
            in++;
            break;
        }

        if (CHAR64(c1) == -1 || CHAR64(c2) == -1) {
            output = end_of_last_line;
            break;
        }

        if (c3 > 0) {
            if (c3 != '=' && CHAR64(c3) == -1) {
                output = end_of_last_line;
                break;
            }

            if (c4 > 0 && c4 != '=' && CHAR64(c4) == -1) {
                output = end_of_last_line;
                break;
            }
        }

        *output++ = (CHAR64(c1) << 2) | (CHAR64(c2) >> 4);

        if (c3 != 0 && c3 != '=') {
            *output++ = ((CHAR64(c2) << 4) & 0xf0) | (CHAR64(c3) >> 2);

            if (c4 != 0 && c4 != '=') {
                *output++ = ((CHAR64(c3) << 6) & 0xc0) | CHAR64(c4);
            }
        }
    }

    *output = 0;
    if (p_outlen != NULL) {
        *p_outlen = (int) (output - out);
    }

    return out;
}
