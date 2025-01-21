...

typedef union {
  int i;
  unsigned int ui;
  float f;
  const void *v;
} Arg;

...

typedef struct {
  unsigned int mod;
  KeySym keysym;
  void (*func)(const Arg *);
  const Arg arg;
} Key;

...

static Key keys[] = {
  /* modifier          key        function    argument */
  { MODKEY,            XK_p,      spawn,      {.v = dmenucmd } },
  { MODKEY|ShiftMask,  XK_Return, spawn,      {.v = termcmd } },
  { MODKEY,            XK_b,      togglebar,  {0} },
  { MODKEY,            XK_j,      focusstack, {.i = +1 } },
  { MODKEY,            XK_k,      focusstack, {.i = -1 } },
  { MODKEY,            XK_i,      incnmaster, {.i = +1 } },
  { MODKEY,            XK_d,      incnmaster, {.i = -1 } },
  { MODKEY,            XK_h,      setmfact,   {.f = -0.05} },
  { MODKEY,            XK_l,      setmfact,   {.f = +0.05} },
  { MODKEY,            XK_Return, zoom,       {0} },
  { MODKEY,            XK_Tab,    view,       {0} },
  { MODKEY|ShiftMask,  XK_c,      killclient, {0} },
  { MODKEY,            XK_t,      setlayout,  {.v = &layouts[0]} },
  { MODKEY,            XK_f,      setlayout,  {.v = &layouts[1]} },
  { MODKEY,            XK_m,      setlayout,  {.v = &layouts[2]} },

...

void
spawn(const Arg *arg)
{
...

void
focusstack(const Arg *arg)
{

...

