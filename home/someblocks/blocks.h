static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"", "amixer sget 'Master' | grep Right | awk -F'[][]' '{print $2$4}' | sed '2q;d'",   1,		0},
	{"", "nmcli -f DEVICE,NAME --terse con show",   			30,		0},
	{"", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",		30,		0},
	{"", "acpi | awk -F' ' '{print $2, $4, $3}' | tr -d ',' | tr '\n' ';'",			30,		0},
	{"", "date '+%b %d (%a) %I:%M%p'",					60,		0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
