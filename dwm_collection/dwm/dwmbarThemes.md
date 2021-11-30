# Itachi [ Black ]
```cpp
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#666666";
static const char col_gray4[]       = "#888888";
static const char col_purple1[]     = "#3c1d63";
static const char col_purple2[]     = "#673c9e";
static const char col_cyan[]        = "#222222";
static const char col_black[] 		= "#000000";
static const char col_white[] 		= "#ffffff";

static const char *colors[][3]      = {
	/*               			fg 		        bg  	       border   */
	[SchemeNorm] 		= 	{ col_gray3,	 col_purple2, 	col_black  },
	[SchemeSel]  		= 	{ col_gray4,	 col_purple1,  	col_black  },
	[SchemeStatus]  	= 	{ col_white,	 col_gray1,  	col_black  }, // Statusbar right {text,background,not used but cannot be empty}
	[SchemeTagsSel]  	= 	{ col_white,	 col_gray1,  	col_black  }, // Tagbar left selected {text,background,not used but cannot be empty}
    [SchemeTagsNorm]  	= 	{ col_white,	 col_gray2,  	col_black  }, // Tagbar left unselected {text,background,not used but cannot be empty}
    [SchemeInfoSel]  	= 	{ col_white	,	 col_gray1,  	col_black  }, // infobar middle  selected {text,background,not used but cannot be empty}
    [SchemeInfoNorm]  	= 	{ col_gray3,	 col_gray2,  	col_black  }, // infobar middle  unselected {text,background,not used but cannot be empty}
};
```
# Arya [ White ]
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
	/*               			fg 		        bg  	       border   */
	[SchemeNorm] 		= 	{ col_gray3,	 col_purple2, 	col_purple1 },
	[SchemeSel]  		= 	{ col_gray4,	 col_purple1,  	col_cyan  },
	[SchemeStatus]  	= 	{ "#000000",	 col_gray3,		"#111111"  }, // Statusbar right {text,background,not used but cannot be empty}
	[SchemeTagsSel]  	= 	{ "#68f53d",	 col_gray2,  	"#000000"  }, // Tagbar left selected {text,background,not used but cannot be empty}
    [SchemeTagsNorm]  	= 	{ "#000000",	 col_gray3,  	"#000000"  }, // Tagbar left unselected {text,background,not used but cannot be empty}
    [SchemeInfoSel]  	= 	{ "#ffffff",	 col_cyan,  	"#000000"  }, // infobar middle  selected {text,background,not used but cannot be empty}
    [SchemeInfoNorm]  	= 	{ col_gray3,	 col_gray3,  	"#000000"  }, // infobar middle  unselected {text,background,not used but cannot be empty}
};
```
