# Itachi
```cpp
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#666666";
static const char col_gray4[]       = "#888888";
static const char col_purple1[]     = "#3c1d63";
static const char col_purple2[]     = "#673c9e";
static const char col_cyan[]        = "#222222";

static const char *colors[][3]      = {
	[SchemeNorm] 		= 	{ col_gray3,	 col_purple2, 	col_white  },
	[SchemeSel]  		= 	{ col_gray4,	 col_purple1,  	col_white  },
	[SchemeStatus]  	= 	{ col_white,	 col_gray1,  	col_white  },
	[SchemeTagsSel]  	= 	{ col_white,	 col_gray1,  	col_white  },
    [SchemeTagsNorm]  	= 	{ col_white,	 col_gray2,  	col_white  },
    [SchemeInfoSel]  	= 	{ col_white	,	 col_gray1,  	col_white  },
    [SchemeInfoNorm]  	= 	{ col_gray3,	 col_gray2,  	col_white  },
};
```
# Itachi #
# Arya
```cpp
static const char col_gray1[]       = "#3c4142";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#a7cbe0";
static const char col_gray4[]       = "#aaaaaa";
static const char col_bluish_white[]= "#698795";
static const char col_purple1[]     = "#3c1d63";
static const char col_purple2[]     = "#673c9e";
static const char col_cyan[]        = "#222222";
static const char *colors[][3]      = {
	[SchemeNorm] 		= 	{ col_gray3,	 col_purple2, 	col_white },
	[SchemeSel]  		= 	{ col_gray4,	 col_purple1,  	col_white },
	[SchemeStatus]  	= 	{ col_black,	 col_gray3,		col_white  },
	[SchemeTagsSel]  	= 	{ "#68f53d",	 col_gray2,  	col_white  },
    [SchemeTagsNorm]  	= 	{ col_black,	 col_gray3,  	col_white  },
    [SchemeInfoSel]  	= 	{ col_white,	 col_cyan,  	col_white  },
    [SchemeInfoNorm]  	= 	{ col_gray3,	 col_gray3,  	col_white  },
};
```
# Arya #
# Documentation
```cpp
	/*               			fg 		        bg  	       border   */
	[SchemeStatus]  	= 	{ "#000000",	 col_gray3,		"#111111"  }, // Statusbar right {text,background,not used but cannot be empty}
	[SchemeTagsSel]  	= 	{ "#68f53d",	 col_gray2,  	"#000000"  }, // Tagbar left selected {text,background,not used but cannot be empty}
    [SchemeTagsNorm]  	= 	{ "#000000",	 col_gray3,  	"#000000"  }, // Tagbar left unselected {text,background,not used but cannot be empty}
    [SchemeInfoSel]  	= 	{ "#ffffff",	 col_cyan,  	"#000000"  }, // infobar middle  selected {text,background,not used but cannot be empty}
    [SchemeInfoNorm]  	= 	{ col_gray3,	 col_gray3,  	"#000000"  }, // infobar middle  unselected {text,background,not used but cannot be empty}
```
# Documentation #