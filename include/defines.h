/* generally useful macros and inlines */
/* $Id: defines.h,v 1.1 1993/05/26 23:22:27 coleman Exp $ */

#ifndef defines_h
#define defines_h

#ifdef NDEBUG
# define INLINE inline
#else
# define INLINE /* */
#endif

#define max(X,Y) ((X) < (Y) ? (Y) : (X))
#define min(X,Y) ((X) > (Y) ? (Y) : (X))

static INLINE aglo_real sqr(aglo_real d) {
	return d*d;
}

static INLINE double fmax(aglo_real d1, aglo_real d2) {
	return (d1 < d2) ? d2 : d1;
}

static INLINE aglo_real fmin(aglo_real d1, aglo_real d2) {
	return (d1 > d2) ? d2 : d1;
}

#endif
