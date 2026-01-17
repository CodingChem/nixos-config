#include <X11/XF86keysym.h>
/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "JetBrainsMono Nerd Font:size=16" };
static const char dmenufont[]       = "JetBrainsMono Nerd Font:size=16";
// Catppuccin Macchiato Palette
static const char col_base[]        = "#24273a"; // Background
static const char col_text[]        = "#cad3f5"; // Foreground
static const char col_surface0[]    = "#363a4f"; // Unfocused border
static const char col_accent[]      = "#8aadf4"; // Active border/bar (Blue)
static const char col_active_text[] = "#181926"; // Text on active bar (Crust)

static const char *colors[][3]      = {
	/* fg               bg          border   */
	[SchemeNorm] = { col_text,        col_base,   col_surface0 },
	[SchemeSel]  = { col_active_text, col_accent, col_accent   },
};

/* tagging */
static const char *tags[] = { "", "", "", "", "", "󰓓", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class               instance             title       tags mask     isfloating   monitor */
	{ "Alacritty",         NULL,                NULL,       1 << 0,       0,           -1 },
	{ "kitty",             "kitty",             NULL,       1 << 0,       0,           -1 },
	{ "zen",               "Navigator",         NULL,       1 << 1,       0,           -1 },
	{ "Chromium-browser",  "gemini.google.com", NULL,       1 << 2,       0,           -1 },
	{ "obsidian",          NULL,                NULL,       1 << 3,       0,           -1 },
	{ "Spotify",           NULL,                NULL,       1 << 4,       0,           -1 },
	{ "steam",             NULL,                NULL,       1 << 5,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.66; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */
static const int refreshrate = 120;  /* refresh rate (per second) for client move/resize */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
/* Audio (PipeWire via wpctl) */
static const char *upvol[]   = { "wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%+", "-l", "1.0", NULL };
static const char *downvol[] = { "wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%-", NULL };
static const char *mutevol[] = { "wpctl", "set-mute",   "@DEFAULT_AUDIO_SINK@", "toggle", NULL };

/* Brightness (Laptop via brightnessctl) */
/* We use 5%+ and 5%- for smooth steps */
static const char *upbright[]   = { "brightnessctl", "-d", "intel_backlight", "set", "5%+", NULL };
static const char *downbright[] = { "brightnessctl", "-d", "intel_backlight", "set", "5%-", NULL };
/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_base, "-nf", col_text, "-sb", col_accent, "-sf", col_active_text, NULL };
static const char *termcmd[]  = { "@TERMINAL@", NULL };
static const char *gemini[]   = { "chromium" , "--app=https://gemini.google.com", NULL };
static const char *zen_browser[]   = { "app.zen_browser.zen", NULL };
static const char *obsidian[] = { "obsidian", NULL };
static const char *steam[] = { "steam", NULL };
static const char *spotify[] = { "spotify", NULL };
static const char *bluetooth[] = {"/home/vegard/.config/nixos/desktop/dwm/scripts/bluetooth-script", NULL };
static const char *power_menu[] = {"/home/vegard/.config/nixos/desktop/dwm/scripts/power-script", NULL };
static const char *playpausecmd[] = { "playerctl", "play-pause", NULL };
static const char *wallpapercmd[] = { "/home/vegard/.config/nixos/desktop/dwm/scripts/wallpaper-script", NULL };

static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_a,      spawn,          {.v = gemini  }  },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY|ShiftMask,             XK_n,      spawn,          {.v = obsidian } },
	{ MODKEY|ShiftMask,             XK_g,      spawn,          {.v = steam } },
	{ MODKEY|ShiftMask,             XK_s,      spawn,          {.v = spotify } },
	{ MODKEY|ControlMask,           XK_b,      spawn,          {.v = bluetooth } },
	{ MODKEY|ControlMask,           XK_p,      spawn,          {.v = power_menu } },
	{ MODKEY|ControlMask,           XK_w,      spawn,          {.v = wallpapercmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY|ShiftMask,             XK_b,      spawn,          {.v = zen_browser } },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_w,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ 0,                            XF86XK_AudioRaiseVolume,  spawn,          {.v = upvol} },
	{ 0,                            XF86XK_AudioLowerVolume,  spawn,          {.v = downvol} },
	{ 0,                            XF86XK_AudioMute,         spawn,          {.v = mutevol} },
	{ 0,                            XF86XK_MonBrightnessUp,   spawn,          {.v = upbright} },
	{ 0,                            XF86XK_MonBrightnessDown, spawn,          {.v = downbright} },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
	{ 0,              XF86XK_AudioPlay,    spawn,          {.v = playpausecmd } },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};


