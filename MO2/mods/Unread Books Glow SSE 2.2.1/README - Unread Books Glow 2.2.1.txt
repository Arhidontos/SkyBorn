Version 2.2.1
This Mod is now Converted with the new Creation Kit

Version 2.2.0
This Mod is created by duggelz but he allow to modify it as long as i credit him.
I just unpacked the BSA File and it works perfectly with the Special Edition except the SKSE Features.
Original file: http://www.nexusmods.com/skyrim/mods/10012/?

Original Description:

Unread Books Glow by duggelz

Books which you have not read yet will have a visible glow. When you
read a book for the first time, its glow will disappear. All copies
of the same title are considered the same book, so once you've read
one "Cats of Skyrim", you've read them all.

== Features ==

* Unread books glow and have an "*" before their name
* Uses SKSE and SkyUI if installed, but doesn't require them
* Recognizes all books your character has previously read (SKSE)
* Tracks books from any mod or DLC
* Spell tomes are green, skill books are red, quest books and regular
books are various shades of blue
* Settings configured in-game via SkyUI or spell

== Install ==

Nexus Mod Manager: Click the "Download with Manager" button. Once
it's downloaded, in the Nexus Mod Manager, click on the "Mods" tab,
and double-click on "Unread Books Glow" to activate it.

If you have SKSE version 1.6.8 or better installed, several features
of this mod will work better. If you have SkyUI version 3.1 or better
installed, you can use the Mod Configuration Menu to access this mod's
options. Both are highly recommended.

== Upgrade ==

If you're upgrading from a previous version, you might see odd
behavior until you enter a new location.

== Uninstall ==

Move your character to an interior location that has no unread books.
Save your game and exit Skyrim.

Nexus Mod Manager: Click on the "Mods" tab, double-click on "Unread
Books Glow" to deactivate it, then click "Delete".

== Limitations ==

* If you don't have SKSE version 1.6.8 or above, books you've read
before installing this mod are not recorded. You will have to read
them again.
* Only the nearest 100 books are affected in any location.
* Books in containers and merchant inventories are usually not
recognized as unread.
* Quest books added by DLC and other mods are treated as "plain" books.
Spell tomes and skill books should work fine.

== Configuration ==

If you have SkyUI installed, press "Escape", click on "Mod
Configuration", and then "Unread Books Glow". You will see a page
with various options.

If you do not have SkyUI installed, open the in-game "Magic" menu,
select "Powers", and select "{Unread Books Glow Settings}". Then exit
the menu. Your character will appear to have a spell readied. Cast
the spell as normal (usually just clicking the left mouse button) and
a settings menu will appear. It has less options than the SkyUI menu.

== Compatibility ==

This mod should automatically handle books added by DLC and other
mods. However, there might be conflicts with other mods that change
the behavior of books in general. If you find something noteworthy
that does or doesn't work, let me know and I will add it here.

Compatible:
* Better Skill and Quest Books Names
* Book Covers Skyrim
* Bookshelves Script SKSE
* Improved Skill Books
* Non-Automatic Skill Books
* Read And Learn Speechcraft Speech
* Sometimes Pick Up Books

Maybe Compatible:
* Unlimited Bookshelves (works for some people, not for others)

Probably Not Compatible:
* Deja Vu - I Already Read It
* Mark Books as Read

== Distribution ==

This file is available on the Skyrim Nexus and the Steam Workshop.

== Translations ==

This mod includes translations contributed by various helpful people.
You will need SKSE and SkyUI installed to see translations. I will
not be be using the older method of creating multilingual Skyrim mods,
because it's horrible. This means the "{Unread Books Glow Settings}"
power will always be in English. Other people may provide translated
.esp files, in which case I'll link to them from here.

Unread Books Glow - German
Unread Books Glow - Italian
Unread Books Glow - Polish
Unread Books Glow - Portuguese, Brazilian

Localization is tricky, and hard to test. Accent marks always seem to
get mangled one way or another. So if you spot an error, post a
comment and I'll look at it.

Translations for past and present versions of this mod were
contributed by the following people:

Czech: miraclefreak
English: me
French: brundlemouche, Maxheero
German: norden, Wingardium, TKHBMVP, quetzalcoatl666, 9Strike
Italian: Claska, Lucasssvt, Ciccigomma
Japanese: m0m
Polish: kolabor, ExplorR
Portuguese: R3v3r3ndo
Russian: Eriko, DJ_Kovrik
Spanish: Frodo45127, me + 8th grade Spanish

Any errors are likely to be mine, not the translators. Germans, you
must love Skyrim, four different people gave me five different
translations, so I went line by line picking the translation chosen by
the most people, and used Google Translate as a tie breaker.

== Credits ==

Bethesda for the Skyrim Creation Kit.
Fallout Mod Manager (FOMM) for TESsnip and BSA Browser.
LHammonds Readme Generator.
The SKSE team for tireless work.
The SkyUI team for awesome improvements.
The Tes5Edit team for their tools.
The Skyrim Nexus for hosting.

== History ==

1.0, 2012/02/11 - Initial release.
1.1, 2012/02/16 - Complete rewrite.
1.2, 2012/02/20 - Fixed various bugs, made "Medium" the default for new games.
1.3, 2012/02/24 - Second attempt to fix "books stop glowing" bug.
1.4, 2012/07/22 - Updated for Skyrim version 1.6.
1.5, 2012/08/04 - Dawnguard DLC support, minor bugfixes, minor change for SkyUI.
1.5.1, 2012/08/18 - Identical to 1.5, version bump for Skyrim Nexus problem.
1.5.2, 2012/09/10 - Added Czech translation.
1.5.3, 2012/09/29 - Added Polish translation.
2.0, 2013/01/15 - Added major SKSE and SkyUI enhancements.
2.0.1, 2013/01/15 - Stop using Book.IsRead(), fixed skill book color.
2.1.0, 2013/02/21 - Replaced "(Unread)" with "*", added quest book tracking,
updated handling of SKSE Book.IsRead(),
reorganized MCM menu, added translation support.
2.2.0, 2014/01/04 - Fixed bug that made the configuration power disappear.
Added MCM translations for every language but Japanese.